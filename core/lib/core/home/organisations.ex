defmodule Core.Home.Organisations do
  @moduledoc """
  Defines projects used on the home page.
  """

  alias Core.Home.Organisation

  def entities do
    [
      %Organisation{
        id: :eyra,
        name: "Eyra"
      },
      %Organisation{
        id: :uu,
        name: "Universiteit Utrecht"
      },
      %Organisation{
        id: :uva,
        name: "Universiteit van Amsterdam"
      },
      %Organisation{
        id: :vu,
        name: "Vrije Unversiteit Amsterdam"
      },
      %Organisation{
        id: :surf,
        name: "SURF"
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
    |> Enum.filter(&(ids |>  Enum.member?(&1.id)))
  end

end
