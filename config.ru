#!/usr/bin/env ruby
require 'rubygems'
require 'gollum/app'
require 'omnigollum'
require 'omniauth-google-oauth2'


use_oauth = !ENV['GOOGLE_OAUTH2_CLIENT_ID'].nil? and !ENV['GOOGLE_OAUTH2_CLIENT_SECRET'].nil?

gollum_path = File.expand_path("../wiki.notes") # CHANGE THIS TO POINT TO YOUR OWN WIKI REPO


wiki_options = {}
wiki_options = {:universal_toc => false}

wiki_options[:css] = true # Equivalent to --css
#wiki_options[:js] = true # Equivalent to --js
wiki_options[:template_dir] = "templates" # Equivalent to --template-dir
#wiki_options[:page_file_dir] = "posts" # Equivalent to --page-file-dir
#wiki_options[:gollum_path] = path # Equivalent to ARGV
#wiki_options[:ref] = ref ## Equivalent to --ref
#wiki_options[:repo_is_bare] = true # Equivalent to --bare
wiki_options[:allow_editing] = !use_oauth # # Equivalent to --no-edit
#wiki_options[:live_preview] = true # Equivalent to --live-preview
#wiki_options[:allow_uploads] = true # Equivalent to --allow-uploads
#wiki_options[:per_page_uploads] = true # When :allow_uploads is set, store uploads under a directory named after the page, as when using --allow-uploads page
#wiki_options[:mathjax] = true # Equivalent to --mathjax
#wiki_options[:mathjax_config] = source # Equivalent to --mathjax-config
#wiki_options[:user_icons] = source # Equivalent to --user-icons
wiki_options[:show_all] = true # Equivalent to --show-all
#wiki_options[:collapse_tree] = true # Equivalent to --collapse-tree
wiki_options[:h1_title] = true # Equivalent to --h1-title
wiki_options[:sitemap] = true # Equivalent to --sitemap



if use_oauth then
  options = {
    :providers => Proc.new do
      provider :google_oauth2, ENV['GOOGLE_OAUTH2_CLIENT_ID'], ENV['GOOGLE_OAUTH2_CLIENT_SECRET'], {}
    end,
    :dummy_auth => false,
    :protected_routes => [
      '/gollum/revert/*',
      '/gollum/revert',
      '/gollum/create/*',
      '/gollum//create',
      '/gollum/edit/*',
      '/gollum/edit',
      '/gollum/rename/*',
      '/gollum/rename',
      '/gollum/delete/*',
      '/gollum/delete'
    ],
    :authorized_users => [
      "euikook@gmail.com",
      "euikook@harues.com"
    ]
  } 
  Precious::App.set(:omnigollum, options)
  Precious::App.register Omnigollum::Sinatra
end


Precious::App.set(:gollum_path, gollum_path)
Precious::App.set(:default_markup, :markdown) # set your favorite markup language
Precious::App.set(:wiki_options, wiki_options)
run Precious::App
