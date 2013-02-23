--- 
tags: []

wordpress_url: http://hplogsdon.com/?p=217
published: true
layout: post
wordpress_id: 217
categories: 
- General
description: |
  This is the second in a multipart series on how I configured a headless FreeBSD server when I moved to a VPS provider. 

author_login: uxp
author_email: uxp@bsdeviant.org
title: Configuring the FAMP Stack
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2009-11-08 16:31:46 -07:00
author: uxp
---
This is the second in a multipart series on how I configured a headless FreeBSD server when I moved to a VPS provider. 

As noted earlier, I'm more concerned about running Rails apps in a Production environment, partly because I've never run any in a production environment, and i've never set up a production environment. However, with that said, I think it is hilariously dumb not to include other web language capabilities to the server. Evern though I'm not gung-ho about PHP, I'm also aware that it runs a significant portion of the application on the internets. I'm currently writing this blog post on WordPress, and I have no unbiased issues due to it. So before we get all complicated with Rails, lets get the standard basic FAMP server running and dishing out pages.

I like to start with MySQL. Its a decent database system. Its common enough (read: everywhere) that I usually don't have any problem favoring it. I'm also used to it more than anything else. If you want something else, skip over this section and choose your own flavor.

	$ cd /usr/ports/databases/mysql50-server
	$ sudo make install clean

Go grab a beer while that does its thing.

Install your mysql database that will be the template for all new databases to be copied from:

	$ sudo /usr/local/bin/mysql_install_db

Now, start up the database server, but take a look at what was installed. Be sure to understand where the default socket is, and where the binaries were put, and what user mysqld will be run as.

	sudo /usr/local/bin/mysqld_safe

Get any error messages? If you didn't, good on you. If you did, then thats perfectly normal. I don't think I've ever not had an issue, albeit minor, when I've installed MySQL. In a new server shell, I usually tail the resulting error file, which is generally:

	sudo tail -f /var/db/mysql/hostname.err

Which should bring up the error stating that mysql doesn't have permission on the directory, and cannot find the socket. The most common fix for me has been:

	sudo chown -R mysql /var/db/mysql


If you have other errors, google the error message and see what other people have done to fix it. See if you can apply those same ideas to your issue.

Try to start mysqld_safe again, keeping an eye on that error logfile. If everything works normally, close the logfile, and kill the process (killall -9 mysql), then configure your administrator (root) password:

	$ sudo /usr/local/bin/mysqladmin -u root password 'newpassword'

On a development box, I have no problem keeping the root password blank. I jump in and out of the mysql console/shell so frequently, I usually can't be bothered to put in a complicated password. But on production, this is designed to be secure, safe, and relatively static. Set up a good secure password. If you need to be going in and out of databases enough on the production machine, you're doing it wrong.

I originally thought that PHP gets installed before Apache, but Apache is a dependency of PHP, for pretty obvious reasons. Unfortuantely, when I started configuring it, it started to pull down apache1.3. I want Apache2.2, so I'll go ahead and configure it now... But if I was to do that, I'd get this error:

	===>   apache-2.2.13 depends on package: libtool>=2.2 - not found
	===>   Found libtool-1.5.26, but you need to upgrade to libtool>=2.2.

Which ends up being somewhat complicated if you've never run into it before. (un)Fortunately, I have before, and it is all explained pretty nicely in "/usr/ports/UPDATING":

	20090802:
	AFFECTS: users of devel/libtool15 and devel/libltdl15
	AUTHOR: mezz@FreeBSD.org
	
	The devel/libtool15 and devel/libltdl15 ports have been moved to libtool22
	and libltdl22, respectively, then updated to 2.2.6a. You will need to run
	portmaster or portupgrade to properly perform the upgrade:
	
	Portmaster:
	-----------
	
	portmaster -o devel/libtool22 devel/libtool15
	portmaster -o devel/libltdl22 devel/libltdl15
	
	Portupgrade:
	------------
	
	portupgrade -o devel/libtool22 libtool-1.5\*
	portupgrade -o devel/libltdl22 libltdl-1.5\*
	
	After that, you will need to rebuild all ports that depend on libltdl.
	Since all dependent ports' PORTREVISIONs have been bumped, you can run
	portupgrade or portmaster with '-a' to complete the upgrade.


So lets continue on, I use portmaster, since it really is a tiny little shellscript, where as portupgrade has a larger database driven design. Run the commands given, and all should be well.

Now we can start on getting Apache2.2 running:

	$ cd /usr/ports/www/apache22/
	$ sudo make install clean

Its time for you to think about what you will need, and when you will need it. It doesn't take much to go back and reconfigure and recompile Apache, but its best not to. Figure out what you want to do with it, and decide how to configure it now.

Apache has great support for multiple sites using the virtual hosts configuration. Its dead simple to get multiple domains running off of one box, with individual IPs or even a shared IP. This post wont go into detail on how to set up Apache to serve multiple domains, but the server I am building will eventually host multiple domains out of port 80 with a shared IP, and will host a secure site out of port 443 on a separate IP address. It will be possible to host additional secure sites, but those will require their own IP address and cert. Because I want multiple domains, I'll probably (read: guaranteed) end up running something like wordpress or drupal, which are both written in PHP. I'm not a fan of writing PHP, but PHP can, and has, been the foundation for some great applications. But thats a political viewpoint that has no foundation either way. This is your server now, so if you want PHP, then great, install it. Or put Perl or Python in the stack, or whatever you feel you will use.

I'll go ahead with PHP, you do whatever serves you best:

	$ cd /usr/ports/lang/php5
	$ sudo make install

For this machine, I won't be building with any fastcgi support, nor any of the CGI only configurations, but I will enable "Build CGI version", as well as "Build CLI version". Probably not necessary, but thats what I'm doing. Be sure to build the Apache module as well.

Now the standard FAMP stack is setup, but lets finish up all the configuration right now, make sure everything works before we include Rails configurations. I noticed on my install, mysql_enable and apache22_enable directives were not copied into my rc.conf file. Check to make sure they are, so whenever you reboot, they will start up.

To check if PHP is working properly, toss this file into "/usr/local/www/apache22/data/"

	<?php
			phpinfo();
	?>

And name it phpinfo.php . If it pulls up that same text, then you need to add the mime configurations for PHP files into httpd.conf.

    AddType application/x-httpd-php .php
    AddType application/x-httpd-php-source .phps


On production servers, I don't allow users to host websites and file out of their home directories. Back in the day, It was okay to do so, but these days, you might as well but a new domain name and set up your private WordPress blog. No reason to to have http://www.example.com/~user/

For my virtual hosts configurations, I've had some boxes have enough virtual hosts to make my httpd-vhosts.conf file look pretty cumbersome, so I go ahead and do this:

	$ sudo mkdir /usr/local/etc/apache22/vhosts
	$ sudo cp /usr/local/etc/apache22/extra/httpd-vhosts.conf /usr/local/etc/apache22/vhosts/example.conf

And update httpd.conf to reflect the changes:

	Include etc/apache22/extra/*.conf

then edit the example.conf file, commenting every active line, because I don't really want anyone trying to access dummy-host.example.com on my servers. Now when I want to add a domain to serve, I can copy the file, edit it for the specific domain, reload Apache, and it will all work.

Continue on to Part 3: [Installing Ruby, RubyGems, and Rails](/installing-ruby-rubygems-and-rails/)


