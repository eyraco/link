defmodule Core.Home.Teams do
  @moduledoc """
  Defines teams used on the home page.
  """

  alias Core.Home.Team

  def entities do
    [
      %Team{
        id: :eyra,
        members: [:adrienne, :emiel, :jeroen, :neo, :peter]
      },
      %Team{
        id: :scientific_board,
        members: [:martha, :stan, :daniel]
      },
      %Team{
        id: :link,
        members: [:emiel, :adrienne, :jeroen, :neo]
      },
      %Team{
        id: :port,
        members: [:adrienne, :emiel, :jeroen, :neo, :laura, :daniel]
      },
      %Team{
        id: :next,
        members: [:adrienne, :emiel, :jeroen, :neo]
      }
    ]
  end

  def entity(id) when is_atom(id) do
    entities()
    |> Enum.find(nil, &(&1.id === id))
  end

  def entity(id) when is_binary(id) do
    entities()
    |> Enum.find(nil, &(&1.id === String.to_atom(id)))
  end

  def entities(nil), do: nil

  def entities(ids) when is_list(ids) do
    entities()
    |> Enum.filter(&(ids |> Enum.member?(&1.id)))
  end
end
