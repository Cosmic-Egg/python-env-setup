FROM debian:11

RUN apt-get update && \
    apt-get install -y \
        ca-certificates \
        curl \
        git \
        unzip \
        tar \
        zsh \
        sudo && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/zsh vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/vscode && \
    chmod 440 /etc/sudoers.d/vscode

USER vscode
WORKDIR /home/vscode

CMD ["/bin/zsh"]
