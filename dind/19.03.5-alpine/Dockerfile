FROM docker:19.03.5-dind

ENV PS1='\[\033[1;36m\][\u@\h] \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'

RUN set -x; \
    apk add --update --no-cache \
        docker-compose \
        make \
        bash
