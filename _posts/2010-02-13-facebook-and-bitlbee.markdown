--- 
tags: []

wordpress_url: http://hplogsdon.com/?p=280
published: true
layout: post
wordpress_id: 280
categories: 
- General
author_login: uxp
author_email: uxp@bsdeviant.org
title: Facebook and Bitlbee
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2010-02-13 23:30:57 -07:00
author: uxp
---
A few days ago I heard that facebook's chat feature, which I had never actually used, had been "released" as an XMPP service. That meant people could technically use a standard IM client to connect to it, without having to be connected to facebook.com inside their web browser. I love the Unix philosophy of doing one thing and doing one thing well, so when I have to have 3 processes running that do essentially the same thing, but cant interact and do it all, I get annoyed.

For all of my social chat uses, I want to go to one place. That place is Irssi, since I spend a lot of time in IRC channels. Keeping with the Unix philosophy, Irssi lets me chat to people. It delegates certain scripts to allow it to connect to other services, like Twitter with twirssi, and jabber (xmpp) with Bitlbee. Well, after trying to connect to Facebook's chat, all my online "friends" would end up having names like u285623814... Not very useful on figuring out who that was. You could end up using 
<code>info u285623814</code>
but thats a pain, and a chat program is supposed to let you chat, not figure out who you are chatting to.

I ended up mentioning in a local open source channel and was linked to a blog written by another local open source geek who found a script to clear this up. Go to his site and grab the script, then load it into Irssi, and it will convert the userID to their qualified user name.

<a href="http://pthree.org/2010/02/13/facebook-chat-in-bitlbee/">Facebook Chat In Bitlbee</a>
