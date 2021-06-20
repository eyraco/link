defmodule EyraUI.Container.ContentArea do
  @moduledoc """
  Container that makes the content appear centralized by adding margin to the right to adjust for the left sidebar.
  """
  use Surface.Component

  @doc "The content"
  slot(default, required: true)

  prop bg_color, :css_class, default: "bg-white"
  prop height, :css_class, default: "h-full"
  prop image_url, :string

  def render(assigns) do
    ~H"""
    <div class="relative {{@bg_color}}">
      <div :if={{@image_url}} class="absolute top-0 left-0 bg-grey1 w-full h-full">
        <img class="object-cover w-full h-full lazy opacity-60" src={{@image_url}}/>
      </div>
      <div class="relative flex w-full z-10 mt-12 lg:mt-20">
        <div class="flex-grow pl-6 pr-6 lg:pl-14 lg:pr-14">
          <div class="w-full">
            <slot />
          </div>
        </div>
        <div class="flex-wrap flex-shrink-0 w-0 lg:w-sidebar">
        </div>
      </div>
    </div>
    """
  end
end
