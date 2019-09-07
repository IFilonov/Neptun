FROM ruby:2.6.0

RUN apt-get update && apt-get install -y curl libpq-dev redis-server postgresql nodejs libffi-dev sudo

WORKDIR /tmp
ADD Gemfile* ./

ENV APP_HOME /neptun
COPY . $APP_HOME
WORKDIR $APP_HOME

RUN gem install bundler -v 1.17.3

#RUN apt-get install -y openssl libc-dev libxml2-dev libxslt-dev

RUN bundle install

ENV RAILS_ENV=production \
    RACK_ENV=production

EXPOSE 3000

CMD ["bash"]
