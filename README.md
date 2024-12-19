# README

[Design Link](<https://www.figma.com/file/608pfcvNtMT8wyOHPu5EKL/Full-E-Commerce-Website-UI-UX-Design-(Community)?type=design&node-id=1-3&mode=design&t=pMaFk7PRDGqftoS2-0>)

## Setup Dev Environment

Copy ENV

```
cp .env.template .env
```

Install Dependencies

> Assuming that you have already installed rails in your machine.

> Highly recommend to use any linux distros(Ubuntu, etc..) or use WSL(if you use windows)

```
bundle install
```

Run Postgres docker instance

> Not running rails dev environment as a container because foreman doesn't work well.

```
docker compose up -d
```

Initiate DB

```
rails db:create
rails db:migrate
rails db:seed
```

Run locally

```
bin/dev
```

Test Account

```
phone: 09012345678
pass: password
```

RSpec Unit Test

```
rspec
```

Annotate

```
annotate
```

Rubocop Linter

> run

```
rubocop
```

> with autocorrect

```
rubocop -A
```

Sorbet Type Checking

```
srb tc
```

HTML to HAML

```
HAML_RAILS_DELETE_ERB=true rails haml:erb2haml
```

## Troubleshoot

Libvips

> Ubuntu - Could not open library 'vips.*'

```
sudo apt-get install -y libvips
```

> MAC - Could not open library 'glib-*>'

```
brew install vips
```
