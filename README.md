# Hammer Chat

Test application - Chat is running on [http://pitr.sytes.net:3005/](http://pitr.sytes.net:3005/). It's really
a basic implementation. It does not have any persistent backend, messages are limited to 50 in each room and rooms are
dropped from memory after 4 hours of inactivity. You can login in each window as different person, nick and email
for gravatar is required.

## How to run

Install hammer gem, Clone repository

    git clone git://github.com/ruby-hammer/hammer-chat.git

install bundler and run Bundler

    gem install bundler
    bundle install

setup DB

    irb
    >> require 'hammer/app'
    >> DataMapper.auto_migrate!

use Ruby 1.9.(1|2) and run hammer

    hammer

use Chrome, Firefox, Opera or Safari browser, others are untested.

## For more information visit [homepage](http://ruby-hammer.github.com/hammer/).

