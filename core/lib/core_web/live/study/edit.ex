defmodule CoreWeb.Study.Edit do
  @moduledoc """
  The study page for owners.
  """
  use CoreWeb, :live_view
  use CoreWeb.FileUploader
  use EyraUI.AutoSave, :study_edit

  alias EyraUI.Form.{
    Form,
    TextInput,
    UrlInput,
    NumberInput,
    TextArea,
    Checkbox,
    RadioButtonGroup,
    PhotoInput
  }

  alias EyraUI.Hero.HeroSmall
  alias EyraUI.Container.{ContentArea, Bar, BarItem}
  alias EyraUI.Text.{Title1, Title3, Title6, SubHead, BodyMedium}
  alias EyraUI.Button.{PrimaryLiveViewButton, SecondaryLiveViewButton, SecondaryAlpineButton}
  alias EyraUI.Status.{Info, Warning}
  alias EyraUI.{Spacing, Line}
  alias EyraUI.Case.{Case, True, False}
  alias EyraUI.Panel.Panel
  alias EyraUI.Selectors.LabelSelector
  alias EyraUI.ImagePreview
  alias CoreWeb.ImageCatalogPicker

  alias Core.Accounts
  alias Core.Studies
  alias Core.Studies.{Study, StudyEdit}
  alias Core.SurveyTools
  alias Core.Marks

  import CoreWeb.Gettext

  data(uri_origin, :string)

  @impl true
  def init(_params, _session, socket) do
    socket
    |> init_file_uploader(:photo)
  end

  @impl true
  def load(%{"id" => id}, _session, _socket) do
    study = Studies.get_study!(id)
    [author | _] = Studies.list_authors(study)
    profile = Accounts.get_profile(author.user)
    study_survey = study |> load_survey_tool()
    StudyEdit.create(study, study_survey, author.user, profile)
  end

  def load_survey_tool(%Study{} = study) do
    case study |> Studies.list_survey_tools() do
      [survey_tool] -> survey_tool
      [survey_tool | _] -> survey_tool
      _ -> raise "Expected at least one survey tool for study #{study.title}"
    end
  end

  @impl true
  defdelegate get_changeset(study_edit, type, attrs \\ %{}), to: StudyEdit, as: :changeset

  @impl true
  def save(changeset) do
    if changeset.valid? do
      study_edit = save_valid(changeset)
      {:ok, study_edit}
    else
      changeset = %{changeset | action: :save}
      {:error, changeset}
    end
  end

  @impl true
  def save_file(socket, uploaded_file) do
    attrs = %{banner_photo_url: uploaded_file}
    study_edit = socket.assigns[:study_edit]
    changeset = get_changeset(study_edit, :auto_save, attrs)
    update_changeset(socket, changeset)
  end

  defp save_valid(changeset) do
    study_edit = Ecto.Changeset.apply_changes(changeset)
    study_attrs = StudyEdit.to_study(study_edit)
    survey_tool_attrs = StudyEdit.to_survey_tool(study_edit)

    study = Studies.get_study!(study_edit.study_id)

    {:ok, survey_tool} =
      study
      |> load_survey_tool()
      |> SurveyTools.update_survey_tool(survey_tool_attrs)

    {:ok, study} =
      study
      |> Studies.update_study(study_attrs)

    [author | _] = Studies.list_authors(study)
    profile = Accounts.get_profile(author.user)

    StudyEdit.create(study, survey_tool, author.user, profile)
  end

  @impl true
  def get_authorization_context(%{"id" => id}, _session, _socket) do
    Studies.get_study!(id)
  end

  @impl true
  def handle_params(_unsigned_params, uri, socket) do
    parsed_uri = URI.parse(uri)
    uri_origin = "#{parsed_uri.scheme}://#{parsed_uri.authority}"
    {:noreply, assign(socket, uri_origin: uri_origin)}
  end

  def handle_event("delete", _params, %{assigns: %{study_edit: study_edit}} = socket) do
    Studies.get_study!(study_edit.study_id)
    |> Studies.delete_study()

    {:noreply, push_redirect(socket, to: Routes.live_path(socket, CoreWeb.Dashboard))}
  end

  def handle_event("publish", _params, %{assigns: %{study_edit: study_edit}} = socket) do
    attrs = %{published_at: NaiveDateTime.utc_now()}
    changeset = get_changeset(study_edit, :submit, attrs)
    {:noreply, socket |> update_changeset(changeset)}
  end

  def handle_event("unpublish", _params, %{assigns: %{study_edit: study_edit}} = socket) do
    attrs = %{published_at: nil}
    changeset = get_changeset(study_edit, :auto_save, attrs)
    {:noreply, socket |> update_changeset(changeset)}
  end

  def handle_info({:theme_selector, themes}, %{assigns: %{study_edit: study_edit}} = socket) do
    attrs = %{themes: themes}
    changeset = get_changeset(study_edit, :auto_save, attrs)
    {:noreply, socket |> update_changeset(changeset)}
  end

  def handle_info({:image_picker, image_id}, %{assigns: %{study_edit: study_edit}} = socket) do
    attrs = %{image_id: image_id}
    changeset = get_changeset(study_edit, :auto_save, attrs)
    {:noreply, socket |> update_changeset(changeset)}
  end

  def update_changeset(socket, changeset) do
    case Ecto.Changeset.apply_action(changeset, :update) do
      {:ok, _study_edit} ->
        handle_success(socket, changeset)

      {:error, %Ecto.Changeset{} = changeset} ->
        handle_validation_error(socket, changeset)
    end
  end

  def handle_validation_error(socket, changeset) do
    socket
    |> assign(changeset: changeset)
    |> put_flash(:error, dgettext("eyra-study", "Please correct the indicated errors."))
  end

  def handle_success(socket, changeset) do
    study_edit = save_valid(changeset)

    socket
    |> assign(
      study_edit: study_edit,
      changeset: changeset,
      save_changeset: changeset
    )
    |> put_flash(:info, dgettext("eyra-study", "Saved"))
    |> AutoSave.schedule_hide_message()
  end

  def render(assigns) do
    ~H"""
      <div x-data="{ open: false }">
        <div class="fixed z-20 left-0 top-0 w-full h-full" x-show="open">
          <div class="flex flex-row items-center justify-center w-full h-full">
            <div class="w-5/6 md:w-popup-md lg:w-popup-lg" @click.away="open = false, $parent.overlay = false">
              <ImageCatalogPicker conn={{@socket}} static_path={{&Routes.static_path/2}} initial_query={{@study_edit.initial_image_query}} id={{:image_picker}} image_catalog={{Core.ImageCatalog.Unsplash}} />
            </div>
          </div>
        </div>
      <HeroSmall title={{ dgettext("eyra-study", "study.edit.title") }} />
        <ContentArea>
          <If condition={{ @study_edit.is_published }} >
            <Title3>{{dgettext("eyra-survey", "status.title")}}</Title3>
            <Title6>{{dgettext("eyra-survey", "completed.label")}}: <span class="text-success"> {{@study_edit.subject_completed_count}}</span></Title6>
            <Title6>{{dgettext("eyra-survey", "pending.label")}}: <span class="text-warning"> {{@study_edit.subject_pending_count}}</span></Title6>
            <Title6>{{dgettext("eyra-survey", "vacant.label")}}: <span class="text-delete"> {{@study_edit.subject_vacant_count}}</span></Title6>
            <Spacing value="XL" />
            <Line />
            <Spacing value="M" />
          </If>

          <Bar>
            <BarItem>
              <Case value={{@study_edit.is_published }} >
                <True>
                  <Info text={{dgettext("eyra-survey", "published.true.label")}} />
                </True>
                <False>
                  <Warning text={{dgettext("eyra-survey", "published.false.label")}} />
                </False>
              </Case>
            </BarItem>
            <BarItem>
              <SubHead>{{ @study_edit.byline }}</SubHead>
            </BarItem>
          </Bar>
          <Spacing value="L" />

          <Title1>{{ @study_edit.title }}</Title1>
          <Form id="main_form" changeset={{@changeset}} change_event="save" focus={{@focus}}>
            <TextInput field={{:title}} label_text={{dgettext("eyra-study", "title.label")}} />
            <TextInput field={{:subtitle}} label_text={{dgettext("eyra-survey", "subtitle.label")}} />

            <Spacing value="XL" />
            <Title3>{{dgettext("eyra-survey", "themes.title")}}</Title3>
            <BodyMedium>{{dgettext("eyra-survey", "themes.label")}}</BodyMedium>
            <Spacing value="XS" />
            <LabelSelector id={{:theme_selector}} labels={{ @study_edit.theme_labels }}/>
            <Spacing value="XL" />

            <Title3>{{dgettext("eyra-survey", "image.title")}}</Title3>
            <BodyMedium>{{dgettext("eyra-survey", "image.label")}}</BodyMedium>
            <Spacing value="XS" />
            <div class="flex flex-row">
              <ImagePreview image_url={{ @study_edit.image_url }} placeholder="" />
              <Spacing value="S" direction="l" />
              <div class="flex-wrap">
                <SecondaryAlpineButton click="$parent.open = true, $parent.$parent.overlay = true" label={{dgettext("eyra-survey", "search.different.image.button")}} />
              </div>
            </div>
            <Spacing value="XL" />

            <Title3>{{dgettext("eyra-survey", "organisation.title")}}</Title3>
            <RadioButtonGroup field={{:organization}} items={{ Marks.instances() }} checked={{ @study_edit.organization }}/>
            <Spacing value="XL" />

            <Title3>{{dgettext("eyra-survey", "about.title")}}</Title3>
            <TextArea field={{:expectations}} label_text={{dgettext("eyra-survey", "expectations.label")}}/>
            <TextArea field={{:description}} label_text={{dgettext("eyra-survey", "info.label")}}/>
            <Spacing value="XL" />

            <Title3>{{dgettext("eyra-survey", "duration.title")}}</Title3>
            <TextInput field={{:duration}} label_text={{dgettext("eyra-survey", "duration.label")}} />
            <Spacing value="XL" />

            <Title3>{{dgettext("eyra-survey", "reward.title")}}</Title3>
            <NumberInput field={{:reward_value}} label_text={{dgettext("eyra-survey", "reward.label")}} />
            <Spacing value="XL" />

            <Title3>{{dgettext("eyra-survey", "subjects.title")}}</Title3>
            <NumberInput field={{:subject_count}} label_text={{dgettext("eyra-survey", "config.nrofsubjects.label")}} />
            <Spacing value="XL" />


            <Spacing value="L" />
            <Title3>{{dgettext("eyra-survey", "config.devices.title")}}</Title3>
            <Checkbox field={{:phone_enabled}} label_text={{dgettext("eyra-survey", "phone.enabled.label")}}/>
            <Checkbox field={{:tablet_enabled}} label_text={{dgettext("eyra-survey", "tablet.enabled.label")}}/>
            <Checkbox field={{:desktop_enabled}} label_text={{dgettext("eyra-survey", "desktop.enabled.label")}}/>
            <Spacing value="XL" />

            <Title3>{{dgettext("eyra-survey", "banner.title")}}</Title3>

            <PhotoInput
              conn={{@socket}}
              static_path={{&Routes.static_path/2}}
              photo_url={{@study_edit.banner_photo_url}}
              uploads={{@uploads}}
              primary_button_text={{dgettext("eyra-survey", "choose.banner.photo.file")}}
              secondary_button_text={{dgettext("eyra-survey", "choose.other.banner.photo.file")}}
              />

            <Spacing value="S" />

            <TextInput field={{:banner_title}} label_text={{dgettext("eyra-survey", "banner.title.label")}} />
            <TextInput field={{:banner_subtitle}} label_text={{dgettext("eyra-survey", "banner.subtitle.label")}} />
            <UrlInput field={{:banner_url}} label_text={{dgettext("eyra-survey", "banner.url.label")}} />
            <Spacing value="XL" />

            <Panel bg_color="bg-grey1">
              <template slot="title">
                <Title3 color="text-white" >{{dgettext("eyra-survey", "config.title")}}</Title3>
              </template>
              <UrlInput field={{:survey_url}} label_color="text-white" label_text={{dgettext("eyra-survey", "config.url.label")}} background={{ :dark }}/>
              <Spacing value="M" />
              <Title6 color="text-white">Redirect url</Title6>
              <BodyMedium color="text-grey3">{{ @uri_origin <> CoreWeb.Router.Helpers.live_path(@socket, CoreWeb.Study.Complete, @study_edit.study_id)}}</BodyMedium>
            </Panel>
            <Spacing value="XL" />
          </Form>
          <Case value={{ @study_edit.is_published }} >
            <True> <!-- Published -->
              <SecondaryLiveViewButton label={{ dgettext("eyra-survey", "unpublish.button") }} event="unpublish" />
            </True>
            <False> <!-- Not published -->
              <Bar>
                <BarItem>
                  <PrimaryLiveViewButton label={{ dgettext("eyra-survey", "publish.button") }} event="publish" />
                </BarItem>
                <BarItem>
                  <SecondaryLiveViewButton label={{ dgettext("eyra-survey", "delete.button") }} event="delete" />
                </BarItem>
              </Bar>
            </False>
          </Case>

        </ContentArea>
      </div>
    """
  end
end