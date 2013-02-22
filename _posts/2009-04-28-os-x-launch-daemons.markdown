--- 
tags: []

wordpress_url: http://dharmahacker.com/blog/?p=92
published: true
layout: post
wordpress_id: 92
categories: 
- General
- Hardware
- Software
excerpt: |
  So, after a long adventure playing with FreeBSD + KDE4.2 as a full time desktop operating system, I've fallen back to running OS X. I don't know why really, but I have. Maybe a little more flexibility, though I would doubt it if I was told so. I also took that little p4 2.66GHz laptop and tossed Windows XP on it. Unfortunately, as a huge advocate of Open Source Software, XP is really quite cool. There have been quite a few applications I've like to run, but couldn't unless I was actually running WinXP. Its nice to have a box that I can easily get to and run those applications now. Who knows what the future holds, but I'm pretty sure i'll be back someday.

author_login: uxp
author_email: uxp@bsdeviant.org
title: OS X Launch Daemons
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2009-04-28 10:38:01 -06:00
author: uxp
---
So, after a long adventure playing with FreeBSD + KDE4.2 as a full time desktop operating system, I've fallen back to running OS X. I don't know why really, but I have. Maybe a little more flexibility, though I would doubt it if I was told so. I also took that little p4 2.66GHz laptop and tossed Windows XP on it. Unfortunately, as a huge advocate of Open Source Software, XP is really quite cool. There have been quite a few applications I've like to run, but couldn't unless I was actually running WinXP. Its nice to have a box that I can easily get to and run those applications now. Who knows what the future holds, but I'm pretty sure i'll be back someday.
<a id="more"></a><a id="more-92"></a>
Well, in the process of imaging my drives and doing some quite intensive housework with both my Macs, I cleaned off a bunch of stuff I no longer used. One of these was the media application <a href="http://boxee.tv">Boxee</a>. I'd like to run a small box as a complete Media box, and have it all hooked up to the TV in the living room and such, but until I get some more cash, that is just a dream. I tried to run an <a href="http://ubuntu.com">Ubuntu</a> system on the laptop, since its got s-video out, but to no avail. 512Megs of ram really is a limiting factor. Youtube videos stuttered quite a bit. Anyways, back to the Boxee thing, I removed the application, and like most OS X apps, all I did was delete the boxee.app package, which usually is enough to get it off. I wasn't planning on never using it again, so I figured I could leave all the preferences and such. Well, as I started using OS X again, I would notice launchd every 10 seconds jump up to like 75% CPU usage for a seconds or two, then jump down again. After running 'launchctl' from the Terminal, and checking the logs, it seemed that ~/Library/LaunchAgents/tv.boxee.helper.plist was trying to launch the Boxee Daemon, not finding the binary, and then pausing for 10 seconds.

4/28/09 11:09:31 AM com.apple.launchd[122] (tv.boxee.helper) Throttling respawn: Will start in 10 seconds
4/28/09 11:09:31 AM com.apple.launchd[122] (tv.boxee.helper) Throttling respawn: Will start in 10 seconds
4/28/09 11:09:41 AM com.apple.launchd[122] (tv.boxee.helper[462]) posix_spawnp("/Applications/Boxee.app/Contents/Resources/Boxee/bin/boxeeservice", ...): No such file or directory

I tried just removing the job from launchctl, but it would reappear every reboot, so I had to manually remove the plist file from my user's Library LaunchAgents directory. All is well now.

It makes me think about software engineering. Naturally, a program, especially in alpha/beta stage, cant be completely stable, and this issue doesn't make it "unstable", but it is an issue that needs to be resolved. If a launcher can't find its application to launch, it should fallback with an error and quit after a set period of time. Something like this is not going to resolve itself by chance.

On a side note, a friend is doing some spring cleaning and decided to unload a bunch of software programming books on me. He went to school for a while to become a programmer, and had a job as one for a while, but has since decided he doesn't want to anymore. Maybe I can learn stuff from them, maybe I wont. I'm not really a fan of Java, and theres a few books on it, and then some on CPP, includeing a 2nd edition Deitel & Deitel CPP, how to Program. Unfortuantely they are mostly out of date (cpp programs including stdio.h for example), but they still are useful.

And I'm trying to get back into Obj-C programming, especially since I've given up the whole Kdevel C thing, for now. I might also try a little Python. I hear thats easy to learn... who knows.
