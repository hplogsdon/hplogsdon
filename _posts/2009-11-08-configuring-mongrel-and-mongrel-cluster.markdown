--- 
tags: []

wordpress_url: http://hplogsdon.com/?p=230
published: true
layout: post
wordpress_id: 230
categories: 
- General
- Software
- Web Development
excerpt: |
  This is the second in a multipart series on how I configured a headless FreeBSD server when I moved to a VPS provider.
  
  You might have noticed that we were running WEBrick, which is fine for what we were doing, but I like setting up a cluster of Mongrels to dish out my apps.
  
  Mongrel is a great server for running Rails apps. You may ask why the hell we are setting up two servers, and the answer is quite simple. Apache cannot run Rails applications out of the box. We can setup Apache using mod_rails or mod_ruby the same as we can do mod_python or mod_perl, but I like Mongrel. Its purely a choice. 

author_login: uxp
author_email: uxp@bsdeviant.org
title: Configuring Mongrel and Mongrel Cluster
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2009-11-08 16:38:42 -07:00
author: uxp
---
This is the second in a multipart series on how I configured a headless FreeBSD server when I moved to a VPS provider.

You might have noticed that we were running WEBrick, which is fine for what we were doing, but I like setting up a cluster of Mongrels to dish out my apps.

Mongrel is a great server for running Rails apps. You may ask why the hell we are setting up two servers, and the answer is quite simple. Apache cannot run Rails applications out of the box. We can setup Apache using mod_rails or mod_ruby the same as we can do mod_python or mod_perl, but I like Mongrel. Its purely a choice. 
<a id="more"></a><a id="more-230"></a>
From here, you can start using the command "gem install" to get things you need, or you can get them from ports. Your choice. Mine's ports, which is literally a frontend for gem, when installing rubygems. We need both mongrel and mongrel_cluster.
<pre>
$ cd /usr/ports/www/rubygem-mongrel
$ sudo make install clean
...
$ cd /usr/ports/www/rubygem-mongrel_cluster
$ sudo make install clean
...
</pre>

After that finishes, you should really be ready to go. Lets create our first application to run on the production server. The default "welcome to rails" application isn't going to be sufficient enough. We need an actual application. I still want to keep this simple, so I'm going to borrow a really REALLY simple application from Rob Mayhew's blog, of whom I have no affiliation with. Its a todo app, which is just that. Enter in a title, and text, and it will store it in the DB and spit it back out in a list. Check this out, and run it on your development machine if you want to test it. <a href="http://robmayhew.com/rails-201-todo-list-tutorial/">Rails 2.0.1 Todo List Tutorial</a>.

Lets first create the application where you want all your stuff. I chose /usr/local/www/rails as my directory where I'll end up placing all my Rails apps. Create it, then cd into it, and create a base for the app.
<pre>
$ sudo mkdir /usr/local/www/rails
$ cd /usr/local/www/rails
$ sudo rails todo -d mysql
...
$ cd todo
</pre>
Create, and give permission to the application to access your databases, just like we did before:
<pre>
$ mysql -u root -p
...
$ sudo vim config/database.yml
</pre>
Then we can start on the application.
<pre>
$ sudo script/generate scaffold Todo title:string body:text done:boolean due:datetime
$ sudo rake db:migrate
</pre>
I will also modify the routes so its not living in a sub-directory in my URL, but note, this isn't the complete step in configuring the routes. I'll get to that in a minute. For now, don't touch anything residing in your $APP_DIR/public directory.
<code>
  map.root :controller => "todos", :action => "index"
</code>
Then, if you want, run script/server, or we can move right on to the heavy lifting: Mongrel. Theres a little more configuration we need to do. First off, Apache doesn't know this application even exists. We won't be able to get to it. Second, we want a TLD for this thing to point to. I don't feel like going out and buying a new domain name just for this test, nor do I actually care to configure one of the many I already do own and bother with the DNS. I don't want this live to the world. Not yet. And I don't want to write a tutorial on how to do it. If you already have a fully qualified domain name pointing to the server, you can create a subdomain, or we can fake it. I'm going to fake it. We are gonna hack the world, and create our very own TLD called .dev. This shit is amazing &lt;/sarcasm&gt;

Lets set up the virtual host. This is a pretty standard configuration for it, but consider it a starting point. Build on this, or something similar to this:
<pre>
$ cd /usr/local/etc/apache22/vhosts
$ sudo vim rails-todo.conf
</pre>
[sourcecode]
NameVirtualHost *:80

&lt;proxy balancer://todo_cluster&gt;
  BalancerMember http://127.0.0.1:8000
  BalancerMember http://127.0.0.1:8001
  BalancerMember http://127.0.0.1:8002
&lt;/proxy&gt;

&lt;VirtualHost *:80&gt;
  ServerAdmin admin@yourserver.tld
  ServerName todo.dev
  ServerAlias www.todo.dev
  DocumentRoot /usr/local/www/rails/todo/public
  &lt;Directory '/usr/local/www/rails/todo/public'&gt;
    Options FollowSymLinks
    AllowOverride None
    Order allow,deny
    Allow from all
  &lt;/Directory&gt;

  ProxyPass / balancer://todo_cluster/
  ProxyPassReverse / balancer://todo_cluster/

  RewriteEngine On

  RewriteRule ^/$ /index.html [QSA]

  RewriteCond %{DOCUMENT_ROOT}/%{REQUEST_FILENAME} !-f
  RewriteRule ^/(.*)$ balancer://todo_cluster%{REQUEST_URI} [P,QSA,L]

  ErrorLog /usr/local/www/rails/todo/log/apache_error_log
  CustomLog /usr/local/www/rails/todo/log/apache_access_log combined
&lt;/virtualhost&gt;
[/sourcecode]
Now, that should load up next time you restart Apache, due to the wildcard include we added way back up when we configured Apache. Double check that it parses by running:
<pre>
$ sudo apachectl -S
</pre>
You may need to include a virtual host for localhost. Do it in a separate config file though. Don't be including multiple domains in one file, even localhost.

Restart Apache for real this time, and go to the server, or at least try to. If you are on a separate machine, as in your production box is way off in whoknowswhere, or in the server closet of  your office (aka, its not localhost), then you wont get it it. Your machine doesn't know how to translate http://www.todo.dev/ into an IP address, because that domain name doesn't exist to anything except your head.

If you are on a windows box, Google how to change your hosts file. Its somewhere in C:\Windows\system, iirc, but I don't remember and I'm not your nanny or tudor. 
For you normal people running a *nix box, or OS X, on your localhost, your workstation, open up your hosts file and add an entry for this fake domain.
<pre>
localhost $ sudo vim /etc/hosts
</pre><code>
10.22.33.44        todo.dev www.todo.dev
</code>
Obviously, change the IP address to the (Static) IP address of your new Production Server. If its inside your local network, then you can choose the LAN address, or if its outside, you will want the WAN address. Changes take effect immediately, so there is no reloading of some service to do. 

Now point the browser to that domain, and it should pull up. You aren't running Mongrel yet, and even though we changed the routes, you should still be getting the "Welcome to Rails" page. Technically, you do not have a running Rails Application right now, you're just showing a standard HTML page. You might notice that its missing all the images though, and externally linked CSS (which there is none of anyways). Thats because we didn't delete the $APP_DIR/public/index.html file. Keep it for a second. Lets start up Mongrel:
<pre>
$ cd /usr/local/www/apps/todo
$ sudo mongrel_rails start -e production -p 8000 -a 127.0.0.1 -P tmp/ 
pids/mongrel-1.pid
</pre>
Whenever I'm running Mongrel directly like this, I'll open another shell and run this command:
<pre>
$ cd /usr/local/www/apps/todo
$ tail -f log/production.log 
</pre>
But that is not entirely necessary. Up to you. 

Now reload the page in your browser, and you should see the Ruby logo image load up, as well as some others. If thats the case, then congratulations, you're now (almost) your first production Rails application. Finally remove the index.html file from the public directory, then reboot the Mongrel instance. Whenever you modify anything in the public directory, you need to restart your server. You should never be modifying anything inside the production environment while the server is running either, but its only your application and your server, so I guess you can do whatever you want.
<pre>
$ sudo rm public/index.html
$ ps aux | grep mongrel_rails
root  38614  0.0  0.7 75672  1708  p3  S+   10:27PM   0:09.36 /usr/local/bin/ruby18 /usr/local/bin/mongrel_rails ....
$ sudo kill -s USR2 38614
</pre>

That may be slightly confusing to you. Kill is a command I use every so often, but when you break that down, you can see with "ps aux | grep mongrel_rails" we are able to get the process id (PID) of the instance of Mongrel, which is the number after the username that it is being run by. My instance was PID 38614. If you look at your shell that ran mongrel_rails, you can see that it lists some commands that you can send it while it is running. 
<code>
** Starting Mongrel listening at 127.0.0.1:8000
** Starting Rails with production environment...
** Rails loaded.
** Loading any Rails specific GemPlugins
** Signals ready.  TERM => stop.  USR2 => restart.  INT => stop (no restart).
** Rails signals registered.  HUP => reload (without restart).  It might not work well.
** Mongrel 1.1.5 available at 127.0.0.1:8000
</code>
So when we sent the command with kill, all it did was signal that it should restart. That only works if you are running Mongrel as a daemon though. If you are running it in the foreground, its a lot easier to send CTRL-C, and run the command again. 

So, once the server is reloaded, check your site again, and you should see the basic Todo List. Play with it some, enter in an item that you need to get done, like "Go To Bed", or "Get another beer."

Finally, you get a complete Congratulations. Your server is now running live Rails Applications. Al you need to do is move it to a datacenter, assign it a real domain name, and adjust the configurations, namely the Apache vhost, to accept incoming connections.

You may have noticed that we originally configured to have 3 instances of Mongrel running at once, so we can set that up now to be proper. 
<pre>
$ cd /usr/local/www/apps/todo
$ sudo mongrel_rails cluster::configure -e production -p 8000 -N 3 -c /usr/local/www/apps/todo
</pre>
This command will produce a configuration file called config/mongrel_cluster.yml for your Rails application. It instructs Mongrel to use the production enviroment, start at port 8000, and start 3 instances of mongrel_rails. To get that running, try this:
<pre>
$ sudo mongrel_rails cluster::start
</pre>
And test the web server again. Hopefully you shouldn't even know anything has changed. To stop Mongrel:
<pre>
$ sudo mongrel_rails cluster::stop
</pre>
Mongrel is great if you ever need to scale your application. Say it does become the next big thing. Everyone is hitting your website, and its being overloaded. Mongrel can't keep up, but your hardware isn't being taxed completely. Easily open up config/mongrel_cluster.yml, change the number of instances Mongrel should start up, and quickly restart your cluster. Then open up your hosts's .conf file, and apply all those new instances ( http://127.0.0.1:8000 ) to the cluster configuration, and restart Apache. Within a matter of a minute, you can double/triple/quadruple the serving capabilities of your server, until your server becomes taxed, then you'll need to upgrade that. And with a VPS, thats as easy as requesting it, and getting it delivered in a timely manner.

There are a few more things to install with Rails, notably RMagick and ImageMagick, an SCM client service (and possibly server service if thats what you want, but not in this post), and maybe Capistrano to help deploy your applications properly. You can start  to tweak this setup to suit your needs. If you're running this in a VM local to your workstation, like I am doing right now, right now when everything is working decently would be a good time to clone this as a default image, and then start tweaking it. If its screws up and you destroy any functionality, then you can easily restore to a working install.

Lets see how this tutorial can help me better understand FreeBSD as a production server, and lets see if I can get a website that will get Pounded, Beaten and Brusied from a serious slashdot effect.
