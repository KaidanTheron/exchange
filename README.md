A price-time priority matching engine in Rust, with real-time WebSocket streaming and a React trading interface.
(or... it will be, soon)

There are some tradeoffs with my approach for this project to keep it free. I will have to keep the redis and postgres usage low so that I can stay in the free tiers.
This means, unfortunately, that this won't be the most performant, blazingly fast system you have ever seen.

### Development Requirements

The following tools need to be installed to work on this project:
- docker (28.4.0)
- rustup toolchain (1.28.2)
- node (22.20.0)
** I have also marked what version I am using locally for each tool **

The backend (redis + postgres + rust web server) has been setup to run with docker compose, using cargo watch to restart the server when file changes occur.

### Goals (TODO)

- setup CICD (Github actions) to perform checks, deploy rust backend to fly.io (maybe something else, not sure yet), and deploy vite app to vercel.
- auth
- performance benchmarks
- matching engine for orders
- websocket for real time updates
- migrations
- verbose error logging
- trading bot (would be cool down the line)
- order book and depth chart