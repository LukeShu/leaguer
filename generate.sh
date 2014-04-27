#!/bin/bash

# The generate.sh bash file is used to generate all of the necessary
# .rb files to run the website

# To modify it and update the app do the following:
#  1. Take care of uncommitted files
#  2. Run `git checkout clean2`
#  3. Run `git pull`
#  4. Make any changes to `generate.sh`, and commit them.
#     If you have committed the desired changes to 'master', you can do
#     this simply with:
#         git checkout master generate.sh
#         git commit -m 'Get changes to generate.sh from master
#  5. Run `./generate.sh`
#  6. Run `git commit -m 'run ./generate.sh'`
#  7. Run `git checkout master`
#  8. Run `git merge clean2`
#  9. Resolve any merge conflicts.
# 10. Run `git push origin clean2`
# 11. Run `git push origin master`

set -xe

# figure out where we are running from
srcdir=$(dirname "$(readlink -f "$0")")
cd "$srcdir"

export RAILS_ENV=development

git rm -rf -- app test config/routes.rb db/migrate || true
git rm -f -- config/initializers/mailboxer.rb || true
git checkout clean-start -- app test config/routes.rb

bundle install

bundle exec rails generate mailboxer:install
bundle exec rails generate simple_captcha
bundle exec rails generate delayed_job:active_record

# The whole shebang, models, views, and controllers
bundle exec rails generate scaffold server default_user_permissions:integer
bundle exec rails generate scaffold match status:integer tournament_stage:references winner:references remote_id:text submitted_peer_evaluations:integer
bundle exec rails generate scaffold team
bundle exec rails generate scaffold alert author:references message:text
bundle exec rails generate scaffold pm author:references recipient:references message:text subject:text conversation:references
bundle exec rails generate scaffold tournament game:references status:integer name:string:uniq min_players_per_team:integer max_players_per_team:integer min_teams_per_match:integer max_teams_per_match:integer sampling_method:string scoring_method:string
bundle exec rails generate scaffold game       parent:references              name:string:uniq min_players_per_team:integer max_players_per_team:integer min_teams_per_match:integer max_teams_per_match:integer sampling_method:string scoring_method:string
bundle exec rails generate scaffold user name:string email:string:uniq user_name:string:uniq
bundle exec rails generate scaffold session user:references token:string:uniq
bundle exec rails generate scaffold bracket user:references tournament:references name:string

# Just models
bundle exec rails generate model       game_setting       game:references name:string vartype:integer type_opt:text description:text display_order:integer default:text
bundle exec rails generate model tournament_setting tournament:references name:string vartype:integer type_opt:text description:text display_order:integer   value:text

bundle exec rails generate model tournament_stage tournament:references structure:text scheduling_method:string seeding_method:string
bundle exec rails generate model statistic user:references match:references name:string value:integer

bundle exec rails generate model remote_username game:references user:references json_value:text

bundle exec rails generate model bracket_match bracket:references match:references predicted_winner:references

bundle exec rails generate model api_request api_name:string

# Join tables
bundle exec rails generate migration CreateTournamentPlayersJoinTable	players	tournaments
bundle exec rails generate migration CreateTournamentHostsJoinTable	hosts	tournaments
bundle exec rails generate migration CreateTeamUserJoinTable	teams	users
bundle exec rails generate migration CreateMatchTeamJoinTable	matches teams

# Just controllers
bundle exec rails generate controller search
bundle exec rails generate controller main

# Migrations
# By having these separate from the original 'generate', it makes it
# not stick these in the views or anything.
bundle exec rails generate migration AddHiddenAttrsToUser password_digest:string permissions:integer

bundle exec rake db:drop
bundle exec rake db:migrate
bundle exec rake db:seed

find app config -type f -name '*.rb' -exec bin/autoindent {} \;

git add app test config db/migrate db/schema.rb Gemfile.lock
