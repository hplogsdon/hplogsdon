--- 
tags: []

wordpress_url: http://hplogsdon.com/?p=305
published: true
layout: post
wordpress_id: 305
categories: 
- General
excerpt: "In the last post, I outlined a simple way to adding to the Ruby.framework bundle the newer version of the Ruby Language, 1.9.\r\n\
  \r\n\
  Well, as I finished that up, I started hacking around with some other code, and a friend was trying to show me something neat with Ruby-HEAD... Well, that made it difficult to add a HEAD into the bundle, since the bundle is supposed to be pretty static and not prone to constant modifications. My way works for simple things (get 1.9, end).\r\n\
  \r\n\
  He suggested I try RVM. <a href=\"http://rvm.beginrescueend.com/\">Ruby Version Manager</a> is a simple little script that will download, configure, make and install specific versions, as well as patchlevels of the Ruby language into your $HOME directory. "
author_login: uxp
author_email: uxp@bsdeviant.org
title: More Ruby on OS X
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2010-04-14 16:17:57 -06:00
author: uxp
---
In the last post, I outlined a simple way to adding to the Ruby.framework bundle the newer version of the Ruby Language, 1.9.

Well, as I finished that up, I started hacking around with some other code, and a friend was trying to show me something neat with Ruby-HEAD... Well, that made it difficult to add a HEAD into the bundle, since the bundle is supposed to be pretty static and not prone to constant modifications. My way works for simple things (get 1.9, end).

He suggested I try RVM. <a href="http://rvm.beginrescueend.com/">Ruby Version Manager</a> is a simple little script that will download, configure, make and install specific versions, as well as patchlevels of the Ruby language into your $HOME directory. <a id="more"></a><a id="more-305"></a>
I havent delved into exactly how it works, but it looks like it dynamically updates your path to the bin directory of the versions installed into your $HOME. So even when you install a gem (say, mongrel) that installs an executable, it will run as the default version.

You can also install specific "GemSets", which is a fancy way of saying... set of gems.

I highly suggest everyone who uses Ruby to take a look at it.
