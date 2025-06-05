FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV USER=docker

RUN dpkg --add-architecture i386 && \
    apt update && apt install -y \
    curl \
    git \
    sudo \
    unzip \
    wine32 \
    x11vnc \
    xterm \
    xvfb \
    && apt clean

RUN useradd -m docker && echo "docker:docker" | chpasswd && \
    echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    adduser docker sudo

USER docker
WORKDIR /home/docker

RUN git clone https://github.com/novnc/noVNC.git && \
    git clone https://github.com/novnc/websockify noVNC/utils/websockify && \
    ln -s /home/docker/noVNC/vnc.html /home/docker/noVNC/index.html

COPY --chmod=755 ./start.sh /home/docker/

EXPOSE 6080

CMD ["/home/docker/start.sh"]
