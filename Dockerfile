FROM codercom/code-server:4.19.1-ubuntu
USER root
ARG DEBIAN_FRONTEND=noninteractive
ENV PATH=/root/go/bin:/usr/local/go/bin:$PATH
COPY .bashrc /root/.bashrc
COPY --from=composer:2.6.5 /usr/bin/composer /usr/bin/composer

RUN set -x \
&& type -p curl >/dev/null || (apt update && apt install curl -y) \
&& curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& apt update \
&& apt install -y \
    iproute2 \
    gh \
    gcc \
    make \
    gpg software-properties-common \
&& add-apt-repository ppa:ondrej/php \
&& apt update \
&& apt install -y \
    php8.3-cli php8.3-mysql php8.3-curl \
&& rm -rf /var/lib/apt/lists/* \
&& php -v

WORKDIR /var/www
