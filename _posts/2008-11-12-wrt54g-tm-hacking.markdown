--- 
tags: 
- Hacking
- Hardware
- router
- wrt54g
wordpress_url: http://hplogsdon.com/blog/?p=3
published: true
layout: post
wordpress_id: 7
categories: 
- Hardware
author_login: uxp
author_email: uxp@bsdeviant.org
title: WRT54G-TM Hacking
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2008-11-12 20:34:29 -07:00
author: uxp
---
<p>So, I&#8217;m a hacker at heart. I love the feeling that all boundaries are broken when you can peek into the insides of something static and make it much more dynamic to your own needs. This includes both hardware and software, and at times, organic devices.</p>
<p>Some odd number of years ago, I needed a wireless router. I had just moved back home from the east coast and had a wireless enabled laptop that was tired of walking down and plugging into the cable modem. I went out and bought a Linksys WRT54G because I had heard good things about them. Unfortunately I had picked up a version 5, which was the first neutered version after a long line of easily modifiable releases. well, about 2 years ago, I decided to go for it, and took the long process of killing the firmware and loading dd-wrt, though it was still pretty useless. Short Story: The Memory limits only allowed for a stripped down version without many of the functions I really wanted. Though, dd-wrt made the router much more stable, and secure. I’ve used this as my primary router for years. It really wasn’t bad, but I wanted more.</p>
<p>So a little over a year ago, I had read that T-Mobile was selling a custom version that was supreme in its hardware design. I thought about getting one for a while, but held off. That is until I found a coupon for 15% off anything in the &#8220;Official&#8221; stores. I immediately went in and picked one up. Just like my previous Linksys, this was another purchase that would require a little more effort than just a simple upload and flash to get dd-wrt on it. The <a href="http://www.linux-mips.org/wiki/Common_Firmware_Environment">CFE</a> had some routine not present in previous versions that would resort to a backup version of the T-Mobile firmware that was loaded from the factory if you tried to flash something else to the router. To most, this means that the router is useless. To me, it ment I needed to try another way. The lovely people at Cisco decided to include a connection on the board that allows you to use a JTAG cable on the chip. You can then force flash the router with your firmware of choice. Basically, you erase the CFE and NVRAM and load a custom CFE onto the flash. Then you can TFTP the firmware onto the chip without the CFE going &#8220;Awe, fuck no!&#8221;</p>
<p>This was over a year ago that the guys working on the dd-wrt project found this out, but I never really wanted to go through all the trouble of building a JTAG cable. Really stupid of me. I ended up moving into a house from my apartment and the wireless connection anywhere that wasn&#8217;t in the office with the older v5 router sucked. So I now had a reason to do it that would result in some useful results, other than, cause I wanted to. So I looked at the schematics for a cable and saw what hardware I needed to build it and it was all of&#8230;. 4 goddamned resistors. Granted I could have made a super nice cable with a buffered connection, but I wasn&#8217;t going to use this more than once, maybe twice. So I went down to the local store and bought the resistors. In all of 10 minutes, it was completed.</p>
<p>I grabbed my older laptop, which had a Parallel Port (Damn you Macs) and compiled the software. For some particular reason, I couldn&#8217;t compile the software under FreeBSD, so I ended up sticking a small build of Slackware on a partition and doing it under that. I didn&#8217;t calculate the transfer rate, but it seemed to be REALLY slow, like 2800 Baud. I&#8217;m curious now if the buffered cable would be faster. Anyways within a few hours, it was done.</p>
<p>I use the new TM version router as my primary and then the older v5 router I&#8217;ve stuck in the living room as a repeater, or rather a Wireless Bridge. I get awesome reception, and my girlfriend likes it more when I&#8217;m stuck writing code in the living room while she watches TV as opposed to huddling myself away in the office.</p>
<p>If you&#8217;d like more information about JTAGing your router, whether its to recover from a bad flash that bricked it, or if you have a TM router, check out this thread on the DD-WRT forums: <a href="http://www.dd-wrt.com/phpBB2/viewtopic.php?t=17817&amp;postdays=0&amp;postorder=asc&amp;start=0&amp;sid=b61b68a4d5faa4eeedb92139bca89cca">T-Mobile (US) HotSpot @Home Routers (Successed)</a></p>
