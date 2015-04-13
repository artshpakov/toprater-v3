FROM phusion/passenger-ruby21

MAINTAINER Melifaro <mi@melifaro.net>

CMD ["/sbin/my_init"]
RUN apt-get update && apt-get install -y qt4-dev-tools libqt4-dev libqt4-core

# enable puma
RUN mkdir /etc/service/puma
ADD puma_start.sh /etc/service/puma/run

# redirect puma environment log to stdout
RUN mkdir /etc/service/puma_log
ADD redirect_log.sh /etc/service/puma_log/run

# Install gems in a cache efficient was
WORKDIR /tmp
ADD Gemfile /tmp/Gemfile
ADD Gemfile.lock /tmp/Gemfile.lock
RUN bundle install --without development test

# Add the app
WORKDIR /toprater
ADD . /toprater

# Clean up
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
