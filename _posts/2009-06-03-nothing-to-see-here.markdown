--- 
tags: []

wordpress_url: http://dharmahacker.com/blog/?p=99
published: true
layout: post
wordpress_id: 99
categories: 
- General
author_login: uxp
author_email: uxp@bsdeviant.org
title: Nothing To See Here
description: I keep on forgetting Apache's directory block syntax, so here it is, for my own sake
author_url: http://hplogsdon.com
status: publish
date: 2009-06-03 23:25:42 -06:00
author: uxp
---
I need to remember this, so here it is.

	<Directory "/usr/local/www">
			AllowOverride None
			DirectoryIndex index.html
			DirectorySlash On
			Options None
			Order deny,allow
			Allow from 10.0.0.1/25
	</Directory>


Also, you know you are coding too much when while typing a blog out in wordpress, you constantly press esc at the end of a section or paragraph, and your final line ends in :wq!
