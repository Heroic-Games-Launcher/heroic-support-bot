# ==============================
# Build stage
# ==============================
FROM elixir:1.19.5-otp-28 AS build

ENV MIX_ENV=prod
WORKDIR /app

# Install build tools
RUN apt-get update && apt-get install -y \
  build-essential \
  git \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Install Hex & Rebar (safe even if already installed)
RUN mix local.hex --force && \
    mix local.rebar --force

# Cache deps
COPY mix.exs mix.lock ./
RUN mix deps.get --only prod
RUN mix deps.compile

# Copy source
COPY config config
COPY lib lib

# Compile and build release
RUN mix compile
RUN mix release

# ==============================
# Runtime stage
# ==============================
FROM debian:trixie-slim AS app

# Install runtime deps
RUN apt-get update && apt-get install -y \
  openssl \
  libncurses6 \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy release from build stage
COPY --from=build /app/_build/prod/rel/* ./

# Fly & Elixir conventions
ENV MIX_ENV=prod
ENV LANG=C.UTF-8

# Default command
CMD ["bin/heroic_support", "start"]