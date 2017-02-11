# README

## Preparing the machine

1. Install [homebrew](http://brew.sh/)
1. Install [postgres](https://www.moncefbelyamani.com/how-to-install-postgresql-on-a-mac-with-homebrew-and-lunchy/)
1. Install [rvm](https://rvm.io/rvm/install)
1. Install npm

`brew install npm`

1. Install yarn

`npm install -g yarn`

## Getting the app to run locally

1. Clone the repository

`git clone git@github.com:rpbaltazar/first-touch.git`

2. Install server side dependencies

`bundle install`

3. Install client side dependencies

`yarn install`

4. Setup the database

`rake db:setup`

5. Run the local server

`rails server`

6. Run browsersync to serve the client side assets

`npm run serve`

7. Open the browser in

`localhost:3001`