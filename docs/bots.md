Because this is an entirely simulated system I'm going to use bots to keep it alive and at least semi-realistic.

Every few seconds the bots will:
1. Observe current fair price
2. Place bids below it
3. Place asks above it
4. Replace outdated orders with new ones

The bots will use the Rust API and have all the constraints and abilites that a real user in the system will have.

# The Fair Price

I will be using an external API to determine what the current fair price is for a given asset to keep the data at least somewhat organic.

# Bots' Goals

- Keep the synthetic spread relatively tight (within some hardcoded amount).
- Refresh orders that are unrealistic in terms of being filled if the market has moved.
- Randomize order sizes to keep order book random looking and realistic.

# TL;DR

Bots are going to use organic data to synthesize orders in the system that are hopefully somewhat realistic and act as users in the system. So, instead of the bots placing real orders, using real data, they will place simulated orders using real data.