# README

## Preparing the machine

1. Install [homebrew](http://brew.sh/)
1. Install [postgres](https://www.moncefbelyamani.com/how-to-install-postgresql-on-a-mac-with-homebrew-and-lunchy/)
1. Install [rvm](https://rvm.io/rvm/install)
1. Install npm

`$ brew install npm`

1. Install yarn

`$ npm install -g yarn`

## Getting the app to run locally

1. Clone the repository

`$ git clone git@bitbucket.org:firsttouch/first-touch.git`

1. Install ruby version for the project

```
$ cd first-touch
$ rvm install <ruby version pointed in the .ruby-version file>
```

1. Load newly installed version (RVM takes care of that)

```
$ cd ..
$ cd first-touch
```

2. Install server side dependencies

```
$ gem install bundler
$ bundle install
```

3. Install client side dependencies

```
$ cd client
$ yarn install
```

4. Setup the database
    1. Create config/database.yml file with the contents
    ```
    default: &default
      adapter: postgresql
      encoding: unicode
      pool: 5
      timeout: 5000
      host: localhost
      port: 5432
      password: <%= ENV['POSTGRES_PASSWORD'] %>

    development:
      <<: *default
      database: firsttouch_devel_1 #CHANGE ME

    test:
      <<: *default
      database: firsttouch_test #CHANGE ME
    ```
    2. Initialize db and migrate
    `$ rake db:setup`

5. Run the local server
`$ rails server`

6. Run browsersync to serve the client side assets
```
$ cd client
$ yarn serve
```

7. Open the browser in `localhost:3001`