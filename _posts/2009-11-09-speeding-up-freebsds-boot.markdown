--- 
tags: []
wordpress_url: http://hplogsdon.com/?p=245
published: true
layout: post
wordpress_id: 245
categories: 
- General
description: If you have been following my previous posts, you know that I'm configuring my first private production server. Servers tend to be headless, and I can't see much benefit in dualbooting a server... so I always want to see about bypassing the options that are available for such a configuration.
author_login: uxp
author_email: uxp@bsdeviant.org
title: Speeding up FreeBSD's boot
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2009-11-09 01:27:45 -07:00
author: uxp
---
If you have been following my previous posts, you know that I'm configuring my first private production server. Servers tend to be headless, and I can't see much benefit in dualbooting a server... so I always want to see about bypassing the options that are available for such a configuration. One is the boot loader. FreeBSD by default when using the FreeBSD Boot Manager (boot0), has a 10 second wait. Thats the screen that says

	F1: FreeBSD
	ESC to cancel

Or something.

Well, lets take that down to nothing. I want FreeBSD to boot. I'll be making consistent backups of my virtual server image, so I'll be able to roll back if something does go wrong and I'm unable to boot. Also, with the server, anything between a "shutdown -r now" command and sshd coming back online is foreign. I'll have to trust that it "just works". This includes boot3, which has its own 10 second delay. Lets get rid of it.

Thats an entire 20 seconds of boot time thats waiting for user input, but the user isn't at the screen to give input. Heres what we do.

For boot0, there is a command called [boot0cfg(8)](http://www.freebsd.org/cgi/man.cgi?query=boot0cfg&manpath=FreeBSD+7.2-RELEASE&format=html) that will help... configure boot0, if you couldn't already tell. Read the man page to see what it can do. The short answer for me is:

  # boot0cfg -t 2 /dev/da0

Which tells the boot loader to wait 2 ticks, approximately 0.109 seconds, instead of the default 200 ticks, or so.

For boot3, the final boot stage, there is one quick option you can add into /boot/loader.conf

	autoboot_wait=-1

Which, by requesting negative one seconds, tells it not to even attempt to load the menu. Even at 0 seconds, the menu loads, but there it not enough time for the user to give input.

A few quick commands can help speed up your process in the event that you need to force a reboot and want it to come up very quickly. Remember though, these can put you in a bad situation in the event you have a harddisk fail, or you need to enter into single user mode when running it local.
