defmodule EyraUI.Button.SecondaryButton do
  @moduledoc """
  A colored button with white text
  """
  use Surface.Component

  prop(path, :string, required: true)
  prop(label, :string, required: true)
  prop(color, :css_class, default: "primary")

  def render(assigns) do
    ~H"""
    <a href= {{ @path }} >
      <div class="flex">
        <div class="flex-wrap pt-13px pb-13px active:pt-14px active:pb-3 active:shadow-top2px border-2 leading-none focus:outline-none bg-opacity-0 rounded border-{{@color}}">
          <div class="flex flex-col justify-center h-full items-center rounded">
            <div class="text-button font-button pl-4 pr-4 text-{{@color}}">
              {{ @label }}
            </div>
          </div>
        </div>
      </div>
    </a>
    """
  end
end
