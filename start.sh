#!/bin/bash

generate.sh
bundle exec rails server 2> server.talk &

