#!/bin/bash
bundle exec rake db:drop && bundle exec rake db:migrate && bundle exec rake db:seed
