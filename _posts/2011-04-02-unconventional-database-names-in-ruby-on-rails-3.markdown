--- 
tags: []
wordpress_url: http://blog.hplogsdon.com/?p=393
published: true
layout: post
wordpress_id: 393
categories: 
- Software
- Source Code
- Web Development
description: |
  One of the great things about Ruby on Rails is it's "Opinionated Conventions". Not having to worry about linking a model to a database table is one of the most brilliant ideas I have come across. I'm glad various other frameworks across many languages are following that path. Does it really matter if your table name is "posts" or "post"? Well, for me right now, yes. And it sucks. Thankfully Rails allows us to go against convention when we really need to.
author_login: uxp
author_email: uxp@bsdeviant.org
title: Unconventional Database Table Names in Ruby on Rails 3
comments: []
author_url: http://hplogsdon.com
status: publish
date: 2011-04-02 19:02:14 -06:00
author: uxp
---
One of the great things about Ruby on Rails is it's "Opinionated Conventions". Not having to worry about linking a model to a database table is one of the most brilliant ideas I have come across. I'm glad various other frameworks across many languages are following that path. Does it really matter if your table name is "posts" or "post"? Well, for me right now, yes. And it sucks. Thankfully Rails allows us to go against convention when we really need to.

I've got a SQL database with some images stuck in there as binary blobs from a WordPress shopping cart plugin. Not the smartest idea in the world, but I guess it works for the plugin. Unfortunately, it doesn't work with anything else unless I convert everything to that format. I actually need to migrate all the data in this database over to another application, which is a different PHP e-commerce application, and because I know Ruby fairly well, as well as ActiveRecord, the Rails ORM, I figured it would be pretty easy to plug in a simple script using a bunch of the Rails gems in the middle to transfer it all. I've run into a couple issues, mostly due to the way the WordPress plugin designed their database tables, which requires me to hack at my Rails-like script.

I'm not using a full Rails application for this script, but I am loading a lot of the components of Rails. To make my life easier, I started a new Rails application, and slowly took out a few components at a time until I was left with a skeleton project consisting of some Rake tasks and ActiveRecord models, plus all their dependancies.

Long story short, the current WordPress database has tables with a  prefix similar to "wp_q9rdw3\_". I'm assuming that the shared hosting provider that was hosting the WordPress site configured the WP database to have that prefix for the global WordPress install. Next, the plugin prefixes it's tables with it's name, which results in a table like "wp_q9rdw3_plugin_product". Because I don't care about the actual WordPress database, only the plugin data, I can set a Rails configuration variable in config/application.rb to have a global prefix of "wp_q9rdw3_plugin\_". Take note in the original table name though, it's a singular name: "product" instead of "products".

Rails (ActiveRecord, specifically) also gives us an option to make our Rails database table names to be singular. This is pretty cool stuff, and I was actually surprised to see it in the API.

So, instead of having to manually configure a unique and cryptic table name for every single one of my models, and then manually link each model together to figure out my relationships by specifying tables and fields (not very DRY, if you ask me) all I have to do is write 2 lines of code in config/application.rb:


	module MyApp
		class Application < Rails::Application
			# Initial configuration stuff here...
			config.active_record.table_name_prefix = 'wp_q9rdw3_plugin_'
			config.active_record.pluralize_table_names = false
		end
	end

I love Rails.
