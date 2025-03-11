#!/bin/bash

# Confirm that the Heroku CLI is installed
if ! [ -x "$(command -v heroku)" ]; then
  echo 'Error: Heroku CLI is not installed.' >&2
  exit 1
fi

# Confirm that Docker Compose is installed
if ! [ -x "$(command -v docker compose)" ]; then
  echo 'Error: Docker Compose is not installed.' >&2
  exit 1
fi

# Confirm that the user would like to proceed
echo "Are you sure? Syncing will overwrite your local database with production data. (Y/n)"
read -r response
if [[ "$response" != "y" && "$response" != "Y" ]]; then
    echo "Action canceled."
    exit
fi

# Create a Heroku database backup
echo "Backing up production database..."
heroku pg:backups:capture --app catholichighschoolchicago
heroku pg:wait --app catholichighschoolchicago

# Download the backup
echo "Downloading backup..."
curl -o latest.dump `heroku pg:backups:url --app catholichighschoolchicago`

# Delete the existing local database
echo "Deleting local database..."
docker compose run -e DISABLE_DATABASE_ENVIRONMENT_CHECK=1 app bin/rails db:drop
docker compose run app bin/rails db:create

# Import the backup to the local database
echo "Importing backup..."
docker compose run app pg_restore -U postgres -h db -d catholichighschoolchicago_development latest.dump

# Delete the latest.dump
echo "Deleting backup..."
rm latest.dump

# Done
echo "Done"
