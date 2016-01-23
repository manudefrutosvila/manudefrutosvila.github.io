#!/bin/bash

# Deploy script thanks to https://github.com/PascalPrecht

if [ ! -d "dist" ]; then
  echo "\033[0;31mDirectory 'dist' does not exist. Please run 'gulp serve' to create a new distribution\033[0m"
else
  echo "\033[0;32mDeploying new manudefrutosvila.github.io site...\033[0m"

  # delete old gh-pages branch
  git branch -D deploy

  git checkout -b deploy

  # Add changes to git.
  git add -f dist

  # Commit changes.
  msg="chore(*): adding distribution `date`"
  if [ $# -eq 1 ]
    then msg="$1"
  fi
  git commit -m "$msg"

  git subtree split -P dist -b deploy-dist

  # Push source and build repos.
  git push -f origin deploy-dist:master
  git branch -D deploy-dist
  git checkout dev
  git branch -D deploy
fi
