# Stage 1: Build
FROM node:20-slim AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

FROM base AS build
COPY . /app
WORKDIR /app

# Install dependencies and build
RUN corepack prepare pnpm@latest --activate
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile
RUN pnpm run build

# Stage 2: Production (Runner)
FROM base AS runner
WORKDIR /app

# Copy production dependencies only
COPY --from=build /app/node_modules /app/node_modules
# Copy built assets (adjust 'build' folder if changed in config)
COPY --from=build /app/build /app/build
COPY --from=build /app/package.json /app/package.json

EXPOSE 3000

# React Router 7 default serve command
CMD ["pnpm", "react-router-serve", "./build/server/index.js"]
