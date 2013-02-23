--- 
tags: []
wordpress_url: http://hplogsdon.com/?p=286
published: true
layout: post
wordpress_id: 286
categories: 
- General
- Source Code
description: Some time ago when I first started hacking WordPress (about v2.2 iirc) I can remember having to go into my MySQL terminal and replace the admin password due to me not changing the random string they gave you just after you installed it. It wasn't fun to do, but it worked.
author_login: uxp
author_email: uxp@bsdeviant.org
title: Changing Wordpress Passwords via SQL
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2010-03-06 20:15:58 -07:00
author: uxp
---
Some time ago when I first started hacking WordPress (about v2.2 iirc) I can remember having to go into my MySQL terminal and replace the admin password due to me not changing the random string they gave you just after you installed it. It wasn't fun to do\*, but it worked. I also learned to change the default password string to something more memorable, or at least write the thing down somewhere. Back then, WordPress would use an MD5 hash as the password stored in the Database.

Well, I havent had the need to do anything like that for a while, but a friend and fellow WordPress hacker recently asked if I had, or knew if it was possible to change the WordPress admin password from raw SQL. He had a SQL dump for a WordPress site he had completely archived some time ago and forgot the password when he went to restore it. Well, I said yeah, hop into the terminal and issue

	md5 -s "thepassword"

and then replace that with the string in the sql dump. Easy. Well, until he asked why the new MD5 hash was so much shorter than the old hash.

Wordpress upgraded the password storing procedure between the time I needed to replace the password and whenever he archived the site to use a salt value with a hashing library called [PHPass](http://www.openwall.com/phpass/). This requires a bit of a workaround to get running properly.

So because I figure other people will be running into this problem in the future, I wrote up a standalone script that will give you a salted hash value which you can insert into your WordPress database via the MySQL terminal. The actual function is nearly a copy/paste from the function that WordPress uses when you create a new user, or change a user's password.

Here's the relevant part of the code:

	<?php global $wp_hasher; ?>
							<form action="#" method="post" accept-charset="utf-8">
							<input type="text" name="password" value="">
					<p><input type="submit" value="Generate ..."></p>
					</form>
	<?php
	if (empty($_POST['password'])) {
			echo "Password is empty";
	} else {
			if (empty($wp_hasher)) {
					require_once('wp-includes/class-phpass.php');
					$wp_hasher = new PasswordHash(8, TRUE);
			}
			$pw_hash = $wp_hasher->HashPassword($_POST['password']);
			echo 'Submitted password hashes to: '. $pw_hash;
	?>

And you can find the final result here: [WP Password Hash Generator](/password.php)

and if you want to copy it to use on your server, curl/wget it via this source link: [WP Password Hash Generator - Source](/password.phps)


\*Actually it was rather fun cause I hadn't done it before and it gave me insight on how WordPress structures the database.
