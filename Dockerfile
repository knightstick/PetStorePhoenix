FROM elixir:1.5.2
ENV DEBIAN_FRONTEND=noninteractive

ENV HOME=/opt/app/ TERM=xterm

# Add the wait-for-it.sh script for waiting on dependent containers
RUN curl https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /usr/local/bin/wait-for-it.sh \
    && chmod +x /usr/local/bin/wait-for-it.sh

# Install Hex+Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

WORKDIR /opt/app
ENV MIX_ENV=prod REPLACE_OS_VARS=true

# Cache elixir deps
COPY mix.exs mix.lock ./
RUN mix deps.get
COPY config ./config
RUN mix deps.compile
RUN mix phx.digest

COPY . .
RUN mix release --env=prod
