--- 
tags: []

wordpress_url: http://hplogsdon.com/?p=259
published: true
layout: post
wordpress_id: 259
categories: 
- General
- Software
- Source Code
description: |
  The past few posts have been a "I use this, but I extended its default functionality with this:" posts... Well this one is no different. I have slowly become fed up with Safari. Every update seems to make it run slower. I've noticed as the day wears on, it can take up to 30 seconds to load a new tab. WTF is that shit.
author_login: uxp
author_email: uxp@bsdeviant.org
title: Chromium Nightly Downloader
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2009-11-18 23:10:14 -07:00
author: uxp
---
The past few posts have been a "I use this, but I extended its default functionality with this:" posts... Well this one is no different. I have slowly become fed up with Safari. Every update seems to make it run slower. I've noticed as the day wears on, it can take up to 30 seconds to load a new tab. WTF is that shit. So the next alternative is.... no, I don't like FireFox. I even use a non-modified version for my browsing (no extensions) and it seems bulky and slow. Safari was really snappy a couple months ago.

So Chromium has made some awesome strides as of late, and the nightly builds are pretty awesome. Super stable, incredibly, and fast all around. The only problem with the (almost hourly) builds is there are a lot of them, and I don't want to be downloading a 20 meg file in order to start my day and night. So Script it right? Yes.

Here is a hackjob script that downloads the LATEST from http://build.chromium.org/ , deletes the one in your Application directory, unzips the new one, and then puts it back into your Applications directory. Obviously, it only works on OS X. Launchpad makes their deb repo available for Ubuntu/Debian users, and I bet there is a RPM distribution somewhere.

Check it out, and be sure TO READ IT before you run it. It is potentially damaging, has zero to no error handling, and was put together in all of 4 minutes. I take no Liability for any damages. It doesn't even have a license. Can I even License ~6 lines of script code?

[chrome-nightly.sh](http://www.hplogsdon.com/files/chromium-nightly.tar.gz)

Set it up into cron, or make a launch controller for it:

	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
	<plist version="1.0">
		<dict>
				<key>Label</key>
				<string>com.hplogsdon.NightlyChromiumDownloader</string>
				<key>ProgramArguments</key>
				<array>
						<string>/PATH/TO/SCRIPT</string>
				</array>
				<key>StartCalendarInterval</key>
				<dict>
						<key>Hour</key>
						<integer>3</integer>
						<key>Minute</key>
						<integer>15</integer>
				</dict>
		</dict>
	</plist>

save that as "com.hplogsdon.ChromiumNightlyDownloader.plist". Move it into your LaunchAgents directory (~/Library/LaunchAgents) and then run:

	launchctl load -w /PATH/TO/com.hplogsdon.ChromiumNightlyDownloader.plist

Thats also a Hack of a launch property list... it works however. Every morning at 3:15 AM it will run. If your Mac is on... Mine is so it works for me. remember to READ THE FILES IN THE ARCHIVE AND EDIT THE PATHS TO REPRESENT YOUR FILESYSTEM. You might have to chmod the script to make executable.

