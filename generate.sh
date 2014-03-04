#!/bin/bash

# The generate.sh bash file is used to generate all of the necessary .rb files to run the website
# 


# To Start Rails Server:
#   bundle exec rails server
#
# To Clear the Generated Files:
#   git clean -df
#
#NOTEST='--skip-test-unit'

set -x
bundle exec rails generate scaffold server --force $NOTEST
bundle exec rails generate scaffold tournament game:references $NOTEST
bundle exec rails generate scaffold match tournament:references name:string --force $NOTEST
bundle exec rails generate scaffold team $NOTEST
bundle exec rails generate scaffold alert author:references message:text $NOTEST
bundle exec rails generate scaffold pm author:references recipient:references message:text $NOTEST
bundle exec rails generate scaffold game name:text players_per_team:integer teams_per_match:integer set_rounds:integer randomized_teams:integer --force $NOTEST
bundle exec rails generate scaffold user name:string email:string user_name:string $NOTEST

bundle exec rails generate model game_attribute game:references key:text type:integer $NOTEST
bundle exec rails generate model server_settings $NOTEST
bundle exec rails generate model user_team_pair user:references team:references $NOTEST
bundle exec rails generate model team_match_pair team:references match:references $NOTEST

bundle exec rails generate controller search $NOTEST
bundle exec rails generate controller main $NOTEST
bundle exec rails generate controller static $NOTEST
bundle exec rails generate controller sessions

#added some stuff to the database

rails generate migration add_index_to_user_email
rails generate migration add_index_to_user_name
rails generate migration add_password_digest_to_users
rails generate migration add_remember_token_to_users

#for the tournament controller to generate options
bundle exec rails generate model tournament_option $NOTEST

bundle exec rake db:drop RAILS_ENV=development
bundle exec rake db:migrate RAILS_ENV=development
bundle exec rake db:seed
#bundle exec rails generate scaffold 
