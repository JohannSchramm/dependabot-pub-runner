#!/bin/sh -l

cd /home/app/dependabot-pub-runner && bundle exec ruby ./update-pub.rb
