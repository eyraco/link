defmodule EyraUI.Button.PrimaryLabelButton do
  @moduledoc """
  An outlined button with colored text
  """
  use Surface.Component

  prop(label, :string, required: true)
  prop(field, :string, required: true)
  prop(bg_color, :css_class, default: "bg-primary")
  prop(text_color, :css_class, default: "text-white")

  def render(assigns) do
    ~H"""
    <label for={{@field}}>
      <div class="cursor-pointer pt-15px pb-15px active:shadow-top4px active:pt-4 active:pb-14px leading-none font-button text-button focus:outline-none rounded pr-4 pl-4 {{@bg_color}} {{@text_color}}" >
        {{ @label }}
      </div>
    </label>
    """
  end
end
