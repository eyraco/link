defmodule EyraUI.Button.PrimaryButton do
  @moduledoc """
  A colored button with white text
  """
  use Surface.Component
  alias Surface.Components.LiveRedirect

  prop(to, :string, required: true)
  prop(label, :string, required: true)
  prop(bg_color, :css_class, default: "bg-primary")
  prop(text_color, :css_class, default: "text-white")

  def render(assigns) do
    ~H"""
    <LiveRedirect to={{ @to }} >
      <div class="flex">
        <div class="flex-wrap pt-15px pb-15px active:shadow-top4px active:pt-4 active:pb-14px focus:outline-none rounded {{@bg_color}}">
          <div class="flex flex-col justify-center h-full items-center rounded">
            <div class="text-button font-button pl-4 pr-4 {{@text_color}}">
              {{ @label }}
            </div>
          </div>
        </div>
      </div>
    </LiveRedirect>
    """
  end
end
