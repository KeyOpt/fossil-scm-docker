# Alpine >3.13 breaks stuff on many host OSes! For details see:
# https://wiki.alpinelinux.org/wiki/Draft_Release_Notes_for_Alpine_3.14.0#faccessat2
# FROM    alpine:edge
FROM    alpine:3.13
ARG	VERSION=latest
RUN     apk update                                                                                      \
        && apk upgrade                                                                                  \
        && apk add --no-cache --virtual .build-deps                                                     \
        curl gcc make tcl                                                                               \
        musl-dev                                                                                        \
        openssl-dev zlib-dev                                                                            \
        openssl-libs-static zlib-static                                                                 
        && if [ "$VERSION" = "latest" ] ; then                                                             \
        curl                                                                                            \ 
        "https://fossil-scm.org/home/tarball/fossil-src.tar.gz?name=fossil-src&uuid=trunk"              \
        -o fossil-src.tar.gz                                                                            \
        && tar xfvz fossil-src.tar.gz ;                                                                 \
        else                                                                                            \
        curl                                                                                            \
        "https://fossil-scm.org/home/uv/fossil-src-${VERSION}.tar.gz"                                   \
        -o fossil-src.tar.gz                                                                            \
        && tar xfvz fossil-src.tar.gz                                                                   \
        && mv fossil-${VERSION} fossil-src ;                                                            \
        fi                                                                                              \
        && cd fossil-src                                                                                \
        && ./configure                                                                                  \
        --static                                                                                        \
        --disable-fusefs                                                                                \
        --with-th1-docs                                                                                 \
        --with-th1-hooks                                                                                \
        --json                                                                                          \
        && make                                                                                         \
        && strip fossil                                                                                 \
        && make install                                                                                 \
        && apk del --no-cache .build-deps                                                               \
        && rm -f /var/cache/apk/*                                                                       \
        && cd / && rm -rf fossil-src*

ENV FOSSIL_PORT=8080
ENV FOSSIL_REPO_LOC=/opt/fossil/

EXPOSE ${FOSSIL_PORT}

ENTRYPOINT fossil server --port ${FOSSIL_PORT} --repolist ${FOSSIL_REPO_LOC}
        
