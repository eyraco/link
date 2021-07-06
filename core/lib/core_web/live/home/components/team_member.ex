defmodule CoreWeb.Home.TeamMember do
  @moduledoc """
  Displays a team member on the home page
  """
  use Surface.Component

  alias EyraUI.Text.{Title5, BodySmall}
  alias EyraUI.Button.ForwardButton
  alias EyraUI.{ImagePreview}

  prop(conn, :any, required: true)
  prop(path_provider, :any, required: true)
  prop(member, :any, required: true)
  prop(include_button, :boolean, default: true)

  def render(assigns) do
    ~H"""
    <div class="flex flex-row justify-center sm:flex-col items-center pl-6 pr-6 sm:p-0">
      <ImagePreview
        image_url={{ @path_provider.static_path(@conn, "/images/members/#{@member.id}.png") }}
        placeholder={{ @path_provider.static_path(@conn, "/images/profile_photo_default.svg") }}
        shape="w-image-circle-sm h-image-circle-sm md:w-image-circle-lg md:h-image-circle-lg rounded-full flex-shrink-0" />
      <div class="ml-6 sm:ml-0 sm:mb-4 lg:mb-8" />
      <div class="flex flex-col sm:items-center justify-center flex-grow">
        <Title5 align="text-left sm:text-center">{{ @member.name }}</Title5>
        <div class="hidden sm:block">
            <div class="mb-4" />
            <BodySmall align="text-center" color="text-grey2">{{ @member.promo }}</BodySmall>
        </div>
        <If condition={{@include_button}}>
          <div class="mb-1 sm:mb-6" />
          <ForwardButton label="Lees meer" path={{ @member.website }} />
        </If>
      </div>
    </div>
    """
  end
end
