defmodule LinkWeb.Study.New do
  @moduledoc """
  The home screen.
  """
  use LinkWeb, :live_view
  use LinkWeb.LiveViewPowHelper
  use EyraUI.Create, :study
  alias Surface.Components.Form
  alias EyraUI.Form.{TextInput}
  alias EyraUI.Hero.HeroSmall
  alias EyraUI.Button.{SubmitButton}
  alias EyraUI.Container.{ContentArea}

  alias Link.Studies


  def mount(params, session, socket) do
    socket =
      socket |> assign(current_user: get_user(socket, session) |> IO.inspect(label: "USER"))

    super(params, session, socket)
  end

  def create(socket, changeset) do
    current_user = socket.assigns.current_user

    with {:ok, study} <- Studies.create_study(changeset, current_user) do
      {:ok, Routes.live_path(socket, LinkWeb.Study.Show, study.id)}
    end
  end

  defdelegate get_changeset(attrs \\ %{}), to: Studies, as: :get_study_changeset

  def render(assigns) do
    ~H"""
      <HeroSmall title={{ dgettext("eyra-study", "study.new.title") }} />
      <ContentArea>
        <Form for={{ @changeset }} submit="create">
          <TextInput field={{:title}} label_text={{dgettext("eyra-study", "title.label")}} />
          <TextInput field={{:description}} label_text={{dgettext("eyra-study", "description.label")}} />
          <SubmitButton label={{ dgettext("eyra-study", "save.button") }} />
        </Form>
      </ContentArea>
    """
  end

end
