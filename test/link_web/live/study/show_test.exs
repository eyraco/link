defmodule LinkWeb.Live.Study.Show.Test do
  use LinkWeb.ConnCase
  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  alias LinkWeb.Study

  alias Link.Factories

  def setup_study(_ctx) do
    study = Factories.insert!(:survey_tool).study
    {:ok, study: study}
  end

  defp take_ownership_of_study(%{user: user, study: study}) do
    :ok = Link.Authorization.assign_role(user, study, :owner)

    {:ok, []}
  end

  describe "as an owner" do
    setup [:login_as_researcher, :setup_study, :take_ownership_of_study]

    test "edit a study", %{conn: conn, study: study} do
      {:ok, view, _html} = live(conn, Routes.live_path(conn, Study.Show, study.id))
      title = Faker.Lorem.sentence()
      description = Faker.Lorem.sentence()

      view
      |> element("form")
      |> render_change(%{study: %{title: title, description: description}})
    end
  end

  describe "as a member" do
    setup [:login_as_researcher, :setup_study]

    test "disallow other researchers to edit a study", %{conn: conn, study: study} do
      {:ok, _view, html} = live(conn, Routes.live_path(conn, Study.Show, study.id))
      assert html =~ "Access Denied"
    end
  end
end
