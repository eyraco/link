defmodule Core.Home.TeamMembers do
  @moduledoc """
  Defines team members used on the home page.
  """

  alias Core.Home.TeamMember

  def entities do
    [
      %TeamMember{
        id: :emiel,
        name: "Emiel van der Veen",
        promo:
          "In collaboration with the VU, UvA and SURF, we are developing a sustainable online participant recruitment platform for social sciences and humanities research. Funded by the PDI-SSH.",
        bio:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        website: "https://linkedin.com"
      },
      %TeamMember{
        id: :adrienne,
        name: "Adrienne Mendrik",
        promo:
          "In collaboration with the VU, UvA and SURF, we are developing a sustainable online participant recruitment platform for social sciences and humanities research. Funded by the PDI-SSH.",
        bio:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        website: "https://linkedin.com"
      },
      %TeamMember{
        id: :jeroen,
        name: "Jeroen Vloothuis",
        promo:
          "In collaboration with the VU, UvA and SURF, we are developing a sustainable online participant recruitment platform for social sciences and humanities research. Funded by the PDI-SSH.",
        bio:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        website: "https://linkedin.com"
      },
      %TeamMember{
        id: :neo,
        name: "Neo Cheung",
        promo:
          "In collaboration with the VU, UvA and SURF, we are developing a sustainable online participant recruitment platform for social sciences and humanities research. Funded by the PDI-SSH.",
        bio:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        website: "https://linkedin.com"
      },
      %TeamMember{
        id: :peter,
        name: "Peter Waterman",
        promo:
          "In collaboration with the VU, UvA and SURF, we are developing a sustainable online participant recruitment platform for social sciences and humanities research. Funded by the PDI-SSH.",
        bio:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        website: "https://linkedin.com"
      },
      %TeamMember{
        id: :daniel,
        name: "Daniel Oberski",
        promo:
          "In collaboration with the VU, UvA and SURF, we are developing a sustainable online participant recruitment platform for social sciences and humanities research. Funded by the PDI-SSH.",
        bio:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        website: "https://linkedin.com"
      },
      %TeamMember{
        id: :stan,
        name: "Stan Bentvelsen",
        promo:
          "In collaboration with the VU, UvA and SURF, we are developing a sustainable online participant recruitment platform for social sciences and humanities research. Funded by the PDI-SSH.",
        bio:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        website: "https://linkedin.com"
      },
      %TeamMember{
        id: :martha,
        name: "Martha Larson",
        promo:
          "In collaboration with the VU, UvA and SURF, we are developing a sustainable online participant recruitment platform for social sciences and humanities research. Funded by the PDI-SSH.",
        bio:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        website: "https://linkedin.com"
      },
      %TeamMember{
        id: :laura,
        name: "Laura Boeschoten",
        promo:
          "In collaboration with the VU, UvA and SURF, we are developing a sustainable online participant recruitment platform for social sciences and humanities research. Funded by the PDI-SSH.",
        bio:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        website: "https://linkedin.com"
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
    ids
    |> Enum.map(&entity(&1))
  end
end
