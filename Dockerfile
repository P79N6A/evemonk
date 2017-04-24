FROM centos:7

MAINTAINER Igor Zubkov <igor.zubkov@gmail.com>

RUN yum upgrade -y -q

RUN yum install git gcc make bzip2 libyaml-devel openssl-devel readline-devel zlib-devel postgresql-devel -y -q

RUN echo 'gem: --no-rdoc --no-ri' > /root/.gemrc

RUN git clone https://github.com/rbenv/rbenv.git /root/.rbenv

RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build

ENV PATH /root/.rbenv/bin:/root/.rbenv/shims:$PATH

RUN cd /root/.rbenv && src/configure && make -C src

RUN rbenv install 2.4.1

RUN rbenv global 2.4.1

RUN echo 'eval "$(rbenv init -)"' >> /root/.bash_profile

RUN gem update --system

ENV BUNDLER_VERSION 1.15.0.pre.2

RUN gem install bundler --version "$BUNDLER_VERSION"

RUN mkdir -p /srv/evemonk

RUN git clone https://github.com/biow0lf/evemonk.git /srv/evemonk

RUN yum install sqlite-devel -y -q

WORKDIR /srv/evemonk

ENV RAILS_ENV production

RUN bundle install --quiet --without development test

RUN yum install epel-release -y

RUN yum install nodejs npm --enablerepo=epel -y

RUN rbenv rehash

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

