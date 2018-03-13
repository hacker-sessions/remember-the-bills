# README
Ruby on Rails API
## Setup with docker
```
$ docker-compose build
$ docker-compose run --rm app bundle install
$ docker-compose run --rm app bundle exec rails db:create db:migrate
$ docker-compose run --rm app bin/setup
$ docker-compose up
```
`http://localhost:3000`
