FROM ubuntu-debootstrap:14.04


COPY ./cedar-14.sh /tmp/build.sh

RUN apt-get update && apt-get install -y --force-yes \
    autoconf \
    bind9-host \
    bison \
    build-essential \
    coreutils \
    curl \
    daemontools \
    dnsutils \
    ed \
    git \
    imagemagick \
    iputils-tracepath \
    language-pack-en \
    libbz2-dev \
    libcurl4-openssl-dev \
    libevent-dev \
    libev-dev \
    libglib2.0-dev \
    libjpeg-dev \
    libmagickwand-dev \
    libmysqlclient-dev \
    libncurses5-dev \
    libpq-dev \
    libpq5 \
    librdkafka-dev \
    libreadline6-dev \
    libssl-dev \
    libxml2-dev \
    libxslt-dev \
    libuv-dev \
    netcat-openbsd \
    openjdk-7-jdk \
    openjdk-7-jre-headless \
    openssh-client \
    openssh-server \
    python \
    python-dev \
    ruby \
    ruby-dev \
    socat \
    stunnel \
    syslinux \
    tar \
    telnet \
    zip \
    zlib1g-dev && apt-get clean

RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /tmp/build.sh \
  && rm -rf /var/lib/apt/lists/*
  

RUN wget -q -O /bin/mc https://dl.minio.io/client/mc/release/linux-amd64/mc && chmod +x /bin/mc
RUN curl https://github.com/gliderlabs/herokuish/releases/download/v0.3.23/herokuish_0.3.23_linux_x86_64.tgz \
		--silent -L | tar -xzC /bin
RUN ln -s /bin/herokuish /build \
	&& ln -s /bin/herokuish /start \
	&& ln -s /bin/herokuish /exec
COPY default_user.bash /tmp/default_user.bash
RUN bash /tmp/default_user.bash && rm -f /tmp/default_user.bash
run mkdir /app && chown -R herokuishuser /app
USER herokuishuser

COPY ./run.sh /run.sh