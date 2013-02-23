--- 
tags: []
wordpress_url: http://hplogsdon.com/?p=215
published: true
layout: post
wordpress_id: 215
categories: 
- General
description: |
  I'm pretty sure this is going to turn into a long story short, turned long. Though thats mostly intentional this time.
author_login: uxp
author_email: uxp@bsdeviant.org
title: Ruby on Rails on FreeBSD
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2009-11-08 16:31:32 -07:00
author: uxp
---
I'm pretty sure this is going to turn into a long story short, turned long. Though thats mostly intentional this time.

Virtualization is a pretty cool technology. Its an interesting idea to take 3 servers, like a Frontend Balancer, Web server, and database server, and toss them all into one. Well, even for taking a high end box and then setting it up to host a dozen or more private boxes with the entire web-stack running local. Its pretty cool. 

Well, I'm thinking about moving over to a VPS provider. In preparation of administrating my own production box, I decided to set one up in a VM. A Real Live (fake) Production Server.

Well, its basically practice so I can remember how to set up the real box. This is my documentation.

I'm still more of a fan of FreeBSD than any of the Linux Distros, I'll be running through a setup of FreeBSD. I'll also be running a generic kernel. Not that it matters very much, but its something to consider. Since I have a couple Ruby on Rails apps and the standard PHP stuff, I'll be setting Rails and PHP up, MySQL for the database, and Apache for the webserver. I keep on hearing nice things about Nginx, but I don't have any experience with it. I've also heard that MySQL is rather cumbersome, but thats what I've used. This configuration should be pretty generic, but my goal is to keep it clean.

I've also developed a habit of installing FreeBSD from the netinstall disc, rather than the full DVD. I pretend its more up-to-date, even though it does make the inital install a tad longer, it doesn't take hours to download. For the production, I install only the minimal configuration. If I find I need something later, I'll grab it from ports or whatever. If you are following this tutorial along with me blindly, you probably will stumble a little. Google your hangup. Read the <a href="http://www.freebsd.org/doc/en/books/handbook/">FreeBSD Handbook</a>. Then ask around, or leave a comment.

This post has been split up into sections. It was becoming huge, so I've helped break it down into more manageable parts that don't necessarily rely on each other. 

1. [Configuring a headless FreeBSD server](/configuring-a-headless-freebsd-server/)
2. [Configuring the FAMP Stack](/configuring-the-famp-stack/)
3. [Installing Ruby, RubyGems, and Rails](/installing-ruby-rubygems-and-rails/)
4. [Configuring Mongrel and Mongrel Cluster](/configuring-mongrel-and-mongrel-cluster/)
