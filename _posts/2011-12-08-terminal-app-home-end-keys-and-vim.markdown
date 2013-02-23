--- 
tags: []
wordpress_url: http://blog.hplogsdon.com/?p=425
published: true
layout: post
wordpress_id: 425
categories:
 - General
description: |
  There are dozens of people complaining about Terminal.app's handling of Home and End keys (and page up/down as well) on the internet, all with fixes. The reality is, Terminal.app on OS X doesn't provide the correct keycodes out of the box, and the fix is really simple.
author_login: uxp
author_email: uxp@bsdeviant.org
title: Terminal.app Home and End keys and Vim
comments: []
author_url: http://hplogsdon.com
status: publish
date: 2011-12-08 10:49:25 -07:00
author: uxp
---
There are dozens of people complaining about Terminal.app's handling of Home and End keys (and page up/down as well) on the internet, all with fixes. The reality is, Terminal.app on OS X doesn't provide the correct keycodes out of the box, and the fix is really simple.

[This post on theandystratton.com](http://theandystratton.com/2009/fixing-home-end-page-up-and-page-down-in-leopards-terminal) from back in 2009 is one I've had to go to a couple of times to remember exactly how to enter in the correct keycodes in Terminal.app's preferences. His method just takes the simple approach of aliasing the old terminal keycodes of CTRL+a and CTRL+e (home and end, respectively) into the home and end keys on the OS X keyboard. Unfortunately, those keycodes end up not working in VIM.

A comment on that site then goes into detail on changing those keycodes to something different, (\033[7~ and \033[4~), which do work in VIM, but end up spitting out tildes in the terminal. So how can we get a compromise, to have home and end work in both Terminal.app and VIM running in terminal? Pretty easy, actually.

The simple idea, re-alias the correct home/and keycodes into VIM's already defined movement commands. The correct keycodes are the \001 and \005 commands in this case (ctrl+a and ctrl+e).

VIM all by it's lonesome uses the character '0' (zero) to move to the beginning of the line, and the '$' (US Cash symbol) to move to the end. By aliasing Home and End, we can then use the common keyboard functions to move effectively. The hardest part was figuring out how to ender in control sequences into a text file (our vimrc in this case).

Here is what the vimrc directives look like:

    " Fix home and end in Terminal.app
    " end
    map ^E $
    imap ^E ^O$
    " home
    map ^A g0
    imap ^A ^Og0

But long story short, just entering in each character won't work. For end's normal map the correct character sequence is " CTRL+v END " in two separate steps. And for the insert remap (imap), it's the same character sequence, then " CTRL+v O $" (the letter o, not the number), which can be copied to home as well.

CTRL+v is a special sequence in many terminals that basically notifies the shell that you will be entering a command sequence raw, and want to output the sequence, not run the sequence, similarly to escaping special characters line newlines (\n) or carriage returns (\r). If you ever use Vim to do a global replace of DOS newlines which appear as "^M", instead of typing the Caret and a capital M, you would have to type " :%s/CTRL+v M/\n/g ", which would show up on the screen as " :%s/^M/\n/g"

Anyways, hope that helps other people that happen to stumble on this.

