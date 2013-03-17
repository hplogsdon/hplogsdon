require 'rubygems'

desc 'create new post'
task :new do
  raise "usage: rake new[TITLE=My New Post]" unless ENV.include?('TITLE')

  now = Time.now
  title = ENV['TITLE']
  slug = title.downcase.strip.
    gsub(/['`"]/, '').                    # remove apostrpohies and quotes
    gsub(/\s*@\s*/, " at ").              # "@" => " at "
    gsub(/\s*&\s*/, " and ").             # "&" => " and "
    gsub(/\s*[^A-Za-z0-9\.\-]\s*/, '-').  # whitespace
    gsub(/-+/, '-').                      # double dashes to single
    gsub(/\A[-\.]+|[-\.]+\z/, '')         # leading and trailing dashes

  filename = "#{now.strftime('%Y-%m-%d')}-#{slug}.markdown"
  path = File.expand_path(File.join(File.dirname(__FILE__), '_posts', filename))

  post = <<-MD
---
layout: posts
published: false
title: #{title}
date: #{now.to_s}
description: 
author:
---

  MD

  File.open(path, 'w') do |file|
    file.puts post
  end
  puts "Created new post: #{title} at #{path}"

end

