# Dockerfile
FROM amd64/ruby:3.0.0

RUN apt-get update -yqq
RUN apt-get install -yqq --no-install-recommends nodejs

# Default directory
COPY . /usr/src/app

ARG SECRET_KEY_BASE=static_secret_key

WORKDIR /usr/src/app

ENV RAILS_ENV=production
ENV SECRET_KEY_BASE=${SECRET_KEY_BASE}
RUN gem install bundler:2.2.3
RUN bundle install
RUN rake db:migrate
RUN rails assets:precompile
CMD [ "rails", "server"]