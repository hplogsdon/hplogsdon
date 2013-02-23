--- 
tags: []
wordpress_url: http://blog.hplogsdon.com/?p=363
published: true
layout: post
wordpress_id: 363
categories: 
- Software
- Source Code
- Web Development
description: |
  I like compiling and installing programs and utilities by hand on my development machines. Today, I decided to try one of the "new" NoSQL solutions, namely MongoDB. Unsurprisingly, there were no surprises. I did end up creating a new user on my machine, and borrowed a plist LaunchDaemon from the Homebrew project to configure it. Heres the simple commands that can help you not have to worry about running the database as your user or having to start it up every time you reboot your machine.
author_login: uxp
author_email: uxp@bsdeviant.org
title: Installing MongoDB on OS X
comments: []
author_url: http://hplogsdon.com
status: publish
date: 2010-11-23 21:17:40 -07:00
author: uxp
---
I like compiling and installing programs and utilities by hand on my development machines. Today, I decided to try one of the "new" NoSQL solutions, namely [MongoDB](http://www.mongodb.org/). Unsurprisingly, there were no surprises. I did end up creating a new user on my machine, and borrowed a plist LaunchDaemon from the Homebrew project to configure it. Heres the simple commands that can help you not have to worry about running the database as your user or having to start it up every time you reboot your machine.

Installing MongoDB is stupidly easy. If you don't care to compile it yourself, which requires the Boost Library as well, then you can download the pre-compiled binaries.

	$ curl -O http://fastdl.mongodb.org/osx/mongodb-osx-i386-1.6.4.tgz
	$ cd /usr/local
	$ tar -xz --strip-components 1 -f ~/mongodb-osx-i386-1.6.4.tgz

Create the data directory. I want to put it in /private/var/db/, since that is where I have both PostgreSQL and MySQL's data directories. 

	$ mkdir /private/var/db/mongo

Running it is a simple as typing mongod.

	sudo mongod --dbpath /var/db/mongo/


Getting it to run as its own user, as well as getting it to start up after every boot is a little more work. But not difficult at all. Lets start by creating a configuration file at /usr/local/etc/mongod.conf. The only thing we really need to put in it is an IP address to bind to, and the path to the data directory.

	dbpath = /private/var/db/mongo
	bind_ip = 127.0.0.1

You can test that by restarting the server without the dbpath flag, but adding --config and then the path to the config file you just wrote.

Lets get this sucker running without us even knowing about it.

Create a new plist file. Since I am running this as a system process, instead of a user process, it will go in /Library/LaunchDaemons. Per the standard, it should be named "org.mongodb.mongod.plist", which is basically the group/organization (their web address) that wrote the software, and then the binary name that we are executing. If I recall, this is either borrowed from Java, or Java borrowed it. A simple convention either way. Toss this text in there.

	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
	<plist version="1.0">
		<dict>
			<key>Label</key>
			<string>org.mongodb.mongod</string>
			<key>ProgramArguments</key>
			<array>
				<string>/usr/local/bin/mongod</string>
				<string>run</string>
				<string>--config</string>
				<string>/usr/local/etc/mongod.conf</string>
			</array>
			<key>RunAtLoad</key>
			<true/>
			<key>KeepAlive</key>
			<true/>
			<key>UserName</key>
			<string>_mongodb</string>
			<key>WorkingDirectory</key>
			<string>/private/var/db/mongo</string>
			<key>StandardErrorPath</key>
			<string>/private/var/log/mongodb/output.log</string>
			<key>StandardOutPath</key>
			<string>/private/var/log/mongodb/output.log</string>
		</dict>
	</plist>

You might notice we tell it to run as UserName \_mongodb, which we havent created yet. Lets do that now. Other Unixes would just create a user. OS X is a little different. We want the user registered with the system. We have to do this manually, including choosing a spare User and Group ID. Lets figure out one that has not yet been taken.

	dscl . -list /Groups PrimaryGroupID | awk '{print $2}' | sort -n
	dscl . -list /Users UniqueID | awk '{print $2}' | sort -n

I chose the number 114. If that is free on your system for both Group and User IDs, then go ahead and take it. System accounts generally are prefixed with an underscore, so we'll do that as well as shown in the plist file.

	sudo dscl . create /Users/_mongodb UniqueID 114
	sudo dscl . create /Users/_mongodb PrimaryGroupID 114
	sudo dscl . create /Users/_mongodb NFSHomeDirectory /private/var/db/mongo/
	sudo dscl . create /Users/_mongodb RealName "MongoDB Server"
	sudo dscl . create /Users/_mongodb Password "*"
	sudo dscl . append /Users/_mongodb RecordName mongodb
	
	sudo dscl . create /Groups/_mongodb
	sudo dscl . create /Groups/_mongodb PrimaryGroupID 114
	sudo dscl . append /Groups/_mongodb RecordName mongodb
	sudo dscl . create /Groups/_mongodb RealName "MongoDB Users"

And then to finish it off, cleanly shutdown any mongod instances you may have running in separate terminals, and then chown the database datadir to your new user.

	sudo chown -R _mongodb:_mongodb /private/var/db/mongo

and to clean up an error that will occur when you try to start it, create a directory to store your log files and either give it permission to write to the directory, or chown it outright.

	sudo mkdir /var/log/mongodb && sudo chown _mongodb:_mongodb /var/log/mongo

And you're done. Start up the server with the plist:

	sudo launchctl load -w /Library/LaunchDaemons/org.mongodb.mongod.plist

And then reconnect a client to it, without any configuration or dbdir flags.

	$ mongo
	MongoDB shell version: 1.6.4
	connecting to: test
	> db.foo.save( { a : 1 } )
	> db.foo.find()
	> 

Congratulations. Everything should work, and it will shutdown and restart cleanly with your machine. 
