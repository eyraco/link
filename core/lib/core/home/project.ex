defmodule Core.Home.Project do
  @moduledoc """
  Project data presented on the home page.
  """

  alias Core.Home.Organisations
  alias Core.Home.TeamMembers

  defstruct [
    :id,
    :name,
    :promo,
    :intro,
    :description,
    :image_id,
    :info,
    :collaborators,
    :funded_by,
    :vision,
    :mission,
    :aim,
    :team_members
  ]

  def get_collaborators(%Core.Home.Project{collaborators: collaborators}) do
    Organisations.entities(collaborators)
  end

  def get_team_members(%Core.Home.Project{team_members: team_members}) do
    TeamMembers.entities(team_members)
  end
end
