#golang 1.12 and alpine 3.9 should work fine also
FROM golang:1.11.4-alpine3.8

# add dev dependencies
RUN apk add --no-cache  \
      bash              \
      build-base        \
      coreutils         \
      gcc               \
      git               \
      make              \
      musl-dev          \
      openssl-dev       \
      rpm               \
      lz4-dev           \
      zlib-dev          \
      wget          &&  \

    # download libsasl to a temp location and build
    # enable/disable features as needed with configure

    cd $(mktemp -d) && \
    wget -nv -O cyrus-sasl-2.1.27.tar.gz https://github.com/cyrusimap/cyrus-sasl/releases/download/cyrus-sasl-2.1.27/cyrus-sasl-2.1.27.tar.gz && \
    tar -xz --strip-components=1 -f cyrus-sasl-2.1.27.tar.gz && \
    rm -f cyrus-sasl-2.1.27.tar.gz && \
    ./configure --prefix=/usr --disable-sample --disable-obsolete_cram_attr --disable-obsolete_digest_attr --enable-static --disable-shared \
        --disable-checkapop --disable-cram --disable-digest --enable-scram --disable-otp --disable-gssapi --with-dblib=none --with-pic && \
    make && \
    make install && \

    cd $(mktemp -d) && \
    wget -nv -O v1.0.1.tar.gz https://github.com/edenhill/librdkafka/archive/v1.0.1.tar.gz && \
    tar -xz --strip-components=1 -f v1.0.1.tar.gz && \
    rm -f v1.0.1.tar.gz && \
    ./configure --prefix=/usr --enable-sasl && \
    make -j && \
    make install