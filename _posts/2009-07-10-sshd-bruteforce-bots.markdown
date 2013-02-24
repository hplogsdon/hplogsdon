--- 
tags: []

wordpress_url: http://dharmahacker.com/blog/?p=115
published: true
layout: post
wordpress_id: 115
categories: 
- Software
description: |
  Every few days I cat my logs on all my systems to see if anything should be fixed, repaired, patched, removed and whatnot. It only takes an hour or so, and I've come across a enough problems that I otherwise would not have noticed that only took a minute to fix, and helped the overall status of my system.
  
author_login: uxp
author_email: uxp@bsdeviant.org
title: SSHd Bruteforce Bots
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2009-07-10 11:26:22 -06:00
author: uxp
---
Every few days I cat my logs on all my systems to see if anything should be fixed, repaired, patched, removed and whatnot. It only takes an hour or so, and I've come across a enough problems that I otherwise would not have noticed that only took a minute to fix, and helped the overall status of my system.

Well, I had a simple firewall put up with PF on my FreeBSD box, but it didn't do anything besides filter a couple ports and then block everything else. One port open, 22. This allowed this shit to basically spam my logs:


	Jul 10 10:55:56 dukkha sshd[38567]: Invalid user simona from 203.172.142.245
	Jul 10 10:56:01 dukkha sshd[38569]: Invalid user annalisa from 203.172.142.245
	Jul 10 10:56:04 dukkha sshd[38574]: Invalid user diego from 203.172.142.245
	Jul 10 10:56:11 dukkha sshd[38576]: Invalid user elena from 203.172.142.245
	Jul 10 10:56:15 dukkha sshd[38578]: Invalid user luciano from 203.172.142.245
	Jul 10 10:56:18 dukkha sshd[38580]: Invalid user marilena from 203.172.142.245
	Jul 10 10:56:22 dukkha sshd[38582]: Invalid user htdocs from 203.172.142.245
	Jul 10 10:56:26 dukkha sshd[38584]: Invalid user toiawase from 203.172.142.245
	Jul 10 10:56:31 dukkha sshd[38586]: Invalid user storm from 203.172.142.245
	Jul 10 10:56:35 dukkha sshd[38588]: Invalid user sysadmin from 203.172.142.245
	Jul 10 10:56:38 dukkha sshd[38590]: Invalid user blitzcat from 203.172.142.245
	Jul 10 10:56:42 dukkha sshd[38592]: Invalid user circ from 203.172.142.245
	Jul 10 10:56:46 dukkha sshd[38594]: Invalid user ginny from 203.172.142.245
	Jul 10 10:56:49 dukkha sshd[38596]: Invalid user ftp from 203.172.142.245


which, really isn't anything. But, knowing me, I decided to fix it. I wanted to blacklist the IPs automatically, but I'm really not a good programmer. Even for a simple cat/grep log script. But Google helps me out once again. I came across this article by "valiantsoul" (if that is his/her handle, who knows) which seems to be a rather old article. [SSH Brute Force Blocker with PF on FreeBSD](http://home.earthlink.net/~valiantsoul/pf.html)

Basically, this changes one thing. Whenever the "/var/log/auth.log" file gets written to, a simple Perl script is run. All the script does is take the log, and with a bit of regex (god I love Perl Regular Expressions) looks to see if there are any "Invalid user $USER from $IPADDRESS" lines, or "Did not receive identification string from $IPADDRESS" lines, and then takes those IP addresses and adds them into a blacklist file, which is then addded to a <blacklist> table in the pf firewall. Pretty simple stuff, and I'm rather surprised how easily I can understand the code also. Looks like I'm not quite the illiterate retard afterall. (better not get too cocky hehe)

welp, thats about it. I might end up re-hosting the code. I get worried when sites are hosted by earthlink. Speaking of, the local alt-weekly paper was advertising an upcoming event where the website linked was to a geocities page or some shit. Hosting is cheap as fuck, I really don't understand why people cant spring for 10 bux and change for a domainname and hosting for a couple months to a year.</blacklist>
