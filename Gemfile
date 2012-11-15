###########################################
# NOTHING GOES IN HERE WITHOUT A COMMENT! #
###########################################

# The repository from which we're fetching our rubygems.
source 'http://rubygems.org'

# Rails. Duh.
gem 'rails', '3.2.8'

# Haml is a templating language. It compiles to HTML.
gem 'haml'

# jquery-rails provides the jQuery and jQuery UI JavaScript files,
# as well as the UJS (Unobtrusive JavaScript) adapter.
gem 'jquery-rails'

# jquery-ui-rails provides the jQuery UI assets (JS, stylesheets, images).
gem 'jquery-ui-rails'

# Validate e-mail addresses against RFC 2822 and RFC 3696.
gem 'validates_email_format_of'

# formtastic is a Rails form builder plugin
# with semantically rich and accessible markup.
# formtastic-bootstrap is a gem built on top of
# this to create markup which adheres to bootstrap.
gem 'formtastic-bootstrap'

#A simple date validator for Rails 3.
gem 'date_validator'

#A gem handling file uploading and attatching them to models
gem 'paperclip'

# Offers a declarative approach to user authorization.
gem 'declarative_authorization'

# Bootstrap is a toolkit from Twitter designed to kickstart development
# of webapps and sites. It includes base CSS and HTML for typography,
# forms, buttons, tables, grids, navigation, and more.
gem 'twitter-bootstrap-rails'

# Redcarpet is Ruby library for Markdown processing that smells like
# butterflies and popcorn. Redcarpet is powered by the Sundown library.
gem 'redcarpet'

# SamfundetDomain is a gem which provides the application with samfundets domain models.
gem 'samfundet_domain', :git => "git://github.com/Samfundet/SamfundetDomain.git"

# SamfundetAuth is a gem which provides the application with methods for authenticating against mdb2.
gem 'samfundet_auth', :git => "git://github.com/Samfundet/SamfundetAuth.git"

# bcrypt() is a sophisticated and secure hash algorithm
# designed by The OpenBSD project for hashing passwords.
# bcrypt-ruby provides a simple wrapper for safely handling passwords.
gem 'bcrypt-ruby', :require => 'bcrypt'

# rails-translate-routes is a gem which provides the application
# with translated routes in accordance with a user-defined,
# yaml-style dictionary.
gem 'rails-translate-routes'

# Roadie tries to make sending HTML emails a little
# less painful in Rails 3 by inlining stylesheets and
# rewrite relative URLs for you.
gem 'roadie'

# Gems used only for assets and not required
# in production environments by default.

group :production do
  # # PostgreSQL adapter. See: config/database.yml
  gem 'pg'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'

  gem 'less-rails'
end

group :development do
  # annotate adds schema information from the database, in the form of
  # Ruby comments, to model files so that we can see which columns
  # are actually in the database.
  gem 'annotate'

  # Faker is a library that generates fake data (names, email addresses, etc.)
  gem 'faker'

  # SQLite adapter. See: config/database.yml
  gem 'sqlite3'
end
