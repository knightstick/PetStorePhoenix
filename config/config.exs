# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :pet_store,
  ecto_repos: [PetStore.Repo]

# Configures the endpoint
config :pet_store, PetStore.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SoYwUIl0qlyT26aq1t7be7ZGbIqKUkTe0T3jKg8Zd7Ecb3dEMryxOsJwneslCPdA",
  render_errors: [view: PetStore.ErrorView, accepts: ~w(json)],
  pubsub: [name: PetStore.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
