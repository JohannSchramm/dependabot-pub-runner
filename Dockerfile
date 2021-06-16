FROM ubuntu:18.04

### SYSTEM DEPENDENCIES

ENV DEBIAN_FRONTEND="noninteractive" \
  LC_ALL="en_US.UTF-8" \
  LANG="en_US.UTF-8"

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
    build-essential \
    dirmngr \
    git \
    bzr \
    mercurial \
    gnupg2 \
    curl \
    wget \
    file \
    zlib1g-dev \
    liblzma-dev \
    tzdata \
    zip \
    unzip \
    locales \
    openssh-client \
  && locale-gen en_US.UTF-8


### RUBY

# Install Ruby 2.6.6, update RubyGems, and install Bundler
ENV BUNDLE_SILENCE_ROOT_WARNING=1
RUN apt-get install -y software-properties-common \
  && apt-add-repository ppa:brightbox/ruby-ng \
  && apt-get update \
  && apt-get install -y ruby2.6 ruby2.6-dev \
  && gem update --system 3.0.3 \
  && gem install bundler -v 1.17.3 --no-document


### DART

# Install Flutter SDK
RUN git clone --branch stable https://github.com/flutter/flutter.git /opt/flutter/stable
ENV PATH="$PATH:/opt/flutter/stable/bin"
RUN flutter precache


### DEPENDABOT PUB

# Clone Dependabot Pub

RUN git clone --branch wip/pub https://github.com/JohannSchramm/dependabot-core /home/app/dependabot-core

# Setup Update Script

COPY update-pub.rb /home/app/dependabot-pub-runner/update-pub.rb
COPY Gemfile /home/app/dependabot-pub-runner/Gemfile
WORKDIR /home/app/dependabot-pub-runner
RUN bundle install --path vendor

# Action Entrypoint

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
