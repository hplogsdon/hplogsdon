--- 
tags: []

wordpress_url: http://dharmahacker.com/blog/?p=88
published: true
layout: post
wordpress_id: 88
categories: 
- General
excerpt: |-
  So, After taking nearly 24 hours of compiling, KDE-4.2.1 is installed and running.
  
  I'm having slight issues here and there with a few things.
author_login: uxp
author_email: uxp@bsdeviant.org
title: FreeBSD on Apple MacBookPro Hardware
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2009-03-21 00:58:56 -06:00
author: uxp
---
So, After taking nearly 24 hours of compiling, KDE-4.2.1 is installed and running.

I'm having slight issues here and there with a few things.<a id="more"></a><a id="more-88"></a> Mainly the sound isn't working. Not a huge issue yet, mostly because I haven't really ever been able to get sound to run right off the bat under FreeBSD. I'm looking into it. I found <a href="http://forums.freebsd.org/archive/index.php/t-168.html">this FreeBSD Forums page</a> in the archives while looking into the sound issue, and "plamaiziere" mentions "- the sysinstall fdisk on 7.1 breaks all the disk if installed via bootcamp. You need to use 7.0 to install and after update the system." I actually thought I saw this, and then realized I could download and install the 7.1-RELEASE instead of screwing around forever with an update. Meh. Whatever. Works now, and I'm mostly happy.

I also have an issue with KDM not loading into KDE properly on occasion. If you enter in a wrong password, it gives you an error, but the correct password basically loads another instance of KDM, not KDE. I currently have the option turned off in /etc/ttys. I'm much too tired to continue playing with .conf files anymore, and I get get KDE running, so its a success. Oh, actually, I had a horrible issue getting the mouse working. I had forgotten how I usually roll, by loading the device (/dev/ums0) with moused via /etc/rc.conf and then using /dev/sysmouse under xorg.conf. Works great.

Just a few minor issues to deal with, like my /home directory already being too small, (could I get away with wiping all but a basic OS X install?) but we can deal with that crap later. And the goddamned numlock key LED is stuck on. Its been forever since I turned it on, I was rather surprised to see a giant green light from the center of my keyboard (WTHWTFWTC IS THAT... oh. LED. heh :/ )

Anyways. Bedtime. The old HP lappy is busy with portupgrade for the night (in 3 minutes an ncurses config screen will pop, bet ya 10 bux.) and I might end up moving that to 7.1-REL from 7.0-REL. If I get comfortable enough, I'll do the server over the week. Its still running 6.3-STABLE though... Dont think Major revisions are too much different though.. Maybe a few more buildworlds kind of things. I haven't looked into it yet.

Oh, and I ran into this WINE bug, and love the fuckin commentary... From Google Groups <a href="http://groups.google.com/group/lucky.freebsd.ports.bugs/browse_thread/thread/6d89cc9fa4b663bd">132671</a>.
