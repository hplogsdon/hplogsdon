--- 
tags: []
wordpress_url: http://hplogsdon.com/?p=301
published: true
layout: post
wordpress_id: 301
categories: 
- General
description: |
  I broke down and installed Ruby 1.9.1 on my MacBook Pro today. It was rather simple, but there was one thing that I've learned to do, that I didn't see anyone bother with.  If you drop down into Terminal.app and look at the ruby executable /usr/bin/ruby ...
author_login: uxp
author_email: uxp@bsdeviant.org
title: Ruby1.9 and 1.8 side by side on OS X SL
comments: []
author_url: http://hplogsdon.com
status: publish
date: 2010-03-31 17:41:28 -06:00
author: uxp
---
I broke down and installed Ruby 1.9.1 on my MacBook Pro today. It was rather simple, but there was one thing that I've learned to do, that I didn't see anyone bother with.

If you were to drop down into Terminal.app and look at the ruby executable

	/usr/bin/ruby

You'll see it's a little strange. Actually it isn't at all. It's a symlink. Where to? Where else but a Framework package! Yay OS X for being... strange.

So one tutorial I came across when googling , namely [this one](http://cardarella.blogspot.com/2009/04/ruby-18-and-19-living-together-on-mac.html) say to just add a suffix of "19" to the configure script and call it good. Well, if you're using Ruby, you're probably opinionated (hand in hand kinda thing), and in my opinion, thats fucking lazy and will lead to headaches. You'll have your shit strewn all across your filesystem.

Dont do it.

Instead, do something a little less conventional (for \*nix), and install it as a specific version inside the framework.

	curl -O ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.1-p376.tar.gz
	tar xzvf ruby-1.9.1-p376.tar.gz
	mkdir ruby-1.9.1-p376.tar.gz/build
	cd ruby-1.9.1-p376/build

	../configure --prefix=/System/Library/Frameworks/Ruby.framework/Versions/1.9/usr --enable-shared
	
	checking build system type...
	...
	
	make
	sudo make install

Which will put all the new ruby files in "/System/Library/Frameworks/Ruby.framework/Versions/1.9/usr"

Then to change to have your default ruby installation be 1.9, run:

	sudo rm /System/Library/Frameworks/Ruby.framework/Versions/Current
	sudo ln -s 1.9 /System/Library/Frameworks/Ruby.framework/Versions/Current

and your existing symlinks at /usr/bin/ruby /usr/bin/erb etc will follow the new path.

I recommend this type of setup for almost any of the existing frameworks you wish to upgrade or try out new versions of.

Note: this will only install your default architecture (i386 fro CoreDuo, x86_64 for C2D, ppc for PowerPC, etc). You'll have to throw the environmental variables into your config line to get fat binaries up.

