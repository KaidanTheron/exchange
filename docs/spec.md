This document outlines the business logic of this project and the systems that are required to fulfill that business logic.

# Business Logic

## Users / Accounts

- A user must exist to place orders
- A user has balances
- A user can open, modify or close their position (balances) using orders
- A user can only manage & see their own orders / balances

## Balances

Every user has reserved and available balances. 
A user has a reserved and available balance for each asset they own.

Invariants:
```
available >= 0
reservered >= 0
total = available + reserved
```

Creating an order:
- increases reserved amount
- decreases available amount

Cancelling an order:
- increases available amount
- decreases reserved amount

Filling or partially filling an order:
- decreases reserved in asset being sold
- increases available in asset being bought

## Orders

- Order can only be placed if total ZAR / BTC <= account ZAR / BTC
- When a buy order is placed, ZAR from their account is reserved immediately.
- When a sell order is placed, BTC from their account is reserved immediately
- Limit orders can be placed
- Market ordes can be placed
- Orders affect the order book
- Orders are modified in the order book via the matching engine

## Order matching

- Orders are matched via Matching Engine which uses FIFO rule; best prices first, oldest first at same price
- Trades execute at resting order price
- Remaining quantity rests in book for limit orders
- Remaining quantity is cancelled for market orders
- Orders can not match if they have the same owner -> self-trading not allowed

# Encyclopedia

## The Order Book

The order book displays the real-time buy and sell orders (bids and asks) for a given trading pair. In the case of this project, only for BTC/ZAR.

## Limit and Market Orders

Limit orders are orders that are placed that will only match when a specific buy or sell price is reached.
Market orders are orders that are executed immediately against the best price selling price (if buying) or the best buying price (if selling).

Maket orders are filled until their quantity is reached or liquidity is exhausted.
Partial filling of limit orders are allowed, if there is a remaining quantity it will remain 

## Makers, Takers

| Feature | Maker | Taker |
| :--- | :--- | :--- |
| Order Type | Limit Order | Market Order |
| Liquidity | Adds | Removes |
| Execution Time | Delayed (rests in the order book) | Immediate |
| Fee | Lower | Higher (increased transaction costs for immediate, market orders) |

## Matching Engine

The matching engine matches bids and buys using FIFO (most widely used so it's what I will be using). Oldest, best priced (lowest ask, highest bid) are matched first.

## Positions

The quantity of asset held, it is either open or closed. An open position means that you are holding a non-zero quantity. Closed means you are holding zero quantity of the asset.

Orders are used to open, close or modify your position.