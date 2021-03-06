defmodule CoreWeb.Live.User.ResetPasswordToken.Test do
  use CoreWeb.ConnCase, async: true
  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  alias CoreWeb.User.ResetPasswordToken
  alias Core.Accounts
  alias Core.Factories

  describe "as a visitor" do
    test "reset form redirects on an invalid token", %{conn: conn} do
      {:error, {:redirect, %{to: "/user/reset-password"}}} =
        live(conn, Routes.live_path(conn, ResetPasswordToken, "abc"))
    end

    test "reset form allows the user to alter their password", %{conn: conn} do
      user = Factories.insert!(:member)

      token =
        extract_user_token(fn url ->
          Accounts.deliver_user_reset_password_instructions(user, url)
        end)

      {:ok, view, _html} = live(conn, Routes.live_path(conn, ResetPasswordToken, token))

      password = Factories.valid_user_password()

      {:error, {:redirect, %{to: "/user/signin"}}} =
        view
        |> element("form")
        |> render_submit(%{user: %{password: password, password_confirmation: password}})
    end

    test "reset form checks for matching confirmation", %{conn: conn} do
      user = Factories.insert!(:member)

      token =
        extract_user_token(fn url ->
          Accounts.deliver_user_reset_password_instructions(user, url)
        end)

      {:ok, view, _html} = live(conn, Routes.live_path(conn, ResetPasswordToken, token))

      password = Factories.valid_user_password()

      html =
        view
        |> element("form")
        |> render_submit(%{
          user: %{password: password, password_confirmation: password <> "extra-stuff"}
        })

      assert html =~ "does not match password"
    end
  end
end
