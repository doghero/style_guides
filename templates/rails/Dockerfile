FROM ruby:2.7.1-buster

# Include variables
ARG APP_NAME

RUN test -n "$APP_NAME"

# Install Rails
RUN gem install rails
# Install gem to organize Gemfile
RUN gem install eefgilm

# Define workdir to create project
WORKDIR /rails
RUN chown "$USER":"$USER" /rails

COPY templates .
