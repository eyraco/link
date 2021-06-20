defmodule EyraUI.Button.ForwardButton do
  @moduledoc """
  A colored button with white text
  """
  use Surface.Component

  prop path, :string, required: true
  prop label, :string, required: true
  prop icon, :string, default: "/images/forward.svg"
  prop text_color, :css_class, default: "text-primary"

  def render(assigns) do
    ~H"""
    <a href= {{ @path }} >
      <div class="pt-1 pb-1 active:pt-5px active:pb-3px rounded bg-opacity-0">
        <div class="flex items-center">
          <div class="focus:outline-none">
            <div class="flex flex-col justify-center h-full items-center">
              <div class="flex-wrap text-button font-button {{@text_color}}">
                {{ @label }}
              </div>
            </div>
          </div>
          <div>
              <img class="ml-4 -mt-2px" src={{@icon}}/>
          </div>
        </div>
      </div>
    </a>
    """
  end
end
