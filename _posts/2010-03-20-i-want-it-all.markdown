--- 
tags: []

wordpress_url: http://hplogsdon.com/?p=293
published: true
layout: post
wordpress_id: 293
categories: 
- General
excerpt: |
  I use the website <a href="http://www.binsearch.info/">Binsearch</a> a fair amount, specifically the Browse feature. A site like Binsearch makes it so I dont have to spend a lot of bandwidth and cpu power downloading and threading/sorting headers. Unfortunately, they seem to have a custom option that automatically groups similar threads together, usually by the same poster. I see its usefulness in combatting SPAM and what-not for text and discussion groups, but not for binaries.

author_login: uxp
author_email: uxp@bsdeviant.org
title: I want it all
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2010-03-20 14:42:46 -06:00
author: uxp
---
I use the website <a href="http://www.binsearch.info/">Binsearch</a> a fair amount, specifically the Browse feature. A site like Binsearch makes it so I dont have to spend a lot of bandwidth and cpu power downloading and threading/sorting headers. Unfortunately, they seem to have a custom option that automatically groups similar threads together, usually by the same poster. I see its usefulness in combatting SPAM and what-not for text and discussion groups, but not for binaries.
<a id="more"></a><a id="more-293"></a>
So I took 20 minutes and wrote a userscript to automatically redirect any request to their /browse.php page to one that includes the directive to load all ungrouped.

Check it out here, where I've decided to store all my pretty userscripts: <a href="http://hplogsdon.com/userscripts/">http://hplogsdon.com/userscripts/</a>

It has been fully tested on Chromium 5.0.359.0 (42183) (last nights build), and it seems simple enough that Opera and Firefox/Greasemonkey should not have a problem. If they do, let me know and I'll actually test them. I just don't care enough right now.

Edit: after using it for a few minutes, I figure I should update it to automatically append the "all" option to any link to the /browse.php page so you dont have to load each new link twice. The guys at binsearch.info would probably appreciate it also. I'll do that soon.
