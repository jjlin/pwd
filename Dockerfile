FROM ubuntu:latest

ENV USER root
ENV HOME /root

ARG PKGS="\
    apt-transport-https \
    atool \
    bash-completion \
    ca-certificates \
    curl \
    emacs \
    less \
    maven \
    openjdk-8-jdk-headless \
    openssh-client \
    openssh-server \
    python \
    software-properties-common \
    tmux \
    unzip \
    vim \
"

ARG PKGS_EXTERNAL="\
    docker-engine \
    git \
"

RUN apt-get update \
 && apt-get -y install ${PKGS} \
 && add-apt-repository -y ppa:git-core/ppa \
 && curl -fsSL https://apt.dockerproject.org/gpg | apt-key add - \
 && add-apt-repository \
    "deb https://apt.dockerproject.org/repo/ ubuntu-$(lsb_release -cs) main" \
 && apt-get update \
 && apt-get -y install ${PKGS_EXTERNAL} \
 && apt-get clean \
 && rm -f /etc/ssh/ssh_host_* \
 && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
 && cd /tmp \
 && curl -LO https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip \
 && unzip ngrok-stable-linux-amd64.zip \
 && rm ngrok-stable-linux-amd64.zip \
 && chmod 755 ngrok \
 && mv ngrok /usr/bin

COPY rootfs /

WORKDIR ${HOME}
CMD ["/usr/local/bin/start.sh"]
