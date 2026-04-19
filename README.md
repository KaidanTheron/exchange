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

### Rust Backend User Stories
- 1 — Platform Availability
    - 1.1 — Health Check

    As the React application
    I want to know whether the backend is online
    So that I can show the user if trading services are available.

    Acceptance Criteria

    GET /health
    returns 200 OK
    returns status payload

- 2 - Market Data Display
    - 2.1 View Current Order Book

    As a trader using the React app
    I want to load the current order book
    So that I can see bids and asks before placing an order.

    Acceptance Criteria

    GET /book
    returns:
        - bids
        - asks
        - sorted correctly
    - 2.2 — View Best Bid / Ask

    As a trader
    I want to know the best available prices
    So that I can make quick trading decisions.

    Acceptance Criteria

    Backend returns enough data for frontend to calculate or receive:

    best bid
    best ask
    spread
    - 2.3 — Receive Live Book Updates

    As a trader
    I want the order book to update in real time
    So that I don’t need to refresh manually.

    Acceptance Criteria

    WebSocket stream
    emits book updates after changes
- 3 — Trading Actions
    - 3.1 — Place Limit Buy Order

    As a trader
    I want to place a buy order at a chosen price
    So that I only buy if market reaches my price.

    Acceptance Criteria

    POST /orders
    accepts:
    side = buy
    type = limit
    price
    quantity

    Returns:

    accepted
    matched
    partially filled
    rejected
    - 3.2 — Place Limit Sell Order

    As a trader
    I want to place a sell order at a chosen price
    So that I only sell if market reaches my price.

    Same criteria.

    - 3.3 — Place Market Order

    As a trader
    I want to buy or sell immediately
    So that I can execute at best available prices.

    Acceptance Criteria
    POST /orders
    type = market
    backend fills against available liquidity
    - 3.4 — Validate Bad Orders

    As a trader
    I want invalid orders rejected clearly
    So that I know how to fix them.

    Examples

    Reject:

    zero quantity
    negative price
    missing fields
    invalid type
- 4 — Trade Results
    - 4.1 — Receive Order Result Immediately

    As a trader
    I want to know if my order executed
    So that I understand what happened.

    Acceptance Criteria

    Response includes:

    accepted
    filled qty
    remaining qty
    trade executions
    - 4.2 — View Recent Trades

    As a trader
    I want to see latest market trades
    So that I understand momentum.

    Acceptance Criteria
    GET /trades or WebSocket stream
    returns recent trades list
    - 4.3 — Receive Live Trade Feed

    As a trader
    I want trades to appear instantly
    So that the UI feels like a real exchange.

    Acceptance Criteria

    WebSocket emits trade events.

- 5 — Order Lifecycle
    - User Story 5.1 — Cancel Open Order

    As a trader
    I want to cancel an unfilled order
    So that I can change my mind.

    Acceptance Criteria
    DELETE /orders/:id
    - 5.2 — View Open Orders

    As a trader
    I want to see my active orders
    So that I know what is resting on the book.

    Acceptance Criteria
    GET /my/orders

- 6 — Reliability / UX
    - 6.1 — Recover After Reconnect

    As a trader
    If my websocket disconnects
    I want the app to resync current market state.

    Acceptance Criteria

    Frontend reconnects then calls:

    GET /book
    - 6.2 — Fast Responses

    As a trader
    I want orders processed quickly
    So that trading feels responsive.

    Acceptance Criteria
    low latency
    no blocking UI
- 7 — Admin / Engineering Stories (Great ROI)
    - 7.1 — Metrics

    As an engineer
    I want processing metrics
    So I can monitor performance.

    Expose:

    orders/sec
    avg latency
    connected WS clients
    User Story 7.2 — Structured Logs

    As an engineer
    I want logs for every order and trade
    So I can debug issues.