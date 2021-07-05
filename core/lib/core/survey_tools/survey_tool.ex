defmodule Core.SurveyTools.SurveyTool do
  @moduledoc """
  The survey tool schema.
  """
  use Ecto.Schema
  require Core.Themes
  import Ecto.Changeset
  alias Core.Studies.Study
  alias Core.SurveyTools.SurveyToolTask
  alias Core.Accounts.User

  schema "survey_tools" do
    belongs_to(:auth_node, Core.Authorization.Node)
    belongs_to(:study, Study)

    field(:title, :string)
    field(:subtitle, :string)
    field(:expectations, :string)
    field(:description, :string)
    field(:survey_url, :string)
    field(:subject_count, :integer)
    field(:duration, :string)
    field(:phone_enabled, :boolean)
    field(:tablet_enabled, :boolean)
    field(:desktop_enabled, :boolean)
    field(:published_at, :naive_datetime)
    field(:themes, {:array, Ecto.Enum}, values: Core.Themes.theme_values())
    field(:image_id, :string)
    field(:marks, {:array, :string})
    field(:reward_currency, Ecto.Enum, values: [:eur, :usd, :gbp, :chf, :nok, :sek])
    field(:reward_value, :integer)
    field(:banner_photo_url, :string)
    field(:banner_title, :string)
    field(:banner_subtitle, :string)
    field(:banner_url, :string)

    has_many(:tasks, SurveyToolTask)
    many_to_many(:participants, User, join_through: :survey_tool_participants)

    timestamps()
  end

  defimpl GreenLight.AuthorizationNode do
    def id(survey_tool), do: survey_tool.auth_node_id
  end

  @fields ~w(title subtitle expectations description survey_url subject_count duration phone_enabled tablet_enabled desktop_enabled published_at themes image_id marks reward_currency reward_value banner_photo_url banner_title banner_subtitle banner_url)a

  @doc false
  def changeset(survey_tool, attrs) do
    survey_tool
    |> cast(attrs, @fields)
    |> validate_required([:title])
  end

  def published?(%__MODULE__{published_at: published_at}) do
    !is_nil(published_at)
  end
end