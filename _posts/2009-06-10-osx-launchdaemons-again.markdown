--- 
tags: 
- launchdaemons
- moron
- osx
- superuser
wordpress_url: http://dharmahacker.com/blog/?p=111
published: true
layout: post
description: |
  I can't remember what I was trying to do, but I just effectively hosed my system, abeit fairly minorly.

wordpress_id: 111
categories: 
- Software
author_login: uxp
author_email: uxp@bsdeviant.org
title: OSX LaunchDaemons again
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2009-06-10 07:07:14 -06:00
author: uxp
---
I can't remember what I was trying to do, but running the command

	launchctl unload -w /System/Library/LaunchDaemons/

Completely incapaitated my iMac. It was pretty cool.

To resolve it, I had to boot up in singleuser mode with Command+S at the boot chime, run fdisk, then remount the drive with read/write permissions, and then run the reverse,

	/bin/launchctl load -w /System.....

Which, from singleuser mode, actually booted me back into the aqua desktop system. It was interesting. A couple of "let's just be sure" reboots later, and I'm golden, until I run another retarded command as root.

And since my iMac was rebooting, I seized to write this on my iPhone, and the wordpress app no longer has a save button? Wth.
