FROM ubuntu:latest

ENV USER root
ENV HOME /root

ARG PKGS="\
    atool \
    bash-completion \
    curl \
    emacs \
    less \
    maven \
    openssh-client \
    openssh-server \
    python \
    software-properties-common \
    tmux \
    unzip \
    vim \
"

ARG PKGS_PPA="\
    git \
"

RUN apt-get update \
 && apt-get -y install ${PKGS} \
 && add-apt-repository -y ppa:git-core/ppa \
 && apt-get update \
 && apt-get -y install ${PKGS_PPA} \
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
