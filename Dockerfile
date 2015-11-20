FROM ubuntu

MAINTAINER Roberto Vasquez "roberto@vasquez-angel.de"

# Update package information and keys
RUN apt-key update
RUN apt-get update

# Add rvm depedencies
RUN apt-get install -y curl patch gawk g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev

# Install git
RUN apt-get install -y git

# Add user: docker
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Use user docker from now on
USER docker

# Install rvm
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3

RUN /bin/bash -l -c "curl -L get.rvm.io | bash -s stable --rails"

# Install rubies

# Install javascript runtime
RUN sudo apt-get install -y nodejs

# Install 1.7.16.1 dependencies
RUN sudo apt-get install -y --force-yes libcups2 libflac8 fontconfig-config libfreetype6 libfontconfig1 libnspr4 libnss3-nssdb libnss3 libpulse0 tzdata-java openjdk-7-jre-headless

RUN /bin/bash -l -c "rvm install 1.7.16.1"
RUN /bin/bash -l -c "echo 'gem: --no-ri --no-rdoc' > ~/.gemrc"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

RUN /bin/bash -l -c "rvm install 9.0.3.0"
RUN /bin/bash -l -c "echo 'gem: --no-ri --no-rdoc' > ~/.gemrc"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

RUN /bin/bash -l -c "rvm install 2.2.0"
RUN /bin/bash -l -c "echo 'gem: --no-ri --no-rdoc' > ~/.gemrc"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

# Use ruby-2.2.0 as default
RUN /bin/bash -l -c "rvm use 2.2.0 --default"