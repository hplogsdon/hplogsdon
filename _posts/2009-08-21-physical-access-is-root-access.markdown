--- 
tags: []

wordpress_url: http://dharmahacker.com/blog/?p=119
published: true
layout: post
wordpress_id: 119
categories: 
- General
excerpt: |
  I always forget that physical access is akin to root access on a box.
  
  A couple weeks ago a friend dropped off an old laptop at my house. He said he was unable to get into the OS because he didn't have and user passwords, or names. It was running an older Fedora release, which I neither remember, or care to remember what version. Funny thing is, I couldn't get Ubuntu to boot off the LiveCD either. Ubuntu is generally my goto for a cheap (free) simple OS to run really quick. Probably because I usually have a new disc sitting around at all times.

author_login: uxp
author_email: uxp@bsdeviant.org
title: Physical Access is Root Access
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2009-08-21 08:29:45 -06:00
author: uxp
---
I always forget that physical access is akin to root access on a box.

A couple weeks ago a friend dropped off an old laptop at my house. He said he was unable to get into the OS because he didn't have and user passwords, or names. It was running an older Fedora release, which I neither remember, or care to remember what version. Funny thing is, I couldn't get Ubuntu to boot off the LiveCD either. Ubuntu is generally my goto for a cheap (free) simple OS to run really quick. Probably because I usually have a new disc sitting around at all times.
<a id="more"></a><a id="more-119"></a>
Well, Since Ubuntu didn't boot, I grabbed a Fedora Core 10 live disc which actually booted just fine in under a half hour. Did I mention this was an old laptop? After spending maybe an hour trying to get anything to load in order to get to the HDD, I gave up. There was little on the disc he needed, and it was only 20GB, so I shut it down and tried something else. The second, which really should be my first goto live OS, <a href="http://bsdeviant.org/">BSDeviant</a>. This is an amazing OS I have the pleasure of working with. I actually host the site, though I don't work on the project. No one does anymore. It's rather dead unfortunately.

Well after a quick boot into BSDeviant, I was able to mount the HDD and edit the /etc/passwd and /etc/shadow files to completely remove the user password. I could then boot into Fedora and make a new password for the user of my specification.

The process made me start to think. On my laptop, I have a bit of paranoia. Every few minutes I have a cronjob run a script that pings my server and gets a file via cURL. If the file is false, everything is golden. But if I modify the file to be true, as in "It is True my laptop has been stolen", then it record the LAN and WAN IP address, takes a screenshot, lists all files that have been modified in the past 24 hours, and takes a capture of the webcam, tars it all up in an archive, then emails it to me, all behind the scenes. The only indication that its running is a half second blip of the LED indicator light when the webcam takes a picture of the user. Pretty nifty I might say.

But if the thief has any sense, then he would never connect to the internet, so the script could never tell if the laptop is stolen, and he would probably do something similar, as in archive the disk image, and run his own OS, as a live CD or similar, and access all my files.

Maybe I should start looking into encryption... Man I'm paranoid.
