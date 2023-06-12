import Config

config :unpage, UnPageWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: UnPageWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: UnPage.PubSub,
  live_view: [signing_salt: "SJ8Bjrj+"]

config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :unpage,
  server: :"readerd@localhost"

import_config "#{config_env()}.exs"
