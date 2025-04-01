# Build stage
FROM rust:latest AS build
WORKDIR /app

RUN git clone --depth=1 https://github.com/ristomatti/aichat.git . && \
    cargo build --locked --release

# Runtime stage
FROM debian:12-slim
COPY --from=build /app/target/release/aichat /usr/local/bin/aichat

ENV XDG_CONFIG_HOME=/data/config
VOLUME /data/config

RUN adduser --disabled-login --no-create-home aichat
USER aichat

EXPOSE 8000

CMD ["/usr/local/bin/aichat"]
