FROM ruby:2.5

# RUN apt-get install curl
# RUN curl -sL https://deb.nodesource.com/setup | bash - && \
#  apt-get install -y nodejs
# fix npm - not the latest version installed by apt-get
# RUN npm install -g npm
# install webpack
# RUN npm install -g webpack-cli

ENV GEM_HOME /home/gems/mygem
RUN mkdir -p $GEM_HOME
# https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR $GEM_HOME
COPY . $GEM_HOME
RUN bundle install
# RUN cd spec/test_app && rake db:migrate && rake db:migrate RAILS_ENV=test
