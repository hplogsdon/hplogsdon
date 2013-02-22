--- 
tags: []

wordpress_url: http://dharmahacker.com/blog/?p=71
published: true
layout: post
wordpress_id: 71
categories: 
- General
author_login: uxp
author_email: uxp@bsdeviant.org
title: I hate WINE right now.
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2009-02-20 22:01:58 -07:00
author: uxp
---
This snippet is for my own personal use. Im trying to run WINE under OS X. Not any of the fancy shmancy Darwine packages, I like the command line stuff. Looks like I STILL have an issue with OpenGL. Im running x.org's X11, not Apples, as well as all the dependancies compiled by hand from source. and I still can't get my shit together. I can't figure it out. I'll give it 2 more months before I either end up installing Ubuntu or FreeBSD/KDE on my iMac.

<code>
angikara:~ uxp$ wine C:\\Program\ Files\\PlayOnline\\SquareEnix\\PlayOnlineViewer\\pol.exe
fixme:advapi:SetEntriesInAclA 1 0x33f87c 0x0 0x33f8b4
fixme:advapi:SetSecurityInfo stub
err:wgl:has_opengl  glx_version is 1.2 and GLX_SGIX_fbconfig extension is unsupported. Expect problems.
wine: Unhandled page fault on execute access to 0x00000000 at address 0x0 (thread 0009), starting debugger...
Unhandled exception: page fault on execute access to 0x00000000 in 32-bit code (0x00000000).
Register dump:
 CS:0017 SS:001f DS:001f ES:001f FS:1007 GS:0037
 EIP:00000000 ESP:0032f34c EBP:0032f3c8 EFLAGS:00010202(   - 00      - -RI1)
 EAX:6080f000 EBX:6212b07e ECX:00000240 EDX:0032f3ac
 ESI:00000000 EDI:6081f200
Stack dump:
0x0032f34c:  6212b217 6080f000 60230190 00008013
0x0032f35c:  0032f3ac 00126960 00126960 7b8193e1
0x0032f36c:  7b88224b 6052eff0 604ce0be 6216f1c8
0x0032f37c:  6216f1c8 0032f3ac 0032f440 00000000
0x0032f38c:  6080f000 00000000 00000000 6081f200
0x0032f39c:  7b882460 6052eff0 00000000 00000240
0200: sel=1007 base=7eef0000 limit=0000ffff 32-bit rw-
Backtrace:
=>0 0x00000000 (0x0032f3c8)
  1 0x62133a4d (0x0032f468)
  2 0x60508b89 (0x0032f4c8)
  3 0x627a8a0d (0x0032fa78)
  4 0x6282608f (0x0032fac8)
  5 0x61bda1ee in ddraw (+0x2a1ee) (0x0032fb68)
  6 0x61bdae1b in ddraw (+0x2ae1b) (0x0032fbc8)
0x00000000: -- no code accessible --
Modules:
Module	Address			Debug info	Name (16 modules)
PE	  400000-  477000	Deferred        pol
PE	10000000-1000e000	Deferred        polhook
PE	60180000-60184000	Deferred        advapi32
PE	60310000-60325000	Deferred        user32
PE	604b0000-604b4000	Deferred        gdi32
PE	605b0000-605fd000	Deferred        winmm
PE	60660000-60664000	Deferred        ole32
PE	619d0000-619d4000	Deferred        rpcrt4
PE	61a60000-61a64000	Deferred        oleaut32
PE	61bb0000-61c00000	Export          ddraw
PE	61c40000-61d2e000	Deferred        shell32
PE	61e20000-61e27000	Deferred        shlwapi
PE	61eb0000-61ec3000	Deferred        comctl32
PE	61fa0000-61fa4000	Deferred        version
PE	7b810000-7b889000	Deferred        kernel32
PE	7bc10000-7bc14000	Deferred        ntdll
Threads:
process  tid      prio (all id:s are in hex)
00000008 (D) C:\Program Files\PlayOnline\SquareEnix\PlayOnlineViewer\pol.exe
	0000001e    0
	00000009    0 <==
0000000c
	0000001b    0
	00000014    0
	00000013    0
	00000012    0
	0000000e    0
	0000000d    0
0000000f
	00000015    0
	00000011    0
	00000010    0
00000016
	0000001f    0
	00000017    0
00000018
	0000001d    0
	0000001c    0
	0000001a    0
	00000019    0
00000022
	00000023    0
Backtrace:
=>0 0x00000000 (0x0032f3c8)
  1 0x62133a4d (0x0032f468)
  2 0x60508b89 (0x0032f4c8)
  3 0x627a8a0d (0x0032fa78)
  4 0x6282608f (0x0032fac8)
  5 0x61bda1ee in ddraw (+0x2a1ee) (0x0032fb68)
  6 0x61bdae1b in ddraw (+0x2ae1b) (0x0032fbc8)

fixme:advapi:SetEntriesInAclA 1 0x33f86c 0x0 0x33f8b4
fixme:advapi:SetSecurityInfo stub
fixme:advapi:SetEntriesInAclA 1 0x33f88c 0x0 0x33f8d4
fixme:advapi:SetSecurityInfo stub

angikara:~ uxp$</code>


That FreeBSD/KDE sounds tempting. Dualboot under Bootcamp just for shits? Or am I continually opening up new headaches?
