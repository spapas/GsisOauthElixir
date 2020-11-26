import Config

config :oauth2,
  debug: true

config :gsis_oauth,
  client_id: "",
  client_secret: "",
  redirect_uri: ""

import_config "secrets.exs"
