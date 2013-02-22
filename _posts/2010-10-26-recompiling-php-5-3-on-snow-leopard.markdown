--- 
tags: []

wordpress_url: http://blog.hplogsdon.com/?p=348
published: true
layout: post
wordpress_id: 348
categories: 
- Software
- Source Code
excerpt: |
  Despite my having FreeBSD dualboot systems, I still find myself in OS X quite a bit. Enough that I now require an expanded PHP version than the one that came with Snow Leopard. Basically, I can't do any graphics work in freebsd, but code hacking works well. It's a tradeoff.
  
  Here's a quick post on my configuration parameters.

author_login: uxp
author_email: uxp@bsdeviant.org
title: Recompiling PHP 5.3 on Snow Leopard
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2010-10-26 19:41:58 -06:00
author: uxp
---
Despite my having FreeBSD dualboot systems, I still find myself in OS X quite a bit. Enough that I now require an expanded PHP version than the one that came with Snow Leopard. Basically, I can't do any graphics work in freebsd, but code hacking works well. It's a tradeoff.

Here's a quick post on my configuration parameters.
<a id="more"></a><a id="more-348"></a>
Dependancies, 
libjpeg <a href="http://www.ijg.org/">The Independent JPEG Group</a>
MySQL <a href="http://www.mysql.com/">MySQL from Oracle</a>
PCRE <a href="">PCRE</a>
libmcrypt <a href="http://mcrypt.hellug.gr/">Mcrypt</a>

[sourcecode]
MACOSX_DEPLOYMENT_TARGET=10.6 CFLAGS=&quot;-arch x86_64 -arch i386 -g -Os -pipe -no-cpp-precomp&quot; CCFLAGS=&quot;-arch x86_64 -arch i386 -g -Os -pipe&quot; CXXFLAGS=&quot;-arch x86_64 -arch i386 -g -Os -pipe&quot; LDFLAGS=&quot;-arch x86_64 -arch i386 -bind_at_load&quot; ./configure --prefix=/usr/local --mandir=/usr/local/share/man --infodir=/usr/local/share/info --disable-dependency-tracking --sysconfdir=/private/etc --with-apxs2=/usr/sbin/apxs --enable-cli --with-config-file-path=/etc --with-libxml-dir=/usr --with-openssl=/usr --with-kerberos=/usr --with-zlib=/usr --enable-bcmath --with-bz2=/usr --enable-calendar --with-curl=/usr --enable-exif --enable-ftp --with-gd --with-jpeg-dir=/usr/local/lib --with-png-dir=/usr/X11R6 --with-freetype-dir=/usr/X11R6 --with-xpm-dir=/usr/X11R6 --with-ldap=/usr --with-ldap-sasl=/usr --enable-mbstring --enable-mbregex --with-mcrypt=/usr/local --with-mysql=/usr/local --with-mysqli=/usr/local/bin/mysql_config --with-pdo-mysql=/usr/local --with-mysql-sock=/var/mysql/mysql.sock --with-iodbc=/usr --enable-shmop --with-snmp=/usr --enable-soap --enable-sockets --enable-sockets --enable-sysvsem --enable-sysvshm --with-xmlrpc --with-iconv-dir=/usr --with-xsl=/usr --with-pcre-regex=/usr/local --disable-short-tags
[/sourcecode]


Though, if you don't feel the need to update the entire PHP release, then you can just do individual modules. Say you wanted to do the mcrypt extension. You'll have to unpack the entire php distribution.

<pre>
$ cd ~/src/php-5.3.3/
$ cd ext/mcrypt
$ /usr/bin/phpize
$ MACOSX_DEPLOYMENT_TARGET=10.6 CFLAGS='-O3 -fno-common -arch i386 -arch x86_64' \
> LDFLAGS='-O3 -arch i386 -arch x86_64' CXXFLAGS='-O3 -fno-common -arch i386 -arch x86_64' \
>  ./configure --with-php-config=/Developer/SDKs/MacOSX10.6.sdk/usr/bin/php-config
$ make
$ sudo make install
</pre>

And then add that line to your php.ini and then restart apache

<pre>
extension=mcrypt.so
</pre>
