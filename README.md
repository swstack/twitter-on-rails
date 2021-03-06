# README - [Fun With Twitter](http://fun-with-twitter.herokuapp.com/)


----------------------

## System Dependencies

* ruby
```sh
$ sudo apt-get install ruby
```

* rails
```sh
$ gem install rails
```

* postgresql
```sh
$ sudo apt-get install postgresql
```

* libpq-dev
```sh
$ sudo apt-get install libpq-dev
```

## Database Creation

The development environment environment expects a local postgresql database with a specific owner to operate correctly.  First run the `psql` command as the postgres user:
```sh
$ sudo -u postgres psql
```

Now setup the database:
```sh
postgres=# create user fwt with password 'fwt';
postgres=# create database fun_with_twitter_dev owner fwt;
postgres=# create database fun_with_twitter_test owner fwt;

```

## Running the app
Bootstrap your ruby environment by installing all of the neccessary gems:
```sh
$ bundle install
```

And now run the migrations:
```sh
$ rake db:migrate
```

Start:
```sh
$ rails server
```

## Tests
Run the test suite like so:
```sh
$ rake test
```

## Heroku Setup

First install the Heroku CLI:
```sh
$ wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
```

Setup a new heroku remote in git:
```sh
$ git remote add heroku git@heroku.com:fun-with-twitter.git
```

Login to heroku:
```sh
$ heroku login
```

Add your public key to the Heroku git server:
```sh
$ heroku keys:add
```

## Deployment

Follow the actions below to deploy a new version of the application to Heroku.

Precompile assets, and commit them to git:
```sh
$ rake assets:precompile
```

Push whatever code you'd like to deploy:
```sh
$ git push heroku <localbranch>:master
```

Run remote migrations:
```sh
$ heroku run rake db:migrate
```
