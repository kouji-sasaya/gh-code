FROM mcr.microsoft.com/devcontainers/base:bookworm

# Install sshd 
RUN apt-get update && apt-get install -y \
   openssh-server \
   tmux \
   neovim \
   && apt-get -y autoremove \
   && rm -rf /var/lib/apt/lists/*
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

USER vscode
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

