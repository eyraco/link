defmodule EyraUI.Form.TextArea do
  @moduledoc false
  use Surface.Component
  alias EyraUI.Form.Field
  import EyraUI.FormHelpers, only: [focus_border_color: 1, border_color: 2]

  import Phoenix.HTML
  import Phoenix.HTML.Form

  prop(field, :atom, required: true)
  prop(label_text, :string)
  prop(label_color, :css_class, default: "text-grey1")
  prop(background, :atom, default: :light)
  prop(target, :any)

  def render(assigns) do
    ~H"""
      <Context get={{Surface.Components.Form, form: form}} >
        <Field form={{form}} field={{@field}} label_text={{@label_text}} label_color={{@label_color}} background={{@background}}>
          <textarea
            id={{ input_id(form, @field) }}
            name={{ input_name(form, @field) }}
            class="text-grey1 text-bodymedium font-body pl-3 pt-2 w-full h-64 border-2 focus:outline-none rounded"
            x-bind:class="{ '{{focus_border_color(@background)}}': focus === '{{@field}}', '{{border_color(assigns, form)}}': focus !== '{{@field}}' }"
            x-on:focus="focus = '{{ @field }}'"
            x-on:click.stop
            phx-focus="focus"
            phx-value-field={{ @field }}
            phx-target={{ @target }}
          >{{ html_escape(input_value(form, @field) || "") }}</textarea>
        </Field>
      </Context>
    """
  end
end
