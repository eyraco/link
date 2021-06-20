defmodule Core.Home.Team do
  @moduledoc """
  Project data presented on the home page.
  """

  alias Core.Home.TeamMembers

  defstruct [:id, :members]

  def get_members(%Core.Home.Team{members: members}) do
    TeamMembers.entities(members)
  end

end
