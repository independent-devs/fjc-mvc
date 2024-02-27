# README

## Setup Dev Environment

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

HTML to HAML

```
HAML_RAILS_DELETE_ERB=true rails haml:erb2haml
```
