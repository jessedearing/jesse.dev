---
title: Giving VSCode a go
date: 2019-03-03 09:05:26 -0800
githubissue: 1
tags: ["Vim", "Tmux", "Editors", "Tools", "VSCode"]
---

I tried [VSCode](https://code.visualstudio.com/) for 3 weeks just because I had
been working a lot with Terraform and other members of my team mentioned the
various plugins available for Terraform. I found using VSCode to be a really
wonderful experience.
<!--more-->

## Leaving Vim, Tmux…and the Home Row

I've been stuck in the terminal exclusively for nearly 6 years now. Before that
I did a lot of work in the terminal, but had GUIs. I did a lot of .NET
development so I was based in the original Visual Studio (sans Code) for a chunk
of my career.

I like to change things up on occasion though and learn new tools. So I decided
I was going to spend a while using VSCode to see what new features there are.

One of the hardest things I had to adjust to was using my mouse more and having
to use the alt and shift keys much more. My hands were typically hitting keys
with multiple modifiers on the left side of the keyboard. ⌘⇧E for the file
explorer, ⌥⇧G for the SCM tab, ⌘⇧P for showing commands, etc. In my Vim and Tmux
bindings I typically keep everything centric to the home row. For example,
leader is mapped to comma (,) and my Tmux prefix is ctrl-a (I know this came
from screen and I never really used screen, but I like it better than ctrl-b).

I had to download the Vim keybindings for VSCode because I couldn't make the
switch wholesale to a different key set. That being said, the Vim keybindings
are wonderful! I remapped some commonly used functions in VSCode to the
keybindings I was accustomed to using with little fuss.

## Flying Colors

The performance of VSCode is awesome. A lot of times when I'm in my terminal I
see the flashes of things and artifacts left on the screen and it annoys me. It
makes sense though, the terminal comes with a lot of history and that history
has shaped the way it draws on the screen, the way it represents colors, and it
has been built on over decades. VSCode gets the benefit of being a GUI
application running on Electron so it can really take advantage of GPUs and
better redrawing.

In addition to the performance, it was great to have colors that worked without
having to do a whole lot of configuring. I just downloaded a theme and boom, it
looked like the picture.

## Extensions

The VSCode extension marketplace is awesome! There's so much to choose from and
a great interface to select them. It also gives you the number of times downloaded
metrics and last updated right on the same page so you can see what is the
community favorites and what is still active.

## Configuration

I was worried starting on this trial that I would have to cease tweaking
configuration and making custom keybindings as I was used to with Vim and Tmux,
but good for me that everything in VScode is configurable and on top of that you
can see all of the configuration options exposed via a searchable interface that
let you copy the defaults. Typically you end up having to search through Vim
docs and sometimes source code to do this so this was a pleasant change.

## It's not VSCode, it's me

Using VSCode was a great experience and I can see why so many developers are
moving to it. I'm an old command line jockey and I find myself needing to pipe
think into `sed` and `awk` more often than not so while VSCode provided an
welcome change in interface, I'm going to stick with Vim, Tmux, and iTerm2
because old habits die hard for me. My current collection of keybindings and
shortcuts that comprise my workflow has been a work in progress for about 15
years. It would be hard to give that up.
