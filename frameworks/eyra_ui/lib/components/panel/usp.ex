defmodule EyraUI.Panel.USP do
  @moduledoc """
  The Unique Selling Point Card highlights a reason for taking an action.
  """
  use Surface.Component
  alias EyraUI.Panel.Panel

  prop(title, :string, required: true)
  prop(description, :string, required: true)
  prop(title_color, :css_class, default: "text-grey1")
  prop(description_color, :css_class, default: "text-grey2")

  def render(assigns) do
    ~H"""
    <Panel size="h-full">
      <template slot="title">
        <div class={{"text-title5", "font-title5", "lg:text-title4", "lg:font-title4", "mb-4", "lg:mb-6", @title_color }}>
              {{ @title }}
        </div>
      </template>
      <div class={{ "text-bodysmall", "lg:text-bodymedium", "font-body", @description_color }}>
          {{ @description }}
      </div>
    </Panel>
    """
  end
end
