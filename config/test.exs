use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
# config :app, App.Endpoint,
#   http: [port: 4001],
#   server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :exnoops,
  http: Exnoops.API.HttpMock,
  base_url: ""
