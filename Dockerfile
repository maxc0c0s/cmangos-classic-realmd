FROM maxc0c0s/cmangos-classic-base

RUN git clone https://github.com/vishnubob/wait-for-it.git

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
