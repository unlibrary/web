import Config

config :unpage, UnPageWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "NGgP7EhSdvV8aeHtWD/SdnzrCvlVgUzN0ErepM4py8yyTb9L63LFeejxqtNSiNaf",
  server: false

config :logger, level: :warn
config :phoenix, :plug_init_mode, :runtime
