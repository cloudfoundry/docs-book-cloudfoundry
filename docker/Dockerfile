FROM ruby:2.6.9-alpine3.15

ARG DOCS_BOOK_CLOUDFOUNDRY_REPO=https://github.com/cloudfoundry/docs-book-cloudfoundry.git
ARG DOCS_BOOK_CLOUDFOUNDRY_WORKDIR=/tmp/docs-book-cloudfoundry
ARG NODEJS_VERSION=v16.9.1

WORKDIR $DOCS_BOOK_CLOUDFOUNDRY_WORKDIR
COPY files/Gemfile /tmp/Gemfile

RUN cd /opt/ && wget https://nodejs.org/dist/$NODEJS_VERSION/node-$NODEJS_VERSION-linux-x64.tar.xz && \
    tar -xf /opt/node-$NODEJS_VERSION-linux-x64.tar.xz && ln -s /opt/node-$NODEJS_VERSION-linux-x64/bin/* /usr/bin/ && \
    apk add build-base git make g++ && cd /tmp && git clone $DOCS_BOOK_CLOUDFOUNDRY_REPO && \
    cd $DOCS_BOOK_CLOUDFOUNDRY_WORKDIR && rm $DOCS_BOOK_CLOUDFOUNDRY_WORKDIR/Gemfile && \
    mv /tmp/Gemfile $DOCS_BOOK_CLOUDFOUNDRY_WORKDIR/Gemfile && bundle install && \
    rm -rf /opt/node-$NODEJS_VERSION-linux-x64.tar.xz

EXPOSE 4567

CMD ["bundle","exec","bookbinder","watch"]