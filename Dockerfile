########
# BASE #
########

FROM ruby:2.7-slim AS base

# Define Bundler version as an environment variable
ENV BUNDLER_VERSION=2.4.22

# Install dependencies
RUN apt-get update -qq \
  && apt-get install -y build-essential imagemagick libvips vim libcurl3-openssl-dev curl wget libsqlite3-dev git pkg-config libyaml-dev \
  libxml2-dev libxslt-dev python2 npm

# Install Postgres 14 client
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main" > /etc/apt/sources.list.d/pgdg.list; \
    curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -; \
    apt-get update; \
    apt-get install -y libpq-dev postgresql-client-14;

# Install Node and Yarn
RUN apt-get install -y ca-certificates curl gnupg; \
    mkdir -p /etc/apt/keyrings; \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg; \
    NODE_MAJOR=12; \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" > /etc/apt/sources.list.d/nodesource.list; \
    apt-get update; \
    apt-get install -y nodejs; \
    npm install -g yarn;

# Set the working directory and copy files
WORKDIR /app

# Set Python 2 as default
ENV PYTHON=/usr/bin/python2

########
# DEV #
########

FROM base AS dev

ENV BUNDLE_PATH=/bundle

RUN bundle config set path ${BUNDLE_PATH}
RUN gem install bundler -v ${BUNDLER_VERSION}

COPY . .


########
# PROD #
########

FROM base AS prod

# Install the same version of Bundler as in dev
RUN gem install bundler -v ${BUNDLER_VERSION}

COPY Gemfile Gemfile.lock ./
COPY package.json yarn.lock ./

RUN bundle install --jobs=4 --retry 3
RUN yarn install

COPY . .

# TODO: Right now, we need to precompile assets manually, and commit to git
# RUN RAILS_ENV=production SECRET_KEY_BASE=DUMMY AWS_ACCESS_KEY_ID=DUMMY AWS_SECRET_ACCESS_KEY=DUMMY AWS_BUCKET=DUMMY bin/rails assets:precompile
