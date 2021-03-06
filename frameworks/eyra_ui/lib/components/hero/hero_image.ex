defmodule EyraUI.Hero.HeroImage do
  @moduledoc """
  The hero is to be used as a large decorative header with image, title and subtitle.
  """
  use Surface.Component

  alias EyraUI.Spacing
  alias EyraUI.Image
  alias EyraUI.Text.{Title0, Title4}

  slot(call_to_action, required: true)

  prop(title, :string, required: true)
  prop(subtitle, :string, required: true)
  prop(image_info, :any, required: true)
  prop(text_color, :css_class, default: "text-white")

  def render(assigns) do
    ~H"""
    <div class="w-full"
       data-native-title={{@title}}>
      <div class="relative overflow-hidden w-full h-image-header sm:h-image-header-sm bg-grey4">
        <Image image={{@image_info}} transition="duration-1000"/>
        <div class="absolute z-20 top-0 left-0 h-full flex items-center justify-center">
          <div class="ml-6 mr-6 sm:ml-20 sm:mr-20 text-shadow-md flex-wrap">
            <Title0 color="text-white">{{@title}}</Title0>
            <Spacing value="S" />
            <Title4 color="text-white">{{@subtitle}}</Title4>
            <Spacing value="S" />
            <div>
              <slot name="call_to_action"/>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
