--- 
tags: []

wordpress_url: http://hplogsdon.com/?p=278
published: true
layout: post
wordpress_id: 278
categories: 
- Software
- Source Code
- Web Development
excerpt: |-
  So, the past few month I've built a few applications using Rails. They aren't big applications by any means, but they are the old standbys I code up when I'm trying something new. I now have a custom Blog, Gallery, Shopping Cart/eCommerce and semi-Collaborative Task List.
  
  With the exception (depending on the day) of the eCommerce application, They are all rather quite small. They don't do much, and thats a bad thing. One of the Conventions that Rails adheres to, or rather employs, is it's not that great for small applications. It likes big things.
author_login: uxp
author_email: uxp@bsdeviant.org
title: Too Small To Fail
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2010-02-09 09:38:33 -07:00
author: uxp
---
So, the past few month I've built a few applications using Rails. They aren't big applications by any means, but they are the old standbys I code up when I'm trying something new. I now have a custom Blog, Gallery, Shopping Cart/eCommerce and semi-Collaborative Task List.

With the exception (depending on the day) of the eCommerce application, They are all rather quite small. They don't do much, and thats a bad thing. One of the Conventions that Rails adheres to, or rather employs, is it's not that great for small applications. It likes big things.<a id="more"></a><a id="more-278"></a> So my Todo List, which realistically is not much more complicated than the scaffold generated project I linked to in my <a href="http://hplogsdon.com/configuring-mongrel-and-mongrel-cluster/">Earlier Post</a>, tends to consume a lot of resources for the task its trying to accomplish. As I saw with the eCommerce, which isn't all that big either since it is very basic, is that it consumes just about the same amount of resources when it has to do more extensive queries and logic. Overall, its a lot bigger than the task list, almost 3 times bigger, but relatively, its not big at all. So thats a potential downside to Rails. If you plan to stick with it for a long time, building rich, dynamic applications, Rails is awesome. But for menial tasks, it starts to falter. I'm saying this as a proponent of Rails. Hope everyone understands this point. 

I also decided recently to start pursuing a job in web development. I think its a fascinating area. And my current employment is making me think that a stable job is more important than a potentially lucrative position that I've been waiting 6 years to open up... I'm still young, and eventually, after 6 months to a year of ho-humming about it, I took the plunge and actually applied for a position. This company had me start a test application working with CakePHP, so they could understand my skill level. Like I've said earlier, PHP seems like a dull language to me. I really want to try one of the more "Fun" languages like Python or Ruby... but unfortunately, it seems that PHP and ASP.NET seems to rule the market right now in terms of job positions. So I figure this is a good entry point to get some decent skills and experience. After a while, I can start to use other languages on my own time, and develop a strong portfolio of knowledge.

Back to CakePHP... Its modeled very similarly to Rails. Not by accident either. Which was fantastic, since my prior knowledge of the C language family has already, without knowing it, built up a strong understanding of PHP. So diving into Cake was rather easy since I already understood the language and I had a pretty good understanding of the conventions of the framework.

As of now, I've been writing an application that will help print invoices. A recent project for a friend has me maintaining an eCommerce site, and the biggest downfall, besides being based out of a CMS and being difficult to modify, is there is no invoicing. So I found a good entry point into building an invoicing application. I think I may end up releasing some of the code for this on github, since I feel pretty confident in it. I may try to clean up some of the rails applications as well, but If you spend an afternoon scouring github, you'll find dozens of incomplete, and basic applications for pretty much everything I've done. No need to clutter the internet with crap.

Lets see how this goes... So far I feel good about it.
