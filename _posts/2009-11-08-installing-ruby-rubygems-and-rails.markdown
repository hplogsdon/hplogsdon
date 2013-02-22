--- 
tags: []

wordpress_url: http://hplogsdon.com/?p=223
published: true
layout: post
wordpress_id: 223
categories: 
- General
excerpt: |
  This is the second in a multipart series on how I configured a headless FreeBSD server when I moved to a VPS provider.
  
  Now that you have a fully working FreeBSD Apache, MySQL, PHP server, we're going to see how we go about getting Ruby on Rails applications running.

author_login: uxp
author_email: uxp@bsdeviant.org
title: Installing Ruby, RubyGems, and Rails
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2009-11-08 16:33:11 -07:00
author: uxp
---
This is the second in a multipart series on how I configured a headless FreeBSD server when I moved to a VPS provider.

Now that you have a fully working FreeBSD Apache, MySQL, PHP server, we're going to see how we go about getting Ruby on Rails applications running.
<a id="more"></a><a id="more-223"></a>
In all, its relatively simple, though I ended up having trouble parsing through all the various HowTos posted around the internet and developing a configuration that worked for me. This may not be the ultimate best setup if you want to run the next Twitter application with millions of hits a day, but it will get you running your first "Hello World" application. Hopefully by the time you get that major application, you'll better understand whats going on in your server to tweak it for your needs.

The Ports are great at knowing dependancies for packages, but I like to be able to build the language Ruby before I get into the Rails portion of it.

<pre>
$ cd /usr/ports/lang/ruby18
$ sudo make install clean
</pre>

If Ruby hangs at 
<pre>Generating RI...</pre>
then let it sit for a few minutes. Maybe up to a half hour. Or several hours. It will finally complete, and then we can continue on. 
<pre>
$ cd /usr/ports/www/rubygem-rails
$ sudo make install clean
...
</pre>

Once Rails is installed, we won't have a lot to configure. It all pretty much works out of the box. Lets try and run a test application. 
<pre>
$ mkdir ~/railsapps
$ cd ~/railsapps
$ rails myapp
$ cd myapp
$ ruby script/server
=> Booting WEBrick
=> Rails 2.3.4 application starting on http://0.0.0.0:3000
=> Call with -d to detach
=> Ctrl-C to shutdown server
</pre>
and check to see that its running on http://$IPADDRESS:3000/ And click on the link "About your application’s environment" which will run a bit of rails code, which is just enough to either give indication of no problem, or an error. On this server, I must have missed the configuration to install sqlite3-ruby from ports. I'm getting a sqlite3-ruby not found error. So I'll run:
<pre>
$ cd /usr/ports/databases/rubygem-sqlite3 
$ sudo make install clean
</pre>
And then retest the application with sqlite. Now, I don't want to run production from sqlite, but its really good to have it for simple tests. For production, I'll be running mysql, so lets go ahead and set up some databases and a sample rails app for it.
<pre>
$ mysql -u root -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 3
Server version: 5.0.87 FreeBSD port: mysql-server-5.0.87

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> CREATE DATABASE myapp_development;
Query OK, 1 row affected (0.05 sec)

mysql> CREATE DATABASE myapp_test;       
Query OK, 1 row affected (0.00 sec)

mysql> CREATE DATABASE myapp_production;
Query OK, 1 row affected (0.00 sec)

mysql> GRANT ALL PRIVILEGES ON myapp_development.* TO 'user'@'localhost' IDENTIFIED BY 'p@ssw0rd';
Query OK, 0 rows affected (0.05 sec)

mysql> GRANT ALL PRIVILEGES ON myapp_test.* TO 'user'@'localhost' IDENTIFIED BY 'p@ssw0rd';
Query OK, 0 rows affected (0.01 sec)

mysql> GRANT ALL PRIVILEGES ON myapp_production.* TO 'user'@'localhost' IDENTIFIED BY 'p@ssw0rd';
Query OK, 0 rows affected (0.00 sec)

mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.01 sec)

mysql> EXIT;
Bye
</pre>
And then create a new rails app that uses the databases we just set up:
<pre>
$ cd ~/railsapps
$ rm -rf myapp
$ rails myapp -d mysql
$ cd myapp/
$ vim config/database.yml
</pre>
Then type some simple commands to change things around to reflect our application's databases:
<code>
:%s/username: root/username: user/g
:%s/password:/password: p@ssw0rd/g
:wq!
</code>
&lt;gloat&gt;see how much easier VIM is than TextMate? hehe.&lt;/gloat&gt;
Then start up that server with:
<pre>
ruby script/server
</pre>
And do the same checks.

If everything is good, then lets continue, otherwise debug your error messages and fix them before continuing. Also, since this will end up being a production server, you might want to consider deleting those databases, and that user's grants. I like things clean, and there is no reason to have them anymore.

If you don't have any continuing issues, proceed to Part 4: <a href="http://hplogsdon.com/configuring-mongrel-and-mongrel-cluster/">Configuring Mongrel and Mongrel Cluster</a>
