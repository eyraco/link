defmodule CoreWeb.Home.Collaborator do
  @moduledoc """
  Displays a team member on the home page
  """
  use Surface.Component

  prop org, :any, required: true

  def render(assigns) do
    ~H"""
    <div class="flex items-center justify-center" >
      <img class="h-16 md:h-20 lg:w-52 lg:h-52" src="/images/organisations/{{@org}}-logo.svg"/>
    </div>
    """
  end
end
