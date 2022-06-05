FROM phusion/passenger-customizable:latest

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# build systems and git
RUN /pd_build/utilities.sh && \
    /pd_build/python.sh

# Install pip
RUN curl -fSL 'https://bootstrap.pypa.io/get-pip.py' | python

# Install requirements
RUN apt-get -y install libpq-dev python-dev
RUN pip install --upgrade pip
RUN pip install virtualenv
RUN  curl -L "https://github.com/docker/compose/releases/download/1.8.1/docker-compose-$(uname -s)-$(uname -m)" > /usr/local/bin/docker-compose && \
     chmod +x /usr/local/bin/docker-compose

RUN  curl -L "https://get.docker.com/builds/Linux/$(uname -m)/docker-latest.tgz" > docker-latest.tgz && \
     tar -xvzf docker-latest.tgz && \
     mv docker/* /usr/bin/

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
