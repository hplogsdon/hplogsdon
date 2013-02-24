--- 
tags: []

wordpress_url: http://dharmahacker.com/blog/?p=79
published: true
layout: post
wordpress_id: 79
categories: 
- Hardware
author_login: uxp
author_email: uxp@bsdeviant.org
title: FreeBSD + OS X Dualboot
comments: []
description: |
  I decided to go ahead and try the dualboot of FreeBSD and OS X on my MacBookPro, Which was very silly of me. Here's basically what I have done so far:
author_url: http://hplogsdon.com
status: publish
date: 2009-03-18 20:16:32 -06:00
author: uxp
---
I decided to go ahead and try the dualboot of FreeBSD and OS X on my MacBookPro, Which was very silly of me.

Here's basically what I have done so far:

1 ) Install rEFIt. Its an alternate boot menu for EFI systems, like Intel-Macs. Get it [here at SourceForge](http://refit.sourceforge.net/)

2 ) OS X likes to be on a GUID Partition Disk. FreeBSD doesn't. So I backup'd my OS X install by putting the MBP into FireWire Target Mode. Press T as the box chimes at boot. Then create a new image from the disk under Disk Utility. If you didn't have a second Mac, you could also boot from an external install (install minimal OS X onto a GUID Firewire or USB disk) or boot from the Leopard install DVD.

3 ) Defrag and Partition the HardDisk. An easy method is to format the disk, and restore using your backup image you just created. Or go out and buy software like iDefrag. Restoring a backup doesn't actually defragment the data, but it does write it sequentially onto the disk, so you don't have data at the end where you create the second partition.

4 ) You want to repartition the disk, preferably as an MBR disk. I had a difficult time getting the disk to be a GUID/MBR hybrid, which I hear is possible. Disk Utility on the Mac works great for live resizing. I made a ~124GB Mac Partition and a 32GB FreeBSD partition on a 160Gig disk. This is more of a trial run, and if I really want to, I can wipe the Mac Partition and resize that area to be my entire /home directory. Bootcamp is nothing more than a frontend to resize your disk. Whatever booting capabilities it may enable in your EFI Firmware is taken care of by rEFIt.

5 ) Reboot your machine a couple times and make sure you didn't fuck up.

6 ) Pop in the FreeBSD disk. I used 7.1-RELEASE. Install FreeBSD the way you would like to. I'm assuming you are competent in installing it. No, don't ask me questions on how to install it. If you have questions though, feel free to find the answers here, in the [FreeBSD Handbook](http://www.freebsd.org/doc/en/books/handbook/). It has helped me tremendously in the years I have been using FreeBSD.

7 ) Repeat step 5. Twice. I'm a big fan of not reading directions until something fucks up. I learn better by poking and prodding, than reading something. Unless I know its going to destroy everything, or has the chance to, I take a wild stab at it and see if it works. So repeat step 5 again.

8 ) Update everything. FreeBSD comes with great shit on the disk, but the past few times I have tried to install KDE from the ports, it bitches cause shit isn't updated, and it takes a lot longer to do what I want cause I have to quit halfway and start over.

Which is pretty much it. It's harder to do than a windoes install, but its not more complicated. I haven't tried a Linux install on any of these boxes, but I assume its nearly the same, and if its Ubuntu, its probably a lot easier.

I'll update this as I do more. Or do more posts, or whatever.

Also, I completely gave up on that WINE under OSX crap. Thats one of the reasons I tried to do a FreeBSD/KDE4 install. Also, I've recently become a fan of [RockBox](http://www.rockbox.org/). I put it on my 80GB iPod Video, and wouldn't mind a more organized method of transferring files to it. I've tried syncing with Amarok on my HP Laptop, but long story short, the USB ports are busted. They have lifted up from the logic/mother/mainboard, which is one of the reasons I quit using it. Also, that laptop has a bcm43xx wireless card. Fuck that thing. Wish I knew more about hardware compatibility it when I bought it. It is a P4 2.33Ghz, I think, but only about 512M ram. They left trackpad button is broken off as well... If I had a bunch of money to toss at shit, I would totally put a minimum of 2GB ram (if it can even handle it) and fix the trackpad button, and even see if I could get an Atheros WiFi card... but its also heavy and bulky. No widescreen either, but thats not a dealbreaker. It's great running fully upright next to my iMac with FreeBSD/KDE controlled with synergy. Use SSHFS to transfer files back and forth. Fantastic shit. Wish I would have set it up sooner.

Welp, my MBP is still compiling KDE... Goddamned.... So far so good, but updates may or may not follow.
