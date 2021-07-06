defmodule EyraUI.Text.BodySmall do
  @moduledoc """
  The body small is to be used for ...?
  """
  use Surface.Component

  slot(default, required: true)
  prop(color, :css_class, default: "text-grey1")
  prop(align, :css_class, default: "text-left")

  def render(assigns) do
    ~H"""
    <div class="flex-wrap text-bodysmall font-body {{@color}} {{@align}}">
      <slot />
    </div>
    """
  end
end
