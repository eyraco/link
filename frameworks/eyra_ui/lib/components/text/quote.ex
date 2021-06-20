defmodule EyraUI.Text.Quote do
  @moduledoc """
  This title is to be used for ...?
  """
  use Surface.Component

  slot default, required: true

  prop color, :css_class, default: "text-grey1"
  prop align, :css_class, default: "text-left"

  def render(assigns) do
    ~H"""
    <div class="text-quotesmall font-quote sm:text-quotelarge text-center {{@color}} {{@align}}">
      <slot />
    </div>
    """
  end
end
