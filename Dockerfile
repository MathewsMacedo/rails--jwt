FROM ruby:2.7.1-alpine

LABEL maintainer="Matheus M<matheus.smacedo@hotmail.com>"

RUN apk --update --upgrade add \
      bash\
      sqlite-dev\
      build-base\
      nodejs\
      tzdata

ENV INSTALL_PATH /account-ms

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile* $INSTALL_PATH/

RUN bundle install

ADD . $INSTALL_PATH

RUN mkdir -p $INSTALL_PATH/tmp/pids

RUN chmod +x run.sh

CMD ["./run.sh"]