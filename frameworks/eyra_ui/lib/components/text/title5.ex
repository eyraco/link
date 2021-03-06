defmodule EyraUI.Text.Title5 do
  @moduledoc """
  This title is to be used for ...?
  """

  use Surface.Component

  slot(default, required: true)
  prop(color, :css_class, default: "text-grey1")

  def render(assigns) do
    ~H"""
    <div class="text-title6 font-title6 sm:text-title5 sm:font-title5 {{@color}}">
      <slot />
    </div>
    """
  end
end
