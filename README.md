# README

## Preparing the machine

1. Install [homebrew](http://brew.sh/)
1. Install [postgres](https://www.moncefbelyamani.com/how-to-install-postgresql-on-a-mac-with-homebrew-and-lunchy/)
1. Install [rbenv](https://github.com/rbenv/rbenv)
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
$ rbenv install <ruby version pointed in the .ruby-version file>
$ rbenv rehash
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
    2. Change directory to previous folder
    ```
    cd ..
    ```
    3. Initialize db and migrate `$ rake db:setup`

5. Create a config/secrets.yml file

```
development:
    secret_key_base: 2addf1a866d1632d75b6fa832463eb3abb74d54951bf59be011c410ca420e15a267bb890d50c773f991161a25a8bd6c10fcce5fb5f6e7ab82dc1e22a41d6364c

    FT_AWS_ACCESS_KEY: AKIAJYS3DZ7XTTFUBN2D
    FT_AWS_SECRET_KEY: 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
    FT_AWS_REGION: us-west-1
    FT_AWS_S3_BUCKET_NAME: first-touch-web
    stripe:
      secret_key: sk_test_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      publishable_key: pk_test_XXXXXXXXXXXXXXXXXXXXXXXXXXX

  test:
    secret_key_base: e2f7a35543171706eb3e019da3b15f00d21cc291326dc8049b4cf6629be8ffe46e2103cead1eea2f4e6f58e707c33e4e7a86300af36b6a76db641efb7640030f

    FT_AWS_ACCESS_KEY: AKIAJYS3DZ7XTTFUBN2D
    FT_AWS_SECRET_KEY: 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
    FT_AWS_REGION: us-west-1
    FT_AWS_S3_BUCKET_NAME: first-touch-web
    stripe:
      secret_key: sk_test_XXXXXXXXXXXXXXXXXXXX
      publishable_key: pk_test_XXXXXXXXXXXXXXXXXX
```

5. Run the local server
`$ rails server`

6. Setup Stripe public key
	Create a client/src/app/constants/StripeConstant.js file

	export const StripePublicKey = 'pk_test_XXXXXXXXXXXXXXXXXXXXXX';

6. Run browsersync to serve the client side assets
```
$ cd client
$ yarn serve
```

7. Open the browser in `localhost:3001`

8. We rely on mailcatcher to trap emails on dev enviroment. Make sure you install it and start the deamon

```
$ gem install mailcatcher
$ mailcatcher
```

The service should be available in http://localhost:1080/

9. We rely on imagemagick for image handling (mini_magick gem requires it), so make sure you have it
installed in your computer as well.

### In OSx:
```
$ brew install imagemagick
```

### In Ubuntu
```
$ wget https://www.imagemagick.org/download/ImageMagick.tar.gz
$ tar -xvf ImageMagick.tar.gz
$ cd ImageMagick-7.*
$ ./configure
$ make
$ sudo make install
$ sudo ldconfig /usr/local/lib
```
