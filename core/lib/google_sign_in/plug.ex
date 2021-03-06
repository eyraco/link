defmodule GoogleSignIn.PlugUtils do
  def config(otp_app) do
    Application.get_env(otp_app, GoogleSignIn)
  end

  def google_module(config) do
    Keyword.get(config, :google_module, Assent.Strategy.Google)
  end

  def log_in_user(config, conn, user) do
    log_in_user = Keyword.get(config, :log_in_user, &CoreWeb.UserAuth.log_in_user/2)
    log_in_user.(conn, user)
  end
end

defmodule GoogleSignIn.AuthorizePlug do
  @moduledoc """
  This controller manages the OpenID Connect flow with SurfConext.

  See this site for more info: https://sp.google_sign_in.nl/
  """
  import Plug.Conn
  import GoogleSignIn.PlugUtils

  def init(otp_app) when is_atom(otp_app), do: otp_app

  def call(conn, otp_app) do
    config = config(otp_app)

    {:ok, %{url: url, session_params: session_params}} =
      google_module(config).authorize_url(config)

    conn
    |> put_session(:google_sign_in, session_params)
    |> Phoenix.Controller.redirect(external: url)
  end
end

defmodule(GoogleSignIn.CallbackPlug) do
  import Plug.Conn
  import GoogleSignIn.PlugUtils

  def init(otp_app) when is_atom(otp_app), do: otp_app

  def call(conn, otp_app) do
    session_params = get_session(conn, :google_sign_in)

    config = config(otp_app) |> Keyword.put(:session_params, session_params)

    {:ok, %{user: google_user}} = google_module(config).callback(config, conn.params)

    user = GoogleSignIn.get_user_by_sub(google_user["sub"]) || register_user(google_user)

    log_in_user(config, conn, user)
  end

  defp register_user(info) do
    {:ok, google_sign_in_user} = GoogleSignIn.register_user(info)
    google_sign_in_user.user
  end
end
