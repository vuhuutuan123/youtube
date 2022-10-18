FROM ruby:3.0.2

ENV LANG C.UTF-8

ARG APP_ROOT=/workspace

RUN apt-get update -qq && apt-get install -y build-essential nodejs

RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /etc/apt/trusted.gpg.d/dn.yarnpkg.com.gpg >/dev/null
RUN sh -c "echo deb https://dl.yarnpkg.com/debian stable main > /etc/apt/sources.list.d/yarn.list"
RUN wget https://dl.yarnpkg.com/debian/pubkey.gpg
RUN apt-key add pubkey.gpg
RUN apt-get -y update && apt-get install -y yarn nano vim

RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

ENV GEM_HOME /$APP_ROOT/vendor/bundle
ENV BUNDLE_PATH /$APP_ROOT/vendor/bundle
ENV BUNDLE_BIN /$APP_ROOT/vendor/bundle/bin
ENV PATH $BUNDLE_BIN:$BUNDLE_PATH/gems/bin:$PATH

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 3000
