FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN apt-get update  \
    && apt-get -y --no-install-recommends install  \
    sudo curl git ca-certificates build-essential \
    && rm -rf /var/lib/apt/lists/*

# miseディレクトリ作成 & 権限設定
RUN mkdir -p /mise /mise/cache /mise/installs /mise/bin && chown -R vscode:vscode /mise

# ユーザ切り替え
USER vscode

# install mise
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV MISE_DATA_DIR="/mise"
ENV MISE_CONFIG_DIR="/mise"
ENV MISE_CACHE_DIR="/mise/cache"
ENV MISE_INSTALL_PATH="/mise/bin/mise"
ENV PATH="/mise/bin:/mise/shims:$PATH"
RUN curl https://mise.run | sh
RUN echo 'eval "$(mise activate bash)"' >> ~/.bashrc

# install GEMINI CLI
RUN mise use -g node@24
RUN mise use -g npm:@google/gemini-cli

# remove caches
RUN mise cache clean

# Gemini CLIのキーバインド設定ファイルをコピー
COPY --chown=vscode ./container_files/keybindings.json /home/vscode/.gemini/keybindings.json