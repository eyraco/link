defmodule CoreWeb.Home.Project do
  use CoreWeb, :live_view

  alias EyraUI.Container.{ContentArea}
  alias EyraUI.Hero.HeroImage
  alias EyraUI.Text.{Intro, BodyLarge, Title1, Title4, BodyMedium}
  alias EyraUI.Grid.AbsoluteGrid
  alias EyraUI.Spacing

  alias Core.Home.{Team, Teams}
  alias CoreWeb.Home.{TeamMember}

  data(project, :any)
  data(team_members, :any)

  def mount(%{"id" => id}, _session, socket) do
    project = Core.Home.Projects.entity(id)
    team_members =
      Teams.entity(id)
      |> Team.get_members()

    {:ok,
      socket
      |> assign(
        project: project,
        team_members: team_members
      )
    }
  end

  def render(assigns) do
    ~H"""
      <HeroImage
        title={{@project.name}}
        subtitle={{ "Project" }}
        image_url={{ "https://unsplash.com/photos/#{@project.image_id}/download?force=true" }}
      >
      </HeroImage>

      <ContentArea>
        <Intro>{{@project.intro}}</Intro>
        <BodyLarge>{{@project.description}}</BodyLarge>
        <Spacing value="XL" />
        <div class="bg-tertiary p-14 rounded-lg" >
          <AbsoluteGrid>
            <div>
              <Title4>Vision</Title4>
              <Spacing value="S" />
              <BodyMedium>{{@project.vision}}</BodyMedium>
            </div>
            <div>
              <Title4>Mission</Title4>
              <Spacing value="S" />
              <BodyMedium>{{@project.mission}}</BodyMedium>
            </div>
            <div>
              <Title4>Aim</Title4>
              <Spacing value="S" />
              <BodyMedium>{{@project.aim}}</BodyMedium>
            </div>
          </AbsoluteGrid>
        </div>
        <Spacing value="32" />
        <div>
          <Title1 align="text-center">In collaboration with</Title1>
          <AbsoluteGrid>
            <For each={{ member <- @team_members }}>
              <TeamMember conn={{@socket}} path_provider={{Routes}} member={{member}} />
            </For>
          </AbsoluteGrid>
        </div>
        <div>
          <Title1 align="text-center">Funded by</Title1>
        </div>
      </ContentArea>
    """
  end
end
