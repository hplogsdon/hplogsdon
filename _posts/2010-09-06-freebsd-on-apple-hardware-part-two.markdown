--- 
tags: 
- freebsd
- apple
- os x
- gpt
- efi
- dualboot
wordpress_url: http://hplogsdon.com/?p=310
published: true
layout: post
wordpress_id: 310
categories: 
- General
- Hardware
- Software
description: |
  Some time ago, I attempted to install FreeBSD on my Apple MacBook Pro CoreDuo, but ended up getting frustrated with the booting process and wiped it clean. 7.0-RELEASE attempted to enable GUID Partition Table support, but it didn't seem to be available or working until 7.1-RELEASE. Well, now that 8.1-RELEASE is out the door (for a while now) it seems that support is much better. I hadn't had a chance to test it yet, but I became frustrated with my iMac over the past few months and last week it finally hit critical mass. Now seems to be the time to try this out and see if I can get a very usable FreeBSD desktop. 

author_login: uxp
author_email: uxp@bsdeviant.org
title: "FreeBSD on Apple Hardware Part Two "
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2010-09-06 22:22:44 -06:00
author: uxp
---
Some time ago, I attempted to install FreeBSD on my [Apple MacBook Pro CoreDuo](http://hplogsdon.com/freebsd-os-x-dualboot/), but ended up getting frustrated with the booting process and wiped it clean. 7.0-RELEASE attempted to enable GUID Partition Table support, but it didn't seem to be available or working until 7.1-RELEASE. Well, now that 8.1-RELEASE is out the door (for a while now) it seems that support is much better. I hadn't had a chance to test it yet, but I became frustrated with my iMac over the past few months and last week it finally hit critical mass. Now seems to be the time to try this out and see if I can get a very usable FreeBSD desktop.

Mac OS X comes out of the box with [EFI booting](http://en.wikipedia.org/wiki/Extensible_Firmware_Interface), instead of Legacy BIOS firmware booting, and the disks are configured with [GUID Partition Tables (GPT)](http://en.wikipedia.org/wiki/GUID_Partition_Table). EFI, on OS X, works by creating a small partition (200MB) as the first partition formatted as FAT32, which is hidden to users, and contains the image that gets loaded and goes ahead and starts to load other systems. In a very abstract idea, it is similar to GRUB2, where it looks for images available to it, and those images are the ones that control the connected OS. GPT replaces the legacy Master Boot Record, which has old restrictions like only 4 partitions per disk, and a maximum size of 2TB per partition. The former is the one that helps us out here, since we can load all our partitions on a single disk and not worry about much.

A couple caveats. FreeBSD does not yet have compatibility to build an EFI image. We can work around this by loading an EFI image that in turn will look for legacy systems. FreeBSD does have compatibility to run on GPT disks, but the standard installer defaults to using fdisk and bsdlabel, which end up overwriting the partition table to be a GPT/MBR hybrid, and that can easily clobber and destroy OS X, which makes it impossible to boot FreeBSD and OS X, since without OS X, we cannot load the EFI image that will look for legacy systems. Its a Catch-22. Without OS X, we can't load FreeBSD, and without FreeBSD, we're where we started with.

This is how we do things then. We need a FreeBSD CD or DVD that contains the LiveFS, "fixit". This is any of the ISOs except FreeBSD-8.1-RELEASE-amd64-bootonly.iso and the memstick image. I've found that it is much easier to use the DVD, FreeBSD-8.1-RELEASE-amd64-dvd1.iso, though you have to deal with the 2GB+ download to begin with. If you have any image with the "fixit" console, you can use it to start, and then swap discs later. We also need to have a working installation of OS X. If you have been using OS X for a while, and want to keep your system intact, then you're in the same boat as myself. We'll try to keep it intact. But naturally, backup your data. You will also want to install [rEFIt](http://refit.sourceforge.net/) on your OS X install. I would recommend burning a CD of rEFIt as well, in case you trash your OS X install and want to boot into something.

Boot the FreeBSD image, and go to the fixit option, loading the filesystem from disc. You're going to use one command a lot. Read the manpage on it: `gpart`. It's a fairly easy command, but please don't blindly copy/paste these commands into your terminal. You need to know what device your computer has decided to label your disk as. It's somewhere in /dev, mine is /dev/ad4. Take a look at what is on your disk:


    # gpart show ad4
    =>       34  508396695  ad4  GPT  (250G)
               34        409600      1  EFI   (200M)
       409634  195405320      2  apple-hfs  (93G)

That gives me just about 100GB on my OS X Install, but my disk is 250GB. I resized the disk using Bootcamp. You can do the same under Disk Utility.app or BootCamp Assistant to get your partition the size you need. Now we can start to create partitions for our different FreeSBD filesystems.

Add a FreeBSD Boot partition to contain the bootcode. '-s' specifies the size of the partition in 512 byte blocks.

    # gpart add -t freebsd-boot -s 128 ad4

Add a FreeBSD Swap partition double the size of your physical RAM.

    # gpart add -t freebsd-swap -s 8388608 ad4

And then add your standard filesystems, sized for whatever you need. I used 1Gb for /var and / (root), and 20GB for /usr. I used the leftover space for /home.

    # gpart add -t freebsd-root -s 2097152 ad4
    # gpart add -t freebsd-var -s 2097152 ad4
    # gpart add -t freebsd-usr -s 41942040 ad4
    # gpart add -t freebsd-home ad4

Lets see what our partitions look like:

    # gpart show ad4
    =>             34  508396695  ad4  GPT  (250G)
                    34         409600    1  EFI  (200M)
            409634   195405320    2  apple-hfs  (93G)
      195814954               128    3  freebsd-boot  (64K)
      195815082       8388608    4  freebsd-swap  (4.0G)
      204203690       2097152    5  freebsd-root  (1.0G)
      206300842       2097152    6  freebsd-var  (1.0G)
      208397994     41942040    7  freebsd-usr  (20G)
      250340034   258056661    8  freebsd-home  (123G)


We need the bootcode and a Protective MBR written to the boot partition. The '-i' flag tells gpart to write it to the 3rd index of ad4, or /dev/ad4p3.

    # gpart bootcode -b /dist/boot/pmbr -p /dist/boot/gptboot -i 3 ad4

Those partitions aren't formatted, so newfs them.
    # newfs ad4p5
    # newfs -U ad4p6
    # newfs -U ad4p7
    # newfs -U ad4p8

Now you have your disk laid out to be installed to. Remember, we are doing a complete minimal manual install. We need a base system and Kernel. If you aren't running a LiveFS image with the base and kernel packages, you need to switch to one that is, or download and extract the base and kernel manually.

Lets mount our new filesystems first.
    # mount /dev/ad0p5 /mnt
    # cd /mnt
    # mkdir /mnt/var /mnt/usr /mnt/home
    # mount /dev/ad4p6 /mnt/var
    # mount /dev/ad4p7 /mnt/usr
    # mount /dev/ad4p8 /mnt/home

If you're running the full DVD like I ended up having to do, complete this step by extracting base and kernel from the disc. Otherwise skip to the next step to download them from the FreeBSD ftp server.

    # cd /dist/8.1-RELEASE/base
    # export DESTDIR=/mnt
    # ./install.sh
     ...
    # cd /dist/8.1-RELEASE/kernels
    # ./install.sh GENERIC
    # cd /mnt/boot
    # rmdir kernel
    # mv GENERIC kernel

If you need to download the base and kernel, you need to get your interface up. Replace your interface name and IP addresses with your own:

    # ifconfig msk0 10.0.0.20 netmask 255.255.255.0 up
    # route add default 10.0.0.1
    # echo "nameserver 10.0.0.1" > /etc/resolv.conf

And then tediously fetch the distribution:

    # mkdir /mnt/home/base
    # cd /mnt/home/base
    # fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/8.1-RELEASE/base/base.aa
    # fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/8.1-RELEASE/base/base.ab
    # fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/8.1-RELEASE/base/base.ac
    ...
    # fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/8.1-RELEASE/base/base.bo
    # fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/8.1-RELEASE/base/base.inf
    # fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/8.1-RELEASE/base/base.mtree
    # fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/8.1-RELEASE/base/install.sh
    # chmod +x install.sh
    # DESTDIR=/mnt
    # export DESTDIR
    # ./install.sh
    ...

And then do the same thing all over again for the GENERIC kernel

    # mkdir /mnt/home/kernels
    # cd /mnt/home/kernels
    # fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/8.1-RELEASE/kernels/generic.aa
    # fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/8.1-RELEASE/kernels/generic.ab
    # fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/8.1-RELEASE/kernels/generic.ac
    ...
    # fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/8.1-RELEASE/kernels/generic.ca
    # fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/8.1-RELEASE/kernels/generic.inf
    # fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/8.1-RELEASE/kernels/generic.mtree
    # fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/8.1-RELEASE/kernels/install.sh
    # chmod +x install.sh
    # DESTDIR=/mnt
    # export DESTDIR
    # ./install.sh GENERIC
    ...
    # cd /mnt/boot
    # rmdir kernel
    # mv GENERIC kernel

And now we converge. Whatever method you chose, you should have a filesystem mounted with the base distribution and GENERIC kernel installed. Our install doesn't yet know how to boot, so lets tell it where to mount our filesystems.

    # cd /mnt/etc
    # vi fstab
    ....
    # Device                   Mountpoint      FStype   Options         Dump    Pass#
    /dev/ad4s4              none                  swap       sw                   0          0
    /dev/ad4s5              /                        ufs         rw                   1          1
    /dev/ad4s6              /var                  ufs         rw                   2          2
    /dev/ad4s7              /usr                  ufs         rw                   2          2
    /dev/ad4s8              /home                ufs         rw                   2          2
    /dev/acd0                /cdrom              cd9660   ro,noauto     0          0


You should have a working minimal, unconfigured, bootable FreeBSD installation. Unmount your harddrive's filesystems and exit out of the fixit console. As you exit, sysinstall should automatically eject the DVD or CD, or do it manually while the machine reboots.

rEFIt should boot up first. If it automatically goes to OS X, reboot the machine, and as you hear the OS X boot chime, press the option key. rEFIt should be an option. You need to sync your MBR with GPT. Choose the partition inspector option and when it asks, agree with the sync. I like to reboot again at this point, so choose that option from rEFIt, and then hold option again at the chime. Select the legacy OS, which is FreeBSD.

You can either use sysinstall, or do everything manually, but you need to set up the basic system:

1. Set a root password.
2. Create and populate the /etc/rc.conf file.
3. Set your timezone.
4. Create a non-root user.
5. Install additional installation components like doc, games, info, manpages, proflibs, catpages, etc.
6. Install ports.

If you have any questions, email me, or add a comment to this post.

