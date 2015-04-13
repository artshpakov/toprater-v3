#!/bin/bash

cd /toprater && bundle exec puma -C config/puma/production.rb
