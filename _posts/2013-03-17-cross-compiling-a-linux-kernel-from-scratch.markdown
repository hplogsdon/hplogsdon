---
layout: post
published: true
title: Cross Compiling a Linux Kernel from scratch
date: 2013-03-17 12:22:17 -0600
description: Cross compiling a linux kernel isn't difficult, but it does require a bit of setup. I'm tired of looking it up from different places all the time, so here is how I've determined how to do this from a brand new install of a Debian box.
author:
---

Just a quick note so I don't have to look this up all the time.

From a vanilla Debian base box (the NetInstall, or similar), we'll need the basic `build-essential` and `make` packages. apt-get install them. We'll also need `git`, which is less likely to be installed be default.

The first order of business is figuring out what hardware you'll be targetting. This is ARM, i386, x86\_64/amd64, etc. Shouldn't be too difficult to determine.

The second order of business is obtaining the kernel. If you're cross-compiling, then you're more likely to be wanting a fork of the kernel from somewhere. Right this minute, I'm looking at compiling a new Kernel with some specific options for a Raspberry Pi. They're got their [own repo](https://github.com/raspberrypi/linux/) for now. Someday down the line, it might end up being merged back into Mainline Linux, which would be at [kernel.org](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/) (download/git links at the bottom of the page).

So either checkout/branch to the version you want, or download and untar it to your home directory. It's generally not recommended to be running as root for any compilation action, including any sudo actions, so there's no reason in needs to be in `/usr/src`. If you recompiling your kernel for the machine you're running on that's a different story.

Set an environmental variable to the base location, `export KERNEL_SRC="$HOME/src/linux"`, and cd into it: `cd $KERNEL_SRC`.

