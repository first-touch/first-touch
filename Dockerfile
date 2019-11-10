FROM ruby:2.6.3-stretch

ENV APP_HOME /app
# Change to the application's directory
WORKDIR $APP_HOME

EXPOSE 3000

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y postgresql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*

ADD Gemfile* $APP_HOME/

RUN gem install bundler:2.0.1

RUN bundle install --deployment --without development test

# Copy application code
COPY . /app

ENV RAILS_ENV production

CMD ["rails", "server", "-b", "0.0.0.0"]
