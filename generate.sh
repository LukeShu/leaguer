#!/bin/bash

#
# To Start Rails Server:
#   bundle exec rails server
#
#
#

set -x
bundle exec rails generate scaffold server
bundle exec rails generate scaffold tournament
bundle exec rails generate scaffold match tournament:references
bundle exec rails generate scaffold team 
bundle exec rails generate scaffold user name:text pw_hash:text groups:integer 
bundle exec rails generate model user_team_pair user:references team:references
bundle exec rails generate model team_match_pair team:references match:references
bundle exec rails generate scaffold alert author:references message:text
bundle exec rails generate scaffold pm author:references recipient:references message:text
bundle exec rails generate model server_settings
bundle exec rails generate controller search
bundle exec rails generate controller main
bundle exec rake db:drop RAILS_ENV=development
bundle exec rake db:migrate RAILS_ENV=development
#bundle exec rails generate scaffold 
