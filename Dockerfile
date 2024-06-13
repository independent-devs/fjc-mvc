FROM ruby:3.2.2-slim-bookworm

RUN apt update -qq && apt upgrade -y && apt-get install -y \
    build-essential \
    shared-mime-info \
    curl \
    libpq-dev \
    libvips

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    corepack enable && corepack prepare yarn@stable --activate

WORKDIR /app

COPY .ruby-version          .ruby-version
COPY Gemfile Gemfile.lock   ./
COPY config.ru              config.ru
COPY Rakefile               Rakefile
COPY bin                    bin/
COPY config                 config/
COPY db                     db/
COPY lib                    lib/
COPY app                    app/
COPY public                 public/
COPY vendor                 vendor/

RUN mkdir -p tmp/pids
RUN gem install bundler
RUN bundle install --without development test
RUN rails assets:precompile --trace

VOLUME ["/app/public"]
EXPOSE 3000
CMD bundle exec puma -C config/puma.rb
