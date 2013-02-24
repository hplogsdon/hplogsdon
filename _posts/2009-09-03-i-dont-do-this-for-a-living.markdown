--- 
tags: []

wordpress_url: http://dharmahacker.com/blog/?p=121
published: true
layout: post
wordpress_id: 121
categories: 
- General
description: |
  I don't do this for a living. None of it. I don't really want to make a living off it either... But I'm slowly getting closer to the point where I could. Pretty easily...
  
  I was hired by someone close to me to design, install and configure a website. Specifically an eCommerce site... Uh, I've designed a few WordPress themes, done some halfass PHP scripting, and a bit of clientside scripting. I'm not really the one that you should be going for, but they wanted me to do it, cause they knew it was gonna be cheap (I dunno how much this shit costs to do), and they knew it would be a good learning experience, and they could dictate and come back to me with suggestions and criticism. Thats not a bad thing, for either of us.

author_login: uxp
author_email: uxp@bsdeviant.org
title: I don't do this for a living
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2009-09-03 22:59:27 -06:00
author: uxp
---
I don't do this for a living. None of it. I don't really want to make a living off it either... But I'm slowly getting closer to the point where I could. Pretty easily...

I was hired by someone close to me to design, install and configure a website. Specifically an eCommerce site... Uh, I've designed a few WordPress themes, done some halfass PHP scripting, and a bit of clientside scripting. I'm not really the one that you should be going for, but they wanted me to do it, cause they knew it was gonna be cheap (I dunno how much this shit costs to do), and they knew it would be a good learning experience, and they could dictate and come back to me with suggestions and criticism. Thats not a bad thing, for either of us.

So for the past month (yeah, it was slow going at first) I tossed a few open source solutions on my development server, played with them each for a day or two, and eventually decided on one. Some factors include development ease and configuration ease, admin/store admin usability, and what language it was in. I played with a couple Python/Django solutions, and though I eventually settled on a PHP solution, I would have rather used the Django solution. I sat down a little while before and wrote a Django blog application in under an hour one night. Django is fucking awesome, mostly because it comes with the backend pre configured. All you do is gotta get some of the logic and controller written out, and its done (except for that whole "display content/data" part).

So I ended up with a PHP solution. Mostly because I could easily script in some custom actions, like emailing the owners, for simple stuff like Stock levels, and whatnot. Once they get all the data imported into it, the store will run itself. I've even got it set up with the postal service to basically print shipping labels. Someone needs to manually put the product in a box, tape it, and then stick it on their front porch to have it picked up... Maybe I should start selling stuff...

Well, I got it all "Done" last week. Gave me a good while to sit back and relax, do some work that isnt computers, for all of... 3 days. Yeah. 3 fucking days, and I get another assignment. My dad started to complain that his computer was running kinda slow... Great. A year old laptop. wtc is wrong. Well, I quickly put AVG on scan, went to lunch and saw when I came back that it had a Virus, trojan, or rootkit.

I ended up taking it home with me, and found out that it was the UAC rootkit, with a Win32/Crypto trojan... and something else relatively harmless. Rootkit. Those are like Unicorns. I've never had to deal with one. The UAC also likes to livepatch any malware, rootkit or antivirus software you try and run on the infected machine so it wouldnt work. It was fun playing with it really. I'd go and delete the generated DLLs, and it would hide for a while, then reappear somewhere else. Cat and mouse all over the windows folder.

I ended up running a few things from Ubuntu live to get to some stuff windows wanted to hide from me, then popped into safemode and finished up the cleaning with the standard GMER, ComboFix, and MalwareBytes combination. Its been a while since I've had to dig into a windows install. It was kinda fun. I just hate having to sit around while AVG or MBAM does a scan. That shit isn't fun.

So I got that all cleaned up, I think. Well the next day, the clicking that I've been hilariously ignoring got a little worse from my iMac. Its the harddrive. Even an idiot could tell. So I spent an hour or so imaging that disk to a safe location, then actually wiped the disk, reinstalled OS X, then upgraded to the new OS X, snow leopard. I actually bought it first, unlike what I did with leopard. I installed leopard pretty early, like the day it was released, then went out a while later and bought a disk, which sat in its packaging forever, until I needed to run a disk check... I shouldn't do that shit.

But I left the Mac running all night, and at 4:42AM it locked up on me. Haha. So today I dropped that off. It was still under warranty, so thats cool. Free HDD replacement.

Lets see if running my dads laptop all night tonight will let that rootkit resurface. I'm pretty sure I wiped it, but we'll find out soon enough. I backed up all his documents, so give me an hour and an energy drink and it'll be squeaky clean if need-be.
