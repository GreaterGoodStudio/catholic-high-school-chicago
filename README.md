# Catholic High School Chicago

Brought to you by the [Big Shoulders Fund](http://www.bigshouldersfund.org/).

## Requirements

* Ruby ~>2.4
* PostgreSQL 9.4+
* Redis

## External Services

* Heroku (app hosting)
* Google Fonts (webfonts)
* Mapbox (maps)

## Development

Create a feature branch off of the `master` branch: `git checkout -b feature-name`. Create a pull request to be merged back into `master`.

## Deploying

Manually precompile assets (and commit them to the repo)

```
docker compose run app /bin/bash
RAILS_ENV=production SECRET_KEY_BASE=DUMMY AWS_ACCESS_KEY_ID=DUMMY AWS_SECRET_ACCESS_KEY=DUMMY AWS_BUCKET=DUMMY bin/rails assets:precompile
```

Deploy to Heroku:

```
git push heroku master
```