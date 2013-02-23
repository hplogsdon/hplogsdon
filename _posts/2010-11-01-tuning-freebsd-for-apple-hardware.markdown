--- 
tags: []
wordpress_url: http://hplogsdon.com/?p=321
published: true
layout: post
wordpress_id: 321
categories: 
- Hardware
- Software
description: |
  My last post, FreeBSD on Apple Hardware Part 2 went over how I installed FreeBSD on consumer Mac hardware. But FreeBSD, being a super awesome server platform, doesn't run the greatest out of the box on desktop systems. Doing some simple Google searches turns up a vast array of people trying to run and configure it though. Here, I'll try to combine a lot of those articles. For reference, I am configuring my macbookpro1,1 and imac7,1.
author_login: uxp
author_email: uxp@bsdeviant.org
title: Tuning Freebsd for Apple Hardware
comments: []
author_url: http://hplogsdon.com
status: publish
date: 2010-11-01 13:14:27 -06:00
author: uxp
---
My last post, [FreeBSD on Apple Hardware Part 2](http://hplogsdon.com/freebsd-on-apple-hardware-part-two/), went over how I installed FreeBSD on consumer Mac hardware. But FreeBSD, being a super awesome server platform, doesn't run the greatest out of the box on desktop systems. Doing some simple Google searches turns up a vast array of people trying to run and configure it though. Here, I'll try to combine a lot of those articles. For reference, I am configuring my macbookpro1,1 and imac7,1.

## Power Management
At first, FreeBSD will make your hardware run fast and hot while idling. My MacBookPro can run about 3 hours from a full battery under OS X. By default, it will only run about 70 minutes under FreeBSD. powerd(8) can help with this. Configuring it to be adaptive will lower the CPU consumption. Turn on powerd(8) by /etc/rc.d/powerd, or by rebooting. 

	# /etc/rc.conf
	powerd_enable="YES"
	powerd_flags="-a adaptive -b adaptive"
 
You can check the battery status with ```sysctl hw.acpi.battery```. I think hw.acpi.battery.time is a percentage time, not a numeric time.

I still have not had much success with suspend/resume. I'm working on that configuration, and will update this post later, or post something new. I haven't had any success with my LCD brightness either. The macbookpro1,1 doesn't seem to have the correct driver through ATI, but it appears that someone has written a backlight driver for those with later models (3,1 specifically). His or Her page is [Macbookpro FreeBSD](http://www.lamaiziere.net/mbp_freebsd.html). I might end up seeing how related the driver is to my system and If I can hack it to work on mine. My C is a little weak though, so who knows.

## Keyboard Backlight
I have not scripted this to be responsive to the environment, but that is my next real project. You can check your ambient lighting sensors with 

	sysctl dev.asmc.0.light.left
	sysctl dev.asmc.0.light.right

and change the keyboard backlight by modifying the value of

	sysctl dev.asmc.0.light.control

to any integer between 0 and 255, 0 being off and 255 being full.

## Wireless Networking
To be honest, since my MacBook Pro has an atheros chip, [The FreeBSD Handbook - Wireless Networking](http://www.freebsd.org/doc/handbook/network-wireless.html) was all the information I needed. The only trouble I've run into is when I visit a location without auth-security. I end up creating a duplicate wlan cloned interface that connects directly with DHCP, and then restart /etc/rc.d/netif

My iMac doesn't move, and it connects via ethernet. No configuration there.


## tmpfs
You may have noticed that I didn't partition my disk to have a separate /tmp partition or slice. I use tmpfs. (It also didn't have a seperate /usr/home or /home partition, but thats because I don't yet care.)

	# /boot/loader.conf
	tmpfs_load="YES"

	# /etc/fstab
	tmpfs    /tmp    tmpfs  rw,mode=0177   0   0

<br>

## MultiTouch Trackpad
I originally installed 8.1-RELEASE, but have since updated to 9.0-CURRENT. 9.0-CURRENT has included the atp(4) driver for Apple Touchpads. I recommend you download and update your system to -CURRENT, or 9.0-RELEASE, whenever that comes out.

## Sound and Audio
Both my iMac and my MacBook Pro use snd_hda(4) as the driver. I've now compiled it directly into the kernel, but it can be easily loaded with

	# kldload snd_hda

or by adding this line to /boot/loader.conf:

	snd_hda_load="YES"

But, with both computers, sound still didn't work. Right now, a month or more after running BSD almost full time, at least on my MacBook Pro, it still isn't working completely correctly. On my MacBook Pro, the lines I stick into /boot/device.hints to get my sound working through the speakers is: 

	hint.hdac.0.cad0.nid10.config="as=2 seq=2"
	hint.hdac.0.cad0.nid12.config="as=4 seq=1"
	hint.hdac.0.config="gpio0"

and in order to route it through the headphone jack, I have to stick these lines into /boot/device.hints:

	hint.hdac.0.cad0.nid10.config="as=2 seq=2"
	hint.hdac.0.cad0.nid11.config="as=0 seq=2"
	hint.hdac.0.cad0.nid12.config="as=4 seq=1"
	hint.hdac.0.cad0.nid15.config="as=0 seq=2"
	hint.hdac.0.config="gpio0 ovref"

As you can see, there is a bit of duplication. I'm not completely sure how to combine these two groups to get speakers to work by default. Whenever I have the headphone jack lines in the device.hints file, the speakers quite working. Whenever I remove them, the speakers work again.

And the fact that I have to reboot my fucking computer every time I make one change in order for the device to  reconfigured makes the  fine tuning of my speakers a bitch to do, so it might be a while until I figure it out.


On my iMac, the sound in tinny. There is no bass sound, and that sucks. Also if I bring both PCM and VOL volumes up very high, and REC is up even a tiny bit, the speakers go haywire and the girlfriend starts throwing shit at me to turn it off. I haven't given up on adjusting the sound, but it takes a lit of effort.


I'll continue to edit this post as more information comes up... I cant remember thing that I have done.

