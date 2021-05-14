# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 
  2.6.3

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

start your Postgres server
```
psql
CREATE USER jun SUPERUSER;
\q

rake db:create
rails db:migrate
rails db:seed
rails server
```
