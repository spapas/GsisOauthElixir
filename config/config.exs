import Config

config :oauth2,
  debug: true

config :gsis_oauth,
  client_id: "",
  client_secret: ""

import_config "secrets.exs"
