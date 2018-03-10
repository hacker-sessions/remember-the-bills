# README
Ruby on Rails API
## Setup with docker
```
$ docker-compose build
$ docker-compose run --rm app bundle exec rails db:create db:migrate
$ docker-compose run --rm website bin/setup
$ docker-compose up
```
`http://0.0.0.0:3000`
