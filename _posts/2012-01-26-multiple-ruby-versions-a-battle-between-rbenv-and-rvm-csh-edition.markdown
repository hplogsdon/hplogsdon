--- 
tags: []

wordpress_url: http://blog.hplogsdon.com/?p=432
published: true
layout: post
wordpress_id: 432
categories: 
- General
description: |
  As a long time user of FreeBSD I've developed a liking for the C Shell. Since it's the default root shell on FreeBSD, I've learned how to use it for the situations where I would end up in Single-User mode, or with a bare install that I needed to quickly configure without waiting for Bash and all of it's many dependancies to compile from the Ports tree. 
  
  Now, I do agree with many of the points that have been made over the years about <a href="http://web.mit.edu/ghudson/info/csh.whynot">CSH scripting being a poor programming tool</a>, but that doesn't mean that the shell itself is a bad tool. I would rather write shell scripts using the <a href="http://en.wikipedia.org/wiki/Bourne_shell">Bourne shell</a>, which also comes in the base system of FreeBSD, but Bourne is not Bash, and Bash is certainly not Bourne. Don't ask me why, but I've never liked Bash. Just my personal opinion. Unfortunately, liking a relatively unpopular OS (compared to the love-fest that is Linux), and preferring a somewhat uncommon shell leaves me in a awkward position when I find great shell tools that happen to be written in none other than Bash Script.

author_login: uxp
author_email: uxp@bsdeviant.org
title: Multiple Ruby Versions, a battle between rbenv and RVM, CSH edition.
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2012-01-26 11:51:06 -07:00
author: uxp
---

As a long time user of FreeBSD I've developed a liking for the C Shell. Since it's the default root shell on FreeBSD, I've learned how to use it for the situations where I would end up in Single-User mode, or with a bare install that I needed to quickly configure without waiting for Bash and all of it's many dependancies to compile from the Ports tree. 

Now, I do agree with many of the points that have been made over the years about <a href="http://web.mit.edu/ghudson/info/csh.whynot">CSH scripting being a poor programming tool</a>, but that doesn't mean that the shell itself is a bad tool. I would rather write shell scripts using the <a href="http://en.wikipedia.org/wiki/Bourne_shell">Bourne shell</a>, which also comes in the base system of FreeBSD, but Bourne is not Bash, and Bash is certainly not Bourne. Don't ask me why, but I've never liked Bash. Just my personal opinion. Unfortunately, liking a relatively unpopular OS (compared to the love-fest that is Linux), and preferring a somewhat uncommon shell leaves me in a awkward position when I find great shell tools that happen to be written in none other than Bash Script.
[RVM](http://rvm.beginrescueend.com/) is the first that really got to me. RVM is a great tool <a href="http://blog.hplogsdon.com/more-ruby-on-os-x/">I've written about before</a>. I think most anyone who's spent more than 3 hours playing with Ruby code knows about it. It's just that essential. However, over the almost two years or so I've used it, it's grown substantially is size and complexity. I'm not the only one that's noticed that fact either. One of the only dependancies for RVM is the Bash shell (or a Bash-compatible shell, like zsh, which is a popular alternative these days).

An amazing developer from 37Signals, [Sam Stephenson](http://sstephenson.us/), who's known for projects like the <a href="http://www.prototypejs.org/">Prototype Javascript Library</a>, wrote an alternative, which turned out to be fairly <a href="http://news.ycombinator.com/item?id=2874862">controversial</a>. This is <a href="https://github.com/sstephenson/rbenv">rbenv</a>. A couple weeks before I started using RVM I wrote a <a href="http://blog.hplogsdon.com/ruby19-and-18-side-by-side-on-os-x/">blog post</a> about method of installing two different versions of Ruby side-by-side on OS X, which basically just put the two versions in separate install paths, and a small script would rewrite symlinks of the binary executable programs hidden away somewhere to a common place in your PATH. Similarly, that's all that RVM and rbenv do, without the symlinks, but by changing your PATH. You install a version of Ruby into a directory hidden from your PATH, and as requested they alter your path so that it picks up the requested version before anything else. RVM also overwrites other environmental variables to create what it calls Gemsets, which are "clean" directories you can install a group of Rubygems into. It's fairly useful, but I don't always need a clean gemset, and to be honest, it ends up adding a fair amount of complexity. I find myself running "rm -rf" a lot on whole gemsets, found in "$HOME/.rvm/gems", and having to start over.

I'm rambling a bit here, but what does this have to do with the shells? Well, RVM will not function in any way outside of Bash, since the RVM command is actually a Bash function, not a Bash script. rbenv takes a different approach, and along with a function, it will also use a simple script to load external command scripts. It's very Unix-y, and that's why I like it so much. It does one thing, alter your PATH variable to allow different Ruby installations to run, and it does it well. The <a href="http://gembundler.com/">Bundler</a> gem takes care of most of the loading and management of Gems, even when using RVM, so there isn't a huge need for Gemsets anymore either. There are only a few caveats that you have to be aware of when using rbenv with the C Shell.

Installing new Ruby versions is really easy, and there is no difference than the README states. It's actually loading rbenv that changes a bit. The README states to add a couple lines to your .bash_profile initialization script. Since we don't use Bash, we'll add our commands to .cshrc, and do some of the initialization "manually". There isn't a lot that goes on behind the scenes, so the manual initialization is all of one more line than doing it automatically. Here's what the relevant lines in my .cshrc state:

{% highlight shell %}
set path = ( $HOME/.rbenv/shims $HOME/.rbenv/bin $HOME/bin /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/games )
rbenv rehash
{% endhighlight %}

As you can see, I set the path to the shims and the bin directory in my rbenv working directory, "$HOME/.rbenv", and then call rehash.

And that's it. Almost.

Using rbenv from that point is exactly like the README states, except when you change versions. Anyone that does use the C Shell knows that after installing a new program into your path, you have to rehash the cache that knows which programs are where. rbenv, oddly, takes this same approach. It won't know about new Ruby versions until you tell it to re-index it's cache. This means that any time you change Ruby versions (which should really be all that often) you'll have to manually run csh's "rehash" command so it knows where to find the new Ruby tools.
