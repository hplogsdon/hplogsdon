--- 
tags: []

wordpress_url: http://dharmahacker.com/blog/?p=73
published: true
layout: post
wordpress_id: 73
categories: 
- General
author_login: uxp
author_email: uxp@bsdeviant.org
title: Resolving issues in OS X
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2009-02-21 19:27:51 -07:00
author: uxp
---
LibJPEG has always been an issue.

Always. I'll admit that I need more experience under a POSIX environment. Luckily for me, I have hardware that I can easily use, and I'm not dumb enough to <code>sudo rm -rf /</code>. Though I have done some 3AM dumbass maneuvers thinking it would solve all of my problems.

I also just realised that I have not built the libjpeg shared libraries. Thats why im getting all sorts of complaints from WINE to GD, even though that shits installed. I know its installed. Also, OS X comes configured with libtools, but for some stupid reason libtools that comes with OS X spouts out this error:

<code>checking dynamic linker characteristics... no
checking if libtool supports shared libraries... no
checking whether to build shared libraries... no
checking whether to build static libraries... yes
checking for objdir... .libs
creating libtool
</code>
when I execute ./configure --enabled-shared --enabled-static

Fucking lame. Well I'm trying to figure out where the hell I can change shit to make it give me static libraries.

Updates to follow

Ninja Update: where is my hoodie, i need more snackfood, and Rogue American Amber is goddamned delicious. Wish they sold it in Utah. Goddamnit, wheres my hoodie.

Ninja Update 2: it was in the girlfriends pile of clothes.

Real Update: I'm trying to make libjpeg.dylib, as well as figure out why my builds of wine arent getting the proper updated versions of libGL/openGL

the wine configure gives me this midway
<code>
checking for -lcups... libcups.2.dylib
checking for -lfontconfig... not found
checking for -lssl... libssl.0.9.7.dylib
checking for -lcrypto... libcrypto.0.9.7.dylib
checking for -ljpeg... not found
checking for -lpng... libpng.3.dylib
checking for -lodbc... not found
</code>

which is where im stuck at right now.
