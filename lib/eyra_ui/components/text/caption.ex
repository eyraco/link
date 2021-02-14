defmodule EyraUI.Text.Caption do
  @moduledoc """
  This title is to be used for ...?
  """

  use Surface.Component

  slot default, required: true
  prop text_alignment, :css_class, default: "text-center"

  def render(assigns) do
    ~H"""
    <div class="mb-5 pl-4 pr-4 text-grey3 mb-6 text-caption {{@text_alignment}}">
      <slot />
    </div>
    """
  end
end
