defmodule Gsis do
  use OAuth2.Strategy
  import SweetXml

  def client do
    OAuth2.Client.new(
      strategy: __MODULE__,
      client_id: Application.fetch_env!(:gsis_oauth, :client_id),
      client_secret: Application.fetch_env!(:gsis_oauth, :client_secret),
      site: "https://test.gsis.gr/oauth2server/",
      redirect_uri: Application.fetch_env!(:gsis_oauth, :redirect_uri),
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

  def get_info(client) do
    OAuth2.Client.get!(client, "/userinfo?format=xml").body
    |> xpath(~x"//userinfo",
      userid: ~x"@userid"s,
      taxid: ~x"@taxid"s,
      lastname: ~x"@lastname"s,
      firstname: ~x"@firstname"s,
      fathername: ~x"@fathername"s,
      mothername: ~x"@mothername"s,
      birthyear: ~x"@birthyear"s
    )
    |> Enum.map(fn {k, v} -> {k, String.trim(v)} end)
    |> Map.new()
  end

  def logout!() do
    # This won't work; you must redirect *the user* to that particular url!
    #logout_url = "https://test.gsis.gr/oauth2server/logout/" <> Application.fetch_env!(:gsis_oauth, :client_id)
    #{:ok, 200, _headers, ref} = :hackney.get(logout_url)
    #{:ok, _body} = :hackney.body(ref)

  end
end
