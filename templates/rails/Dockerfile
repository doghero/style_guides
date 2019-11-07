FROM ruby:2.6.3-stretch

# Include variables
ARG USER
ARG UID
ARG APP_NAME

# Test variables
RUN test -n "$USER"
RUN test -n "$UID"
RUN test -n "$APP_NAME"

# Create user from host
RUN adduser --quiet --gecos "$USER" --uid "$UID" --disabled-login "$USER"
# Install Rails
RUN gem install rails
# Install gem to organize Gemfile
RUN gem install eefgilm

# Define workdir to create project
WORKDIR /rails
RUN chown "$USER":"$USER" /rails

# USER "$USER"
# RUN echo "`ruby -e 'puts Gem.user_dir'`/bin:$PATH"
# ENV PATH="`ruby -e 'puts Gem.user_dir'`/bin:$PATH"

COPY templates .

# RUN rails new \
#   --database postgresql \
#   --api \
#   -m template.rb \
#   "$APP_NAME"

# RUN gem install bundler:2.0.2
# RUN bundle install
