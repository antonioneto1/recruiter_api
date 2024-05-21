ARG ARG_RUBY_VERSION
FROM --platform=linux/amd64 ruby:${ARG_RUBY_VERSION}-slim-buster

SHELL ["/bin/sh", "-c"]

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y \
    locales-all \
    bash-completion \
    dh-autoreconf \
    cmake \
    git \
    curl \
    wget \
    zip \
    vim \
    libpq-dev && \
  apt-get autoremove --purge -y && \
  apt-get autoclean -y

ARG ARG_LINUX_LOCALE
ENV LC_ALL=$ARG_LINUX_LOCALE LANG=$ARG_LINUX_LOCALE LANGUAGE=$ARG_LINUX_LOCALE

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    apt-get autoremove --purge -y && \
    apt-get autoclean -y

ARG ARG_USER_UID=1000
ARG ARG_USER_GID=1000

RUN addgroup --gid $ARG_USER_GID user && \
    adduser --disabled-password --gecos '' --uid $ARG_USER_UID --gid $ARG_USER_GID user && \
    chown user:user -R /usr/local

USER user
WORKDIR /home/user

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

WORKDIR /home/user/recruiter_api
COPY . .

RUN bundle exec rails webpacker:install

CMD ["bash"]
