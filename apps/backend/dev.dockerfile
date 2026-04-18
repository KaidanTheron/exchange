FROM rust:1.95

WORKDIR /usr/src/backend
COPY . .

WORKDIR /usr/src/backend/crates/services/web-server
RUN cargo install --path .
RUN cargo install --locked watchexec-cli

CMD ["cargo", "watch", "-x", "run"]