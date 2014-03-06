#!/bin/bash
set -x

# The generate.sh bash file is used to generate all of the necessary .rb files to run the website
# 


# To Start Rails Server:
#   bundle exec rails server
#
# To Clear the Generated Files:
#   git clean -df
#
#NOTEST='--skip-test-unit'

git rm -rf app test config/routes.rb db/migrate
git checkout clean-start -- app test config/routes.rb

# The whole shebang, models, views, and controllers
bundle exec rails generate scaffold server --force $NOTEST
bundle exec rails generate scaffold tournament game:references min_players_per_team:integer max_players_per_team:integer min_teams_per_match:integer max_teams_per_match:integer set_rounds:integer randomized_teams:boolean status:integer $NOTEST
bundle exec rails generate scaffold match tournament:references name:string --force $NOTEST
bundle exec rails generate scaffold team match:references $NOTEST
bundle exec rails generate scaffold alert author:references message:text $NOTEST
bundle exec rails generate scaffold pm author:references recipient:references message:text $NOTEST
bundle exec rails generate scaffold game name:text min_players_per_team:integer max_players_per_team:integer min_teams_per_match:integer max_teams_per_match:integer set_rounds:integer  randomized_teams:boolean --force $NOTEST
bundle exec rails generate scaffold user name:string email:string:uniq user_name:string:uniq
bundle exec rails generate scaffold session user:references


# Just models
bundle exec rails generate model server_settings $NOTEST
bundle exec rails generate model tournament_option tournament:references vartype:integer name:string value:text $NOTEST
bundle exec rails generate model game_option vartype:integer name:string default:text $NOTEST
bundle exec rails generate model score user:references match:references value:integer $NOTEST
# Bridge Models 
bundle exec rails generate model tournament_user_pair tournament:references user:references $NOTEST
bundle exec rails generate model user_team_pair user:references team:references $NOTEST
bundle exec rails generate model team_match_pair team:references match:references $NOTEST

# Just controllers
bundle exec rails generate controller search $NOTEST
bundle exec rails generate controller main $NOTEST
bundle exec rails generate controller static $NOTEST

# Migrations
# By having these separate from the original 'generate', it makes it
# not stick these in the views or anything.
bundle exec rails generate migration AddHiddenAttrsToUser password_digest:string remember_token:string:uniq groups:integer

#for the tournament controller to generate options
#bundle exec rails generate scaffold

bundle exec rake db:drop RAILS_ENV=development
bundle exec rake db:migrate RAILS_ENV=development
bundle exec rake db:seed

git add app test config/routes.rb db/migrate db/schema.rb
