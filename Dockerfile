FROM debian:stable-slim

RUN apt-get update && apt-get install -y git sudo && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ARG GIT_ONLY="false"
ENV GIT_ONLY=$GIT_ONLY

COPY . /tmp/dotfiles
RUN  useradd -m -s /bin/bash jake && \
     usermod -aG sudo jake && \
     echo "jake ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
     chmod 0440 /etc/sudoers && \
     mkdir -p /home/jake/dotfiles && \
     cp -r /tmp/dotfiles /home/jake/ && \
     chown -R jake:jake /home/jake && \
     rm -rf /tmp/dotfiles


WORKDIR /home/jake

USER jake
RUN bash -c 'if [ "$GIT_ONLY" = "true" ]; then cd ~/dotfiles && git clean -fd && git reset --hard HEAD; fi'
ENTRYPOINT ["/bin/bash", "-c", "/home/jake/dotfiles/dots install && zsh -l"]

