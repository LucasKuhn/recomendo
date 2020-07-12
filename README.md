# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# To edit secrets
```
$ bundle exec rails credentials:edit
```
And if you haven't already, set your editor to open credentials:
```
export EDITOR='atom --wait'
```
# To reset migrations
```
rails db:migrate:reset
rails db:seed
```
On heroku
```
heroku pg:reset -a recomendo
heroku run rails db:migrate -a recomendo
heroku run rails db:seed -a recomendo
```


# To edit devise views
1. Check what view you are using (based on [Devise i18n](https://github.com/tigrish/devise-i18n))
2. Get some good references at [Devise bootstrap views](https://github.com/hisea/devise-bootstrap-views)
