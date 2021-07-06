defmodule CoreWeb.Index do
  @moduledoc """
  The home screen.
  """
  use CoreWeb, :live_view

  alias EyraUI.Container.{ContentArea}
  alias EyraUI.Hero.HeroLarge
  alias EyraUI.Grid.{AbsoluteGrid}
  alias EyraUI.Text.{Title1, Title2, Quote, QuoteBold, Intro}
  alias EyraUI.Button.{PrimaryLiveViewButton, SecondaryButton}
  alias EyraUI.{Spacing}

  alias Core.Home.{Team, Teams}
  alias CoreWeb.Home.{TeamMember, ProjectCard, Collaborator}

  data(projects, :any)
  data(eyra_members, :any)
  data(scientific_board_members, :any)

  def mount(_params, _session, socket) do
    projects = Core.Home.Projects.entities()

    eyra_members =
      Teams.entity(:eyra)
      |> Team.get_members()

    scientific_board_members =
      Teams.entity(:scientific_board)
      |> Team.get_members()

    {:ok,
     socket
     |> assign(
       projects: projects,
       eyra_members: eyra_members,
       scientific_board_members: scientific_board_members
     )}
  end

  def handle_info({:handle_click, %{action: :open, project: project}}, socket) do
    {:noreply, push_redirect(socket, to: Routes.live_path(socket, CoreWeb.Home.Project, project))}
  end

  def render(assigns) do
    ~H"""
      <HeroLarge title={{ dgettext("eyra-home", "index.title") }}
            subtitle={{dgettext("eyra-home", "index.subtitle")}} />

      <ContentArea>
        <AbsoluteGrid cols="3" gap="8" >
          <For each={{ project <- @projects }}>
            <ProjectCard
              conn={{@socket}}
              path_provider={{Routes}}
              id={{ project.id }}
              title={{ project.name }}
              description={{ project.promo }}
              info={{ ["Funded by #{ project.funded_by }"] }}
              image_url= {{ "https://unsplash.com/photos/#{project.image_id}/download?force=true&w=640" }}
              icons={{ project.collaborators }}
              click_event_data={{ %{action: :open, project: "#{project.id}" } }} />
          </For>
         </AbsoluteGrid>
         <div>
            <Spacing value="XXL" />
            <Title1 align="text-center">Meet our team</Title1>
            <Spacing value="XL" />
            <AbsoluteGrid cols="5" gap="10">
              <For each={{ member <- @eyra_members }}>
                <TeamMember conn={{@socket}} path_provider={{Routes}} member={{member}} />
              </For>
            </AbsoluteGrid>
         </div>
      </ContentArea>

      <ContentArea bg_color="bg-tertiary">
        <div>
          <div class="flex flex-col items-center pt-12 pb-12 pl-2 pr-2 lg:p-20" >
            <Title2 align="text-center">Open Science</Title2>
            <Quote>"We work towards a world in which the current state of <QuoteBold>human knowledge</QuoteBold> is available to all of humankind, so anyone can <QuoteBold>learn</QuoteBold> from and <QuoteBold>build</QuoteBold> upon previous knowledge."</Quote>
            <Spacing value="10"/>
            <PrimaryLiveViewButton label="More about us" event="more-about-us" bg_color="bg-grey1" />
          </div>
        </div>
      </ContentArea>

      <ContentArea>
        <div>
          <Title1 align="text-center">Scientific advisory board</Title1>
          <Spacing value="XL" />
          <AbsoluteGrid cols="3">
            <For each={{ member <- @scientific_board_members }}>
              <TeamMember conn={{@socket}} path_provider={{Routes}} member={{member}} include_button={{ false }}/>
            </For>
          </AbsoluteGrid>
        </div>
      </ContentArea>

      <ContentArea image_url="https://www.apollo14.nl/wp-content/uploads/2019/08/Apollo14-voorzijde.jpg">
        <div class="ml-8 mr-8 sm:ml-20 sm:mr-20 text-shadow-md flex-wrap">
          <Spacing value="48" />
          <Title1 color="text-white">We are part of Apollo 14</Title1>
          <Spacing value="S" />
          <Intro color="text-white">Home for startups that innovate for a better world</Intro>
          <Spacing value="S" />
          <SecondaryButton label="Find out more" path="https://www.apollo14.nl" color="white"/>
          <Spacing value="48" />
        </div>
      </ContentArea>

      <ContentArea>
        <div class="w-full">
          <Title1 align="text-center">Collaborators</Title1>
          <Spacing value="L" />
          <div class="flex items-center justify-center w-full">
            <AbsoluteGrid cols="4" gap="10">
              <For each={{ org <- [:vu, :uva, :surf, :uu] }}>
                <Collaborator org={{ org }} />
              </For>
            </AbsoluteGrid>
          </div>
        </div>
      </ContentArea>
    """
  end
end
