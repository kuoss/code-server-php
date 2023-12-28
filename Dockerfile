FROM codercom/code-server:4.20.0-ubuntu
USER root
ARG DEBIAN_FRONTEND=noninteractive
ENV PATH=/root/go/bin:/usr/local/go/bin:$PATH
COPY .bashrc /root/.bashrc
COPY --from=composer:2.6.6 /usr/bin/composer /usr/bin/composer

RUN set -x \
&& type -p curl >/dev/null || (apt update && apt install curl -y) \
&& apt update \
&& apt install -y \
jq             \
iproute2       \
redis-tools    \
inotify-tools  \
mariadb-client \
openssh-client \
gcc gpg make software-properties-common \
&& curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& apt update \
&& apt install -y \
    gh \
&& add-apt-repository ppa:ondrej/php \
&& apt update && apt install -y \
    php8.3-cli   \
    php8.3-curl  \
    php8.3-mysql \
&& rm -rf /var/lib/apt/lists/* \
&& php -v \
&& (curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash) \
&& export NVM_DIR="$HOME/.nvm" \
&& [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
&& [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" \
&& nvm install --lts \
&& node -v \
&& npm -v

WORKDIR /var/www
