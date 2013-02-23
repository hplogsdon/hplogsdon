--- 
tags: 
- Objective-C
- iOS
- iPhone
- Nib files
wordpress_url: http://blog.hplogsdon.com/?p=388
published: true
layout: post
wordpress_id: 388
categories: 
- Software
- Source Code
description: |
  I'm no expert UI designer, but my mind is better kept in code, not diagrams. When building iOS applications for the iPhone and iPad devices, Interface Builder is a great tool to get a bunch of stuff fleshed out quickly, but at least for myself, I get frustrated quickly when my project grows and I have to constantly switch between a half dozen windows trying to understand why one object isn't updating or displaying correctly. One line of code would fix it, but since the entire interface is in a Nib, I don't even know where to put that one line of code to keep my code clean.

author_login: uxp
author_email: uxp@bsdeviant.org
title: iOS applications without any Nib Files
comments: []

author_url: http://hplogsdon.com
status: publish
date: 2011-02-18 17:36:33 -07:00
author: uxp
---
I'm no expert UI designer, but my mind is better kept in code, not diagrams. When building iOS applications for the iPhone and iPad devices, Interface Builder is a great tool to get a bunch of stuff fleshed out quickly, but at least for myself, I get frustrated quickly when my project grows and I have to constantly switch between a half dozen windows trying to understand why one object isn't updating or displaying correctly. One line of code would fix it, but since the entire interface is in a Nib, I don't even know where to put that one line of code to keep my code clean.

This is where this post comes in. What if you wanted to remove all your Nibs from your project. Everything is easy to implement directly in code, except for that MainWindow.xib that you seem to have to keep. As soon as you try to replace that, the app goes blank. We need to start at the beginning of the application lifecycle, which is in main.m.

If you open up main.m, you'll see the standard stuff that hardly ever changes:

	int main(int argc, char *argv[]) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		int retVal = UIApplicationMain(argc, argv, nil, nil);
		[pool release];
		return retVal;
	}

What does it all mean though? Since Objective C is a superset of C, int main() is the main run loop. Every C and Objective C program starts here. But it doesn't look like it does a whole lot. NSAutoreleasePool is an object that controls and maintains the state of every object's release/retain value. Anytime you allocate and initialize an object, your application's pool object gets notified, and it increases the retain count on that object you just allocated. Whenever you release an object, the pool gets notified and it decreases the retain count. Autorelease is a little different, since it will go around and see if anyone (objects) have any of their hands holding the object, and if they do, it will pass, and if no one seems to have any connection to that object, the pool will release that object. Whenever an object's retain count ends up with no one holding on to it, it calls dealloc. Everyone should know this by reading through Apple's [Memory Management](http://developer.apple.com/library/ios/#documentation/general/conceptual/DevPedia-CocoaCore/MemoryManagement.html) documentation. The second to last statement is the pool releasing itself. When it's "self" ends up with a retain count of 0, it exits cleanly. Not very spectacular, but it does a great job at it.

But how do we stick all that Objective C stuff into the program? And more importantly, what about that whole MainWindow.nib thing we originally set out to do? Well, we have to look at the next line, which does a few things. For one, you can see it initializes an integer called retVal, which obviously holds the return value of the UIApplicationMan() function. Mac OS X Applications will be called NSApplication, but iOS applications will be UIApplication. They both work exactly the same way, at least right here. Going past the NS/UIApplicationMain call, they change quite a bit, but we don't care about that right now. UIApplicationMain() is a standard C function that pulls in all the Objective C stuff, does all the heavy lifting and it ends up running it's own mainloop inside of int main(). Whenever it quits, it returns an integer, which you can easily see where that ends up. If you check out the first two parameters for the UIApplicationMain(), you'll see that they are verbatim passes of whatever arguments were passed to int main(). This lets all UIKit and AppKit applications be called from the terminal, which may be useful for debugging, and converting Cocoa apps to command line utilities. The next two parameters are used only in UIApplication programs and are probably nil in the example, but both of the arguments should be NString values, like @"SomeParameter". NSApplication does something different here, which I'll explain later.

The first is the principalClassName. Basically, all UIKit and AppKit applications are one giant object called a UIApplication, like I mentioned above. This object can be subclassed and you can create your own application type. I can't think of a use that would be anything but some weird edge-case, so unless you need to override it and have a valid use, you probably shouldn't. If you pass nil to it, it automagically loads UIApplication on it's own, so you don't have to decide. This gets loaded via KVC/KVO.

The second nil in the example is the Application Delegate, which gets loaded the same way as above. When you toss your application into it's runloop, and it can't find anything that says "Hay, I've been told I'm in charge of doing this thing", it will quit. By default, iOS applications will look into their bundle at the Info.plist and grab the delegate in charge of the view of MainWindow.nib. If you open up MainWindow.xib in IB, you'll see that there is an AppDelegate object in the list of objects, who's class is MyAppAppDelegate. That basically means that when the application launches, the control is in the hands of the system. The system looks into the Info.plist, which says that the main window is MainWindow.nib, and that says that MyAppAppDelegate is in charge of delegating control over the process. A bit of back-and-forth, but it works well. If you delete MainWindow.xib from your project, your app will look into the Info.plist, and then get all confused because there is no MainWindow to look at, so replace the last argument of nil with whatever your AppDelegate is. You'll also need to remove the "Main nib file base name" key-value pair fron Info.plist. I spend a few minutes at the start of every project cleaning my directories and project up, one of which is refactoring SomeApplicationNameAppDelegate to be named AppDelegate, unless I need more than one, which isn't that common with how I do iOS programming. So for my example, I replace that line with:

	int retVal = UIApplicationMain(argc, argv, nil, @"AppDelegate");

And then, you should all know that AppDelegate ends up loading all the view controllers it needs at its applicationDidFinishLaunching method, and whatever you have configured to be your first/root view gets pushed to the screen. From here, it is some simple coding to get whatever you need.

Hope that helps you understand the few little quirks and functions a iOS application runs through from the time you press the icon on the homescreen to the time applicationDidFinishLaunching gets called.
