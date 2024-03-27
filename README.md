# README

[Design Link](<https://www.figma.com/file/608pfcvNtMT8wyOHPu5EKL/Full-E-Commerce-Website-UI-UX-Design-(Community)?type=design&node-id=1-3&mode=design&t=pMaFk7PRDGqftoS2-0>)

## Setup Dev Environment

Copy ENV

```
cp .env.example .env
```

Install Dependencies

```
bundle
```

Database

```
rails db:create
rails db:migrate
rails db:seed
```

Run locally

```
./bin/dev
```

Test Account

```
phone: 09012345678
pass: password
```

RSpec Test

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

HTML to HAML

```
HAML_RAILS_DELETE_ERB=true rails haml:erb2haml
```
