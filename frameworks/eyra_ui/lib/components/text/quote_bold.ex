defmodule EyraUI.Text.QuoteBold do
  @moduledoc """
  This title is to be used for ...?
  """
  use Surface.Component

  slot(default, required: true)

  prop(color, :css_class, default: "text-grey1")
  prop(align, :css_class, default: "text-left")

  def render(assigns) do
    ~H"""
    <span class="text-quotesmall font-quotebold sm:text-quotelarge {{@color}} {{@align}}">
      <slot />
    </span>
    """
  end
end
