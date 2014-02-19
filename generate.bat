
bundle exec rails generate scaffold server
bundle exec rails generate scaffold tournament
bundle exec rails generate scaffold match
bundle exec rails generate scaffold team
bundle exec rails generate scaffold user
bundle exec rake db:drop RAILS_ENV=development
bundle exec rake db:migrate RAILS_ENV=development
