+++
date = "2016-09-16T01:11:56-07:00"
description = ""
title = "Who’s Running that on my System: Case of the stolen CPU"
draft = false
tags = ["systems", "Golang", "Linux", "databases", "MySQL"]
+++

Last week, I found myself needing to find what application a query was originating from.
My typical method for doing this is searching through source code before I
eventually get angry that I can’t find the query originating from an ORM and
start drafting an email decreeing that all applications get distinct logins to
the database that I’ll never send because who is going to listen anyway.

I had an idea for how I can track a query all the way back to the process that
accessed it and I even scripted it.

## Connections

In MySQL every connection is mapped to a thread and each thread has an ID. When
you run SHOW PROCESSLIST in MySQL you can see all the running processes. The
information for this comes from the processlist table in the information_schema
database. This table also lists the host and the ephemeral port of the
connection. The ephemeral port exists on the client (initiating) side of a TCP
connection. So if you see a query running by using a tool like mytop and you’re
able to capture the thread ID you can be pretty sure that the connection is
still open because TCP connections are expensive and most libraries try to pool
them and reuse them.

Here is the section of the Go program I wrote to capture the host and the port.
```go
db, err := sql.Open("mysql", user+":"+password+"@tcp("+host+":3306)/information_schema")
if err != nil {
  log.Fatal(err)
}
defer db.Close()

hostWithPort := getHost(db)
if hostWithPort == nil {
  log.Println("Could not find query with that ID")
  return
}
hostAndPort := strings.Split(hostWithPort, ":")
host, port := hostAndPort[0], hostAndPort[1]

log.Printf("Host: %s  Port: %s\n", host, port)

func getHost(db *sql.DB) string {
	result, err := db.Query("select HOST from processlist where ID = ?", *pid)
	if err != nil {
		log.Panic(err)
	}

	defer result.Close()

	var host string
	for result.Next() {
		result.Scan(&host)
	}

	return host
}
```

## Hunting down the connection

Once you have the host and port you can then ssh into the host that you were
given to find what process is connected to the port. This can be discovered
using a program like lsof. There are many ways to find the port a process is
using but I am most familiar with lsof.

The Go code to SSH into a server uses the golang.org/x/crypto/ssh library and
I’ve incorporated some of my knowledge of bash.
```go
sshClient, err := setUpSSHClient(host)
if err != nil {
  log.Panic(err)
}
defer sshClient.Close()

lsofOut, err := runCmd(sshClient, "sudo lsof -i tcp:"+port+" | tail -1 | awk '{ print $2; }'")
lsofOut = strings.Trim(lsofOut, "\n\r ")
if err != nil {
  log.Panic(err)
}

psOut, err := runCmd(sshClient, "ps -p "+lsofOut+" -o pid -o etime -o command")
if err != nil {
  log.Panic(err)
}

log.Printf("PID: %s\n", lsofOut)
log.Printf("Process that owns connection:\n%s\n", psOut)

func setUpSSHClient(host string) (*ssh.Client, error) {
	privkey, err := ioutil.ReadFile(os.Getenv("HOME") + "/.ssh/id_rsa")
	if err != nil {
		return nil, err
	}
	signer, err := ssh.ParsePrivateKey(privkey)
	if err != nil {
		return nil, err
	}
	sshConfig := &ssh.ClientConfig{
		User: *sshuser,
		Auth: []ssh.AuthMethod{
			ssh.PublicKeys(signer),
		},
	}

	client, err := ssh.Dial("tcp", host+":22", sshConfig)
	if err != nil {
		return nil, err
	}

	return client, nil
}

func runCmd(client *ssh.Client, command string) (string, error) {
	sess, err := client.NewSession()
	if err != nil {
		return "", err
	}
	defer sess.Close()

	b, err := sess.CombinedOutput(command)
	if err != nil {
		return "", err
	}

	return string(b), nil
}
```
## Conclusion

This helped me find the process that was running the problematic query. I was
able to find what codebase was causing the issue and thus the team that owns
that codebase. It turns out they were in the middle of a deploy to fix the
problem because they noticed it right before I did.

Once you have found the process you can you can also other informative things
like run strace, jstack, or gdb to diagnose issues (I wouldn’t recommend doing
this in production).

Happy query hunting!
