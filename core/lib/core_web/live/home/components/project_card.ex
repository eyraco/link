defmodule CoreWeb.Home.ProjectCard do
  @moduledoc """
  A large eye-catcher meant to call a user into taking an action.
  """
  use Surface.Component

  alias EyraUI.{Tag, Spacing, Icon}
  alias EyraUI.Text.{SubHead, Label}
  alias EyraUI.Card.Card
  alias EyraUI.Button.PrimaryLiveViewButton

  prop(conn, :any, required: true)
  prop(path_provider, :any, required: true)
  prop(id, :string, required: true)
  prop(title, :string, required: true)
  prop(label, :string)
  prop(description, :string, required: true)
  prop(image_url, :string, required: true)
  prop(icons, :list, required: true)
  prop(tags, :list, default: [])
  prop(info, :list, default: [])
  prop(bg_color, :css_class, default: "bg-grey1")
  prop(text_color, :css_class, default: "text-white")
  prop(label_type, :string, default: "tertiary")
  prop(tag_type, :css_class, default: "grey2")
  prop(info1_color, :css_class, default: "text-tertiary")
  prop(info2_color, :css_class, default: "text-white")
  prop(click_event_name, :string)
  prop(click_event_data, :string)

  def render(assigns) do
    ~H"""
    <Card bg_color={{@bg_color}} id={{@id}} click_event_name={{@click_event_name}} click_event_data={{@click_event_data}}>
      <template slot="image">
        <div class="relative">
          <If condition={{ @label }} >
            <div class="absolute top-6">
              <EyraUI.Card.Label conn={{@socket}} path_provider={{@path_provider}} text={{@label}} type={{@label_type}} />
            </div>
          </If>
          <If condition={{ @icons }} >
            <div class="absolute flex top-6 right-6">
              <For each={{ icon <- @icons }} >
                <Icon size="S" src={{ @path_provider.static_path(@conn, "/images/organisations/#{icon}-icon.svg") }} />
              </For>
            </div>
          </If>
          <div class="h-image-card">
            <img class="rounded-t-lg bg-grey4 object-cover w-full h-full" src="{{ @image_url }}" />
          </div>
        </div>
      </template>
      <template slot="title">
        <div class="text-title5 font-title5 lg:text-title3 lg:font-title3 mb-6 {{@text_color}}">
            {{ @title }}
        </div>
      </template>
      <div class="mt-6 lg:mt-8">
        <div class="text-bodymedium font-body {{@text_color}}">
          {{ @description }}
        </div>
        <div class="flex items-center">
            <div class="flex-wrap">
              <If condition={{ @tags }} >
                <div class="flex items-center">
                  <For each={{ tag <- @tags }} >
                    <Tag text={{ tag }} bg_color="bg-{{@tag_type}}" text_color="text-{{@tag_type}}" />
                    <Spacing value="XS" direction="l" />
                  </For>
                </div>
                <Spacing value="S" />
              </If>
              <If condition={{ Enum.count(@info) > 0 }} >
                <SubHead color={{@info1_color}}>
                  {{ @info |> List.first() }}
                </SubHead>
                <Spacing value="M" />
              </If>
              <If condition={{ Enum.count(@info) > 1 }} >
                <Label color={{@info2_color}}>
                  {{ @info |> Enum.at(1) }}
                </Label>
              </If>
              <If condition={{ Enum.count(@info) > 2 }} >
                <Spacing value="2" />
                <Label color={{@info2_color}}>
                  {{ @info |> Enum.at(2) }}
                </Label>
              </If>
            </div>
            <div class="flex-grow"></div>
        </div>
        <PrimaryLiveViewButton label="Bekijk Project" event={{@click_event_name}} bg_color="bg-tertiary" text_color="text-grey1" />
      </div>
    </Card>
    """
  end
end
