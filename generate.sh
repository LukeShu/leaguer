#!/bin/bash

# The generate.sh bash file is used to generate all of the necessary
# .rb files to run the website

set -xe

# figure out where we are running from
srcdir=$(dirname "$(readlink -f "$0")")
cd "$srcdir"

git rm -rf app test config/routes.rb db/migrate
git checkout clean-start -- app test config/routes.rb

bundle exec rails generate simple_captcha

# The whole shebang, models, views, and controllers
bundle exec rails generate scaffold server --force
bundle exec rails generate scaffold match status:integer tournament:references name:string winner:references remote_id:string
bundle exec rails generate scaffold team match:references
bundle exec rails generate scaffold alert author:references message:text
bundle exec rails generate scaffold pm author:references recipient:references message:text
bundle exec rails generate scaffold tournament name:string:unique game:references status:integer \
	min_players_per_team:integer max_players_per_team:integer \
	min_teams_per_match:integer max_teams_per_match:integer \
	set_rounds:integer randomized_teams:boolean
bundle exec rails generate scaffold game \
	name:text \
	min_players_per_team:integer max_players_per_team:integer \
	min_teams_per_match:integer max_teams_per_match:integer \
	set_rounds:integer randomized_teams:boolean
bundle exec rails generate scaffold user name:string email:string:uniq user_name:string:uniq
bundle exec rails generate scaffold session user:references token:string:uniq

# Just models
bundle exec rails generate model server_setting
bundle exec rails generate model game_setting game:references stype:integer name:string default:text description:text type_opt:text display_order:integer
bundle exec rails generate model tournament_preference tournament:references vartype:integer name:string value:text
bundle exec rails generate model score user:references match:references value:integer
bundle exec rails generate model remote_username game:references user:references json_value:text

# Join tables
bundle exec rails generate migration CreateTournamentPlayersJoinTable	players	tournaments
bundle exec rails generate migration CreateTournamentHostsJoinTable	hosts	tournaments
bundle exec rails generate migration CreateTeamUserJoinTable	teams	users
bundle exec rails generate migration CreateMatchTeamJoinTable	matches teams

# Just controllers
bundle exec rails generate controller search
bundle exec rails generate controller main
bundle exec rails generate controller static

# Migrations
# By having these separate from the original 'generate', it makes it
# not stick these in the views or anything.
bundle exec rails generate migration AddHiddenAttrsToUser password_digest:string permissions:integer

#for the tournament controller to generate options
#bundle exec rails generate scaffold

bundle exec rake db:drop RAILS_ENV=development
bundle exec rake db:migrate RAILS_ENV=development
bundle exec rake db:seed

find app -type f -name '*.rb' -exec bin/autoindent {} \;

git add app test config/routes.rb db/migrate db/schema.rb
