--- 
tags: []
wordpress_url: http://hplogsdon.com/?p=216
published: true
layout: post
wordpress_id: 216
categories: 
- General
description: |
  This is the first in a multipart series on how I configured a headless FreeBSD server when I moved to a VPS provider, focusing on the bare basics neccessities when building a FreeBSD box from the ground up.

author_login: uxp
author_email: uxp@bsdeviant.org
title: Configuring a headless FreeBSD server
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2009-11-08 16:31:41 -07:00
author: uxp
---
This is the first in a multipart series on how I configured a headless FreeBSD server when I moved to a VPS provider. 

This post assumes that your provider has already set you up with a super minimal FreeBSD image that you have access to as root. Its first assumed that there are no user accounts, except root, and there is nothing installed that the "Minimal" option when selecting your install options did not provide to you.

Onto the building. If you did not install FreeBSD to your disk on your own, and you have not already, be sure to change your Root user password. If you don't already have a method of making hilariously complicated passwords, especially for root and administrator accounts, check out this snippet:


	sitepass() {
			echo -n "$@" |  md5sum | sha1sum | sha224sum | sha256sum | sha384sum | sha512sum | gzip - | strings -n 1 | tr -d "[:space:]"  | tr -s '[:print:]' | tr '!-~' 'P-~!-O' | rev | cut -b 2-11; history -d $(($HISTCMD-1));
	}

via: [CommandlineFu](http://www.commandlinefu.com/commands/view/3690/generate-a-unique-and-secure-password-for-every-website-that-you-login-to)

Before I set a user other than root, I grab my shell of choice


	# cd /usr/ports/shells/bash
	# make install clean


and then set up the user to my liking:

	# adduser


Then just before I log out of root, I grab another essential piece:

	# cd /usr/ports/security/sudo
	# make install clean


and add my newly created user to the sudoers file

	# vi /etc/sudoers


You might start to read ahead and notice that we will be using the sudo command quite frequently. This may also make you think that you should just stay as root. Well don't. There is a fine line between becoming complacent with typing your password in frequently, to the point you don't even remember doing it,

Now, you're probably like me, and anxious to get some applications up and running that actually do things a server is supposed to do, but we're going to take a break. I grabbed the ports tree from the servers, not my installation disc, when I installed the OS, but I'm going to start compiling a lot of packages from source all at once. Last thing I need is to spend time building a port, only to find out in a day, or hour, or whatever from now that its not up to date. Lets fix that potential problem now. There are multiple ways to do this, but I use a simple one:


	$ sudo portsnap fetch
	...
	$ sudo portsnap extract
	...

This ensures my tree is up to date, and everything I compile from here on out is going to be good. 

Once thats finished, I logout, then log back in as the user I just created. At this point, I also scp my public key for my local box into the server. For whatever reason, I like to pretend it is now headless and in some Colo facility thousands of miles away. Helps me make better judgments if I can't boot it up and fix all the dumb mistakes I made by copy/pasting bad code and commands I have no idea what they do. I logout of the VM, so its at the login screen, minimize the VM, and its done. No more server sitting in front of me.

I'm still a huge fan of VIM, so thats one thing I grab early on. I also have an archive of my favorite VIM scripts and my .vimrc easily available, so lets set that up. My only problem is it takes a while to compile from ports. Wouldn't it be nice if I could detach that compiling session and continue configuration? Well you can, with GNU screen.

	$ cd /usr/ports/sysutils/screen
	$ sudo make install clean

Then continue on:

	$ screen
	$ cd /usr/ports/editors/vim
	$ sudo make config-recursive
	$ sudo make install clean
	C-a d


"make config-recursive" goes through the port, and all its dependancies, and brings up the ncurses screen in advance, so you can safely detach and not have to check on it every few minutes.

While Vim is compiling all its dependancies and whatnot, lets harden up a few things. Specifically SSHd. I already put my public key on the server, but I don't even have a private key on the server. Lets make one:

	$ ssh-keygen -t rsa
	Generating public/private rsa key pair.
	...

And Best Practice: Use a goddamned passphrase. Not that a public/private key pair is entirely essential, but we're configuring sshd, so we might as well get everything done here. Change some lines, based on your own preferences, in the sshd_config file. 

	$ sudo vim /etc/ssh/sshd_config

	Change (and uncomment): Port 22
	To: Port 2200 (or higher, or more random, your choice)

	Change: Protocol 1
	To: Protocol 2

	Change: LoginGraceTime 2m
	To: LoginGraceTime 10s

	Change: #PermitRootLogin no
	To: PermitRootLogin no
	(This is arguable, but I don't care. I don't log in as root,
	and so I don't allow it)

	Change: MaxAuthTries 6
	To: MaxAuthTries 1

And whatever you feel is necessary. This isn't a tutorial
on hardening your box. This is just a start to get myself
going from the ground up.

Finally, run:

	$ sudo /etc/rc.d/sshd restart


Then, **IN ANOTHER FUCKING TERMINAL SESSION FROM A REMOTE MACHINE THAT HAS SENT ITS PUBLIC KEY TO THE SERVER AND WAS ADDED TO YOUR AUTHORIZED_KEYS FILE WHILE KEEPING YOUR CURRENT CONNECTION ACTIVE**, try to access the server via ssh.

	localhost $ ssh -p (whatever you set) user@server


If you just locked yourself out of your box, let me know so I can laugh at you. thks.

If you're comfortable with whats there, lets continue on to Part 2: [Configuring the FAMP Stack](/configuring-the-famp-stack/)

