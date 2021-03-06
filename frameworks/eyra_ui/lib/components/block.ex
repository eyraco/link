defmodule EyraUI.Block do
  @moduledoc """
  The Unique Selling Point Card highlights a reason for taking an action.
  """
  use Surface.Component

  @doc "The blocks"
  slot(default, required: true)

  def render(assigns) do
    ~H"""
    <div class="flex-wrap">
      <slot />
    </div>
    """
  end
end
