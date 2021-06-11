defmodule EyraUI.Button.PrimaryLiveViewButton do
  @moduledoc """
  A colored button with white text
  """
  use Surface.Component

  prop(label, :string, required: true)
  prop(event, :string, required: true)
  prop(width, :css_class, default: "pl-4 pr-4")
  prop(bg_color, :css_class, default: "bg-primary")
  prop(text_color, :css_class, default: "text-white")

  def render(assigns) do
    ~H"""
    <button phx-click={{ @event }} class="pt-15px pb-15px active:pt-4 active:pb-14px active:shadow-top4px leading-none font-button text-button text-white focus:outline-none rounded bg-primary {{@width}} {{@bg_color}} {{@text_color}}">
      {{ @label }}
    </button>
    """
  end
end
