# GsisOauth

**A small script to authenticate with GSIS oauth through elixir**

## Usage

From cmd: 

```
mix deps.get
iex -S mix
copy config\secrets.exs.template config\secrets.exs
```

Configure config\secrets.exs with your app settings.

Now from iex prompt:

```
> Gsis.authorize_url!
# Copy over the url you get in your browser. Login as usual. It will redirect back to your app with a code parameter. Copy over this:

> client = Gsis.get_token!(code: "code")
# where code is the code you just received 

> info = Gsis.get_info(client)
# info will have the info of the autenticated user

```



