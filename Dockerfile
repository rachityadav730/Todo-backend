FROM ruby:2.7.6

WORKDIR /app

RUN apt-get update -qq && apt-get install -y nodejs npm

RUN apt-get install -y nginx

COPY nginx.conf /etc/nginx/sites-available/default

COPY cert.crt /etc/nginx/ssl/cert.crt

COPY cert.key /etc/nginx/ssl/cert.key

RUN gem install bundler -v 2.4.22

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .


EXPOSE 80 443

CMD ["sh", "-c", "service nginx start && bundle exec puma -C config/puma.rb"]
