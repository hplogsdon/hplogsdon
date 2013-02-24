--- 
tags: []

wordpress_url: http://dharmahacker.com/blog/?p=125
published: true
layout: post
wordpress_id: 125
categories: 
- General
description: |
  I've been playing around with more Objective-C. Not much to say about it, other than the upgrade to SnowLeopard on my iMac has broken a few things, most notably, MacVim.

author_login: uxp
author_email: uxp@bsdeviant.org
title: ObjC in TextMate
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2009-09-14 16:27:44 -06:00
author: uxp
---
I've been playing around with more Objective-C. Not much to say about it, other than the upgrade to SnowLeopard on my iMac has broken a few things, most notably, MacVim.

I love [MacVim](http://code.google.com/p/macvim/). Its so easy to use, and really took to time at all to learn. The most basic commands, :w and :q, are all you need to know to use it. Are you typing out a line with a few single words changed, such as a boilerplate HTML unordered list? Well, Yank that one line, Put it in for the next 5, and then do a replacement for those lines ":s/Link 1/Link2", then the next line ":s/Link 1/Link 3", and so on. You just saved yourself a bit of time by not typing out &lt;li&gt;&lt;a href="#"&gt;Link 1&lt;/a&gt;&lt;/li&gt; a million times, AND you learned a new command.

Well, I fell back to TextMate, which isn't all that much of a bad thing. Except a few plugins, I can get nearly the same functionality. I tried using ViMate.tmPlugin for a while, but its not quite the same thing. I have developed a (bad?) habit of saving a document by typing out "esc :w", which isn't implemented in the plugin. So the end of all my documents and source files would have a random ":w" at the end. Made for some hilarious debugging a couple nights ago.

I use the c-support vim plugin (c.vim), which I've modified for objc, which loads up a template file whenever I create a new buffer inside vim with the extension \*.m . A pretty nifty thing that auto adds my name, date created, and a line for description in the head of the file, all commented, so I can remember what I was doing when I go open it back up.

I wanted the same thing inside TextMate, so I hacked together a tiny little bundle to do that. I had no idea how to create a bundle, so this is a hack, and may or may not work for everyone. If it does, great, if it doesn't let me know and I'll try to figure it out. Anyways, here it is:

[objective-c-foundation-tool](http://hplogsdon.com/files/objective-c-foundation-tool.zip)

EDIT: Or you can grab it from my GitHub page: [Objective-C Foundation Tool.tmbundle](http://github.com/uxp/Objective-C-Foundation-Tool.tmbundle)

This has a language template for the main.c and Makefile of a simple ObjectiveC Foundation tool. As I start go get further into Cocoa, i'll probably modify it to suit my expanding needs. If any of you modify it, feel free to show me what you did, so we both can learn from one another. It also has a keybinding for "cmd+B", which starts the build process, similar to typing :make in vim.
