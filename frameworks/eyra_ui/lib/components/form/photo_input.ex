defmodule EyraUI.Form.PhotoInput do
  @moduledoc false
  use Surface.Component

  alias EyraUI.Text.Title6
  alias EyraUI.{ImagePreview, Spacing}
  alias EyraUI.Case.{Case, True, False}
  alias EyraUI.Button.{PrimaryLabelButton, SecondaryLabelButton}

  prop(conn, :any, required: true)
  prop(static_path, :any, required: true)
  prop(label_text, :string)
  prop(label_color, :css_class, default: "text-grey1")
  prop(photo_url, :string, required: true)
  prop(uploads, :any, required: true)
  prop(primary_button_text, :string, required: true)
  prop(secondary_button_text, :string, required: true)

  def render(assigns) do
    ~H"""
    <Title6>{{@label_text}}</Title6>
    <div class="flex flex-row items-center">
      <ImagePreview
        image_url={{ @photo_url }}
        placeholder={{ @static_path.(@conn, "/images/profile_photo_default.svg") }}
        shape="w-image-preview-circle h-image-preview-circle rounded-full" />
      <Spacing value="S" direction="l" />
      <div class="flex-wrap">
        <Case value={{@photo_url}} >
          <True>
            <SecondaryLabelButton label={{@secondary_button_text}} field={{ @uploads.photo.ref }}/>
          </True>
          <False>
            <PrimaryLabelButton label={{@primary_button_text}} field={{ @uploads.photo.ref }}/>
          </False>
        </Case>
        {{ live_file_input @uploads.photo, class: "hidden" }}
      </div>
    </div>
    """
  end
end
