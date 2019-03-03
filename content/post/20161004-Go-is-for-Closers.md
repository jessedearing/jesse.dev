+++
date = "2016-10-04T10:35:32-08:00"
description = ""
title = "Go is for .Close()’ers"
tags = ["Golang", "Software Development"]
+++

The `Close()` method is important to the reliability of a running program and
it's not easy to tell when it should be used.
<!--more-->

In Go the typical way to open a file or connection is this commonly seen block
of code:
```go
connection, err := net.Dial("tcp", "example.com:80")
if err != nil {
    // Do something to handle the error
    return
}
defer connection.Close()
```

That `defer connection.Close()` on line 6 plays a vital role in writing Go code
that won’t run your host machine out of memory, kernel file descriptors, or any
other transactional resource (one in which operations open, do something, then
close). All that does is put the function call on a stack that is called in LIFO
(_Ed. originally wrote FIFO_) order after the code goes out of scope. This post
aims to focus on the `Close()` method though.

## The interfaces are weak?!
Go has interfaces explicit interfaces that define a close method. The IO package
has a lot of them (all composing the Closer interface): ReadCloser, WriteCloser,
and ReadWriteCloser. Each of these indicate a struct that needs to be closed
when you’ve written or read everything or decided you’ve written or read enough.

Not everything that needs to be closed is so obviously named though. The
“database/sql” package just has a DB struct that has a Close method. Also in the
same package the Stmt type and Rows type has a Close method.

In other cases, the Close method is even further obscured by not being a part of
a defined type in the package. This is used in the “http” package all over the
place. The Body attribute in the Response struct is an io.ReadCloser.

## ABC — Always Be Closing
In Go, closing is important and defers we’re built to group closes with their
definition. In other languages there is usually a syntax for closing a
connection at the end of a block. In Java, it looks like this:
```java
try(FileInputStream input = new FileInputStream(“file.txt”)) {
  int data = input.read();
  while(data != -1) {
    System.out.print((char) data);
    data = input.read();
  }
}
```

Here’s the example in Ruby:
```ruby
File.open(‘hello.txt’, ‘r’) do |f|
 while line = f.gets
   puts line
 end
end
```

In Go we get defers. They’re fine I guess, but it does mean that we don’t get
the luxury of knowing how to Close a resource without reading the documentation.

**If you do not read the documentation for the resource you are about to use it
could mean disaster**. For example, this gem from the "net/http" package docs:

> The default HTTP client’s Transport does not attempt to reuse HTTP/1.0 or
> HTTP/1.1 TCP connections (“keep-alive”) unless the Body is read to completion
> and is closed.

Also in the aforementioned "database/sql" package if you forget to close Stmt in
MySQL this causes your Go program to allocate 16,382 prepared statements for the
connection you are using and then your Go program will be unable to allocate
prepared statements until your connection restarts.

At a basic level, eventually you will exhaust the number of file descriptors you
are allowed by the kernel. Files can be on disk files but also TCP sockets in a
Linux system.

## Only one thing matters
Read the docs look for a Close method, look for a struct name that ends in
Closer. When you review code, make sure that resources have a defer with a Close
method. Dealing with resources is something we do as engineers who write code
that run in production so we have to remember that they are managed, finite, and
must be released to the system when the program is done with them.
