FROM ruby:2.7.6

WORKDIR /app

RUN apt-get update -qq && apt-get install -y nodejs npm

RUN gem install bundler -v 2.4.22

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
