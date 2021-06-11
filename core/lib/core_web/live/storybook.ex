defmodule CoreWeb.Storybook do
  @moduledoc """
  The home screen.
  """
  use CoreWeb, :live_view

  alias EyraUI.Hero.HeroSmall
  alias EyraUI.Container.{ContentArea}
  alias EyraUI.Text.{Title1, Title2, Title3, Title4, Title5, Title6}
  alias EyraUI.Button.{PrimaryButton, PrimaryAlpineButton, PrimaryLiveViewButton, SecondaryAlpineButton, SecondaryLabelButton, SecondaryLiveViewButton}
  alias EyraUI.{Spacing}

  alias CoreWeb.Storybook.Component

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  # defmacrop sigil_H({:<<>>, _, [_]} = ast, opts) do
  #   quote do
  #     Surface.sigil_H(unquote(ast), unquote(opts))
  #   end
  # end

  def render(assigns) do
    ~H"""
      <HeroSmall title="Storybook" />

      <ContentArea>
        <Title1>Text</Title1>
        <div class="ml-4">
          <Title1>Title1</Title1>
          <Title2>Title2</Title2>
          <Title3>Title3</Title3>
          <Title4>Title4</Title4>
          <Title5>Title5</Title5>
          <Title6>Title6</Title6>
        </div>

        <Spacing value="XL" />

        <Title1>Buttons</Title1>
        <div class="flex flex-col sm:flex-row">
          <div class="mb-4 sm:mb-0 sm:mr-4">
            <Component>
              <PrimaryButton label="PrimaryButton" path="" bg_color="bg-grey1" text_color="text-white"/>
            </Component>
          </div>
          <div class="mb-4 sm:mb-0 sm:mr-4">
            <PrimaryAlpineButton label="PrimaryAlpineButton" click="" bg_color="bg-grey1" text_color="text-white"/>
          </div>
          <div>
            <PrimaryLiveViewButton label="PrimaryLiveViewButton" event="" bg_color="bg-grey1" text_color="text-white"/>
          </div>
        </div>

        <Spacing value="M" />

        <div class="flex flex-col sm:flex-row">
          <div class="mb-4 sm:mb-0 sm:mr-4">
            <PrimaryButton label="PrimaryButton" path=""/>
          </div>
          <div class="mb-4 sm:mb-0 sm:mr-4">
            <PrimaryAlpineButton label="PrimaryAlpineButton" click=""/>
          </div>
          <div>
            <PrimaryLiveViewButton label="PrimaryLiveViewButton" event=""/>
          </div>
        </div>

        <Spacing value="M" />

        <div class="flex flex-col sm:flex-row">
          <div class="mb-4 sm:mb-0 sm:mr-4">
            <PrimaryButton label="PrimaryButton" path="" bg_color="bg-tertiary" text_color="text-grey1"/>
          </div>
          <div class="mb-4 sm:mb-0 sm:mr-4">
            <PrimaryAlpineButton label="PrimaryAlpineButton" click="" bg_color="bg-tertiary" text_color="text-grey1"/>
          </div>
          <div>
            <PrimaryLiveViewButton label="PrimaryLiveViewButton" event="" bg_color="bg-tertiary" text_color="text-grey1"/>
          </div>
        </div>

        <Spacing value="M" />

        <div class="flex flex-col sm:flex-row">
          <div class="mb-4 sm:mb-0 sm:mr-4">
            <PrimaryButton label="PrimaryButton" path="" bg_color="bg-success" text_color="text-white"/>
          </div>
          <div class="mb-4 sm:mb-0 sm:mr-4">
            <PrimaryAlpineButton label="PrimaryAlpineButton" click="" bg_color="bg-success" text_color="text-white"/>
          </div>
          <div>
            <PrimaryLiveViewButton label="PrimaryLiveViewButton" event="" bg_color="bg-success" text_color="text-white"/>
          </div>
        </div>

        <Spacing value="M" />

        <div class="flex flex-col sm:flex-row">
          <div class="mb-4 sm:mb-0 sm:mr-4">
            <SecondaryLabelButton label="SecondaryLabelButton" field="field"/>
          </div>
          <div class="mb-4 sm:mb-0 sm:mr-4">
            <SecondaryAlpineButton label="SecondaryAlpineButton" click=""/>
          </div>
          <div>
            <SecondaryLiveViewButton label="SecondaryLiveViewButton" event="" color="text-primary"/>
          </div>
        </div>

        <Spacing value="M" />

        <div class="flex flex-col sm:flex-row">
          <div class="mb-4 sm:mb-0 sm:mr-4">
            <SecondaryLabelButton label="SecondaryLabelButton" field="field" border_color="border-delete" text_color="text-delete"/>
          </div>
          <div class="mb-4 sm:mb-0 sm:mr-4">
            <SecondaryAlpineButton label="SecondaryAlpineButton" click="" border_color="border-delete" text_color="text-delete"/>
          </div>
          <div>
            <SecondaryLiveViewButton label="SecondaryLiveViewButton" event=""/>
          </div>
        </div>

        </ContentArea>

    """
  end
end
