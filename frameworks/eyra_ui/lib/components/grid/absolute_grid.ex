defmodule EyraUI.Grid.AbsoluteGrid do
  @moduledoc """
  The grid is to be used for.
  """
  use Surface.Component

  prop cols, :string, required: true
  prop gap, :string

  defp cols("6"), do: "sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-6"
  defp cols("5"), do: "sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-5"
  defp cols("4"), do: "md:grid-cols-2 lg:grid-cols-4"
  defp cols("3"), do: "md:grid-cols-3"
  defp cols(_), do: "sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-5"

  defp gap(nil), do: "gap-8"
  defp gap(gap), do: "gap-#{gap}"

  @doc "The content"
  slot(default, required: true)

  def render(assigns) do
    ~H"""
    <div class="grid {{cols(@cols)}} {{gap(@gap)}}">
      <slot />
    </div>
    """
  end
end
