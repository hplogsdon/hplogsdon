--- 
tags: []

wordpress_url: http://hplogsdon.com/?p=132
published: true
layout: post
wordpress_id: 132
categories: 
- Software
- Source Code
excerpt: |
  I _almost_ get tired of trying to get WINE to run on my OSX system...
  
  I say almost, because its getting better, but issues still need to be ironed out. Particularly the old LibJPEG library. On Leopard I had a bitch of a time getting it to be picked up properly. Now on Snow Leopard, I almost had an issue. For whatever reason, it compiled as x86_64 by default. I figured this wasn't a bad thing, but it was also 2AM. Well, WINE's ./configure really didn't like it. Thankfully the error was:
  <code>configure: WARNING: libjpeg 32-bit development files not found, JPEG won't be supported.</code>
  
  Welp, 32 bit not found. No problem, I'll just go ahead and recompile this to 32... aaaand break GD support in PHP. Great...

author_login: uxp
author_email: uxp@bsdeviant.org
title: Its WINE, again honey....
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2009-09-29 19:24:28 -06:00
author: uxp
---
I _almost_ get tired of trying to get WINE to run on my OSX system...

I say almost, because its getting better, but issues still need to be ironed out. Particularly the old LibJPEG library. On Leopard I had a bitch of a time getting it to be picked up properly. Now on Snow Leopard, I almost had an issue. For whatever reason, it compiled as x86_64 by default. I figured this wasn't a bad thing, but it was also 2AM. Well, WINE's ./configure really didn't like it. Thankfully the error was:
<code>configure: WARNING: libjpeg 32-bit development files not found, JPEG won't be supported.</code>

Welp, 32 bit not found. No problem, I'll just go ahead and recompile this to 32... aaaand break GD support in PHP. Great...
<a id="more"></a><a id="more-132"></a>
So the end result ended up being a fat binary. Thats both x86_64 and i386 stuffed into the same package/binary. Trouble is, ./configure didn't like doing "-arch x86_64 -arch i386" passed as the CFLAG. I'm no genius, but I've never manually made a fat binary. Didn't take much really. I tore apart a Makefile I found and came up with this little bit:
<code>
$ tar xzvf jpegsrc.v7.tar.gz
$ cd jpeg-7
$ mkdir -p build/i386 build/x86_64 build/ppc build/fat
</code>
I decided to include PPC, in case I needed to link against it in the future for a cross-compile I cant see myself doing.
This is where the fun begins:
<code>
$ cd build/i386
$ CFLAGS="-O3 -g -arch i386" ../../configure --prefix="/usr/local" --enable-shared --disable-dependency-tracking && make
$ cd ../x86_64
$ CFLAGS="-O3 -g -arch x86_64" ../../configure --prefix="/usr/local" --enable-shared --disable-dependency-tracking && make
$ cd ../ppc
$ CFLAGS="-O3 -g -arch ppc" ../../configure --prefix="/usr/local" --enable-shared --disable-dependency-tracking && make
$ cd ../fat
$ lipo -create ../*/.libs/libjpeg.a -output libjpeg.a
$ lipo -create ../*/.libs/libjpeg.7.dylib -output libjpeg.7.dylib
$ lipo -create ../*/wrjpgcom -output wrjpgcom
$ lipo -create ../*/jpegtrans -output jpegtrans
... and so on.
</code>

OK, so now you have fat binaries of the library and tools.

Anyways, I ended up installing the 64bit version outright, to make sure I wouldn't miss anything via:
<code>
$ cd ../x86_64
$ sudo make install
</code>

then I could manually, again, go back and move those fat binaries into place. If you paid any attention during "make install", you'd easily notice where they go:

<code>
$ cd ../fat
$ sudo cp libjpeg.a /usr/local/lib/
$ sudo cp libjpeg.7.dylib /usr/local/lib/
$ sudo cp wrjpgcom /usr/local/bin/
$ sudo cp jpegtrans /usr/local/bin/
... and so on.
</code>

and voila, manually installed, and works great. Run
<code>
file /usr/local/lib/libjpeg.dylib
</code>
and verify the output.
