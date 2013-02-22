--- 
tags: []

wordpress_url: http://blog.hplogsdon.com/?p=379
published: true
layout: post
wordpress_id: 379
categories: 
- Software
- Web Development
excerpt: |
  It's been a while since I've posted anything. Been a busy year so far. So busy, that I haven't hacked at my apache configuration in a while, and have been focusing on frontends of applications and stayed away from the backends. Up until today. I ran into an issue that required me to reload my php.ini, by restarting apache. No big deal, except for this little error:
  <code>/usr/sbin/apachectl: line 82: ulimit: open files: cannot modify limit: Invalid argument
  </code>

author_login: uxp
author_email: uxp@bsdeviant.org
title: "Mac OS 10.6.5 - /usr/sbin/apachectl: line 82: ulimit: open files: cannot modify limit: Invalid argument "
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2011-01-23 22:14:58 -07:00
author: uxp
---
It's been a while since I've posted anything. Been a busy year so far. So busy, that I haven't hacked at my apache configuration in a while, and have been focusing on frontends of applications and stayed away from the backends. Up until today. I ran into an issue that required me to reload my php.ini, by restarting apache. No big deal, except for this little error:
<code>/usr/sbin/apachectl: line 82: ulimit: open files: cannot modify limit: Invalid argument
</code>
<a id="more"></a><a id="more-379"></a>
What the hell? A little digging around and I see that Mac OS 10.6.5 updated the included Apache package, including some bug fixes.  Apparently they left out a change that would have prevented this error. Luckily it is a quick fix, make a backup copy, and then open up /usr/sbin/apachectl in your favorite editor with root permissions and search for "ULIMIT_MAX_FILES":
<code>
sudo cp /usr/sbin/apachectl /usr/sbin/apachectl.BAK
sudo vim /usr/sbin/apachectl
</code>

And then remove everything in the quotes, as shown in this diff:
[sourcecode language="diff"]
diff -rupN a/apachectl b/apachectl
--- a/apachectl	2011-01-23 21:03:49.000000000 -0700
+++ b/apachectl	2011-01-23 21:04:08.000000000 -0700
@@ -61,7 +61,7 @@ STATUSURL=&quot;http://localhost:80/server-st
 # number of file descriptors allowed per child process. This is
 # critical for configurations that use many file descriptors,
 # such as mass vhosting, or a multithreaded server.
-ULIMIT_MAX_FILES=&quot;ulimit -S -n `ulimit -H -n`&quot;
+ULIMIT_MAX_FILES=&quot;&quot;
 # --------------------                              --------------------
 # ||||||||||||||||||||   END CONFIGURATION SECTION  ||||||||||||||||||||
 [/sourcecode]

Then you're good to go. If you are uncomfortable editing system commands in an editor, feel free to save that diff to your home directory as a file called apachectl.patch, or similar and run it with:
<pre>
patch -p1 < ~/apachectl.patch
</pre>

That should take care of everything. For more information on diff files and patching, query:
<code>
man patch
man diff
</code>
or check out this article <a href="http://stephenjungels.com/jungels.net/articles/diff-patch-ten-minutes.html">The Ten Minute Guide to diff and patch</a> which I'll admit to referring to every once in a while when I need to create a patch by hand. </pre>
