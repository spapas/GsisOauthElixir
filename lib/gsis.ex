defmodule Gsis do
  use OAuth2.Strategy
  # Public API
  def client do
    OAuth2.Client.new(
      strategy: __MODULE__,
      client_id: Application.fetch_env!(:gsis_oauth, :client_id),
      client_secret: Application.fetch_env!(:gsis_oauth, :client_secret),
      site: "https://test.gsis.gr/oauth2server/",
      redirect_uri: "http://adeiesuat.hcg.gr/accounts/ggpsprovider/login/callback/",
      authorize_url: "https://test.gsis.gr/oauth2server/oauth/authorize",
      token_url: "https://test.gsis.gr/oauth2server/oauth/token"
    )
    |> OAuth2.Client.put_serializer("application/json", Jason)
    |> OAuth2.Client.put_serializer("application/vnd.api+json", Jason)
  end

  def authorize_url! do
    OAuth2.Client.authorize_url!(client(), scope: "read")
  end

  def get_token!(params \\ [], headers \\ [], opts \\ []) do
    OAuth2.Client.get_token!(client(), params, headers, opts)
  end

  # Strategy Callbacks
  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
    |> put_header("accept", "application/json")
  end
end
