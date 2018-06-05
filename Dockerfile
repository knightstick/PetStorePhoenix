# Use alpine elixir base image, with the name builder
FROM bitwalker/alpine-elixir:1.5.2 as builder

ENV HOME=/opt/app/ TERM=xterm
# This is for building production releases
ENV MIX_ENV=prod

# Cache elixir deps
RUN mkdir config
COPY config/* config/
COPY mix.exs mix.lock ./

RUN mix do deps.get, deps.compile

# Copy across our code
COPY . .

# Use distillery to make a release executable
RUN MIX_ENV=prod mix release --verbose

# Now, create a second image, from alpine edge
FROM alpine:edge

# Install bash and openssl (both needed to run iex console)
RUN apk --no-cache add bash openssl && rm -rf /var/cache/apk/*

# Allows us to put env vars into our release build
ENV REPLACE_OS_VARS=true SHELL=/bin/sh

COPY --from=builder /opt/app/_build/prod/rel/pet_store /pet_store

# Use the command distillery gave us to run the server in the foreground
CMD ["/pet_store/bin/pet_store", "foreground"]
