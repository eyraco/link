defmodule Core.Studies do
  @moduledoc """
  The Studies context.
  """

  import Ecto.Query, warn: false
  alias GreenLight.Principal
  alias Core.Repo
  alias Core.Authorization

  alias Core.Studies.{Study, Author}
  alias Core.Accounts.User
  alias Core.Survey.{Tool, Task}
  alias Core.DataDonation
  alias Core.Promotions.Promotion

  # read list_studies(current_user, ...) do
  # end

  @doc """
  Returns the list of studies.

  ## Examples

      iex> list_studies()
      [%Study{}, ...]

  """
  def list_studies(opts \\ []) do
    exclude = Keyword.get(opts, :exclude, []) |> Enum.to_list()

    from(s in Study,
      where: s.id not in ^exclude
    )
    |> Repo.all()

    # AUTH: Can be piped through auth filter.
  end

  def list_studies_with_published_promotion(tool_entity, opts \\ []) do
    preload = Keyword.get(opts, :preload, [])
    exclude = Keyword.get(opts, :exclude, []) |> Enum.to_list()

    promotions =
      from(promotion in Promotion, where: not is_nil(promotion.published_at), select: promotion.id)

    studies =
      from(tool in tool_entity,
        where: tool.promotion_id in subquery(promotions),
        select: tool.study_id
      )

    from(study in Study,
      where: study.id in subquery(studies) and study.id not in ^exclude,
      preload: ^preload
    )
    |> Repo.all()
  end

  @doc """
  Returns the list of studies that are owned by the user.
  """
  def list_owned_studies(user, opts \\ []) do
    preload = Keyword.get(opts, :preload, [])

    node_ids =
      Authorization.query_node_ids(
        role: :owner,
        principal: user
      )

    from(s in Study,
      where: s.auth_node_id in subquery(node_ids),
      preload: ^preload
    )
    |> Repo.all()

    # AUTH: Can be piped through auth filter (current code does the same thing).
  end

  @doc """
  Returns the list of studies where the user is a subject.
  """
  def list_subject_studies(user, opts \\ []) do
    preload = Keyword.get(opts, :preload, [])

    tool_ids = from(stt in Task, where: stt.user_id == ^user.id, select: stt.tool_id)

    study_ids = from(st in Tool, where: st.id in subquery(tool_ids), select: st.study_id)

    from(s in Study,
      where: s.id in subquery(study_ids),
      preload: ^preload
    )
    |> Repo.all()
  end

  @doc """
  Returns the list of studies where the user is a data donation subject.
  """
  def list_data_donation_subject_studies(user, opts \\ []) do
    preload = Keyword.get(opts, :preload, [])

    tool_ids =
      from(task in DataDonation.Task,
        where: task.user_id == ^user.id,
        select: task.tool_id
      )

    study_ids =
      from(st in DataDonation.Tool, where: st.id in subquery(tool_ids), select: st.study_id)

    from(s in Study,
      where: s.id in subquery(study_ids),
      preload: ^preload
    )
    |> Repo.all()
  end

  def list_owners(%Study{} = study) do
    owner_ids =
      study
      |> Authorization.list_principals()
      |> Enum.filter(fn %{roles: roles} -> MapSet.member?(roles, :owner) end)
      |> Enum.map(fn %{id: id} -> id end)

    from(u in User, where: u.id in ^owner_ids, order_by: u.id) |> Repo.all()
    # AUTH: needs to be marked save. Current user is normally not allowed to
    # access other users.
  end

  def assign_owners(study, users) do
    existing_owner_ids =
      Authorization.list_principals(study.auth_node_id)
      |> Enum.filter(fn %{roles: roles} -> MapSet.member?(roles, :owner) end)
      |> Enum.map(fn %{id: id} -> id end)
      |> Enum.into(MapSet.new())

    users
    |> Enum.filter(fn principal ->
      not MapSet.member?(existing_owner_ids, Principal.id(principal))
    end)
    |> Enum.each(&Authorization.assign_role(&1, study, :owner))

    new_owner_ids =
      users
      |> Enum.map(&Principal.id/1)
      |> Enum.into(MapSet.new())

    existing_owner_ids
    |> Enum.filter(fn id -> not MapSet.member?(new_owner_ids, id) end)
    |> Enum.each(&Authorization.remove_role!(%User{id: &1}, study, :owner))

    # AUTH: Does not modify entities, only auth. This needs checks to see if
    # the user is allowed to manage permissions? Could be implemented as part
    # of the authorization functions?
  end

  def add_owner!(study, user) do
    :ok = Authorization.assign_role(user, study, :owner)
  end

  @doc """
  Gets a single study.

  Raises `Ecto.NoResultsError` if the Study does not exist.

  ## Examples

      iex> get_study!(123)
      %Study{}

      iex> get_study!(456)
      ** (Ecto.NoResultsError)

  """
  def get_study!(id) do
    Repo.get!(Study, id)
  end

  def get_study_changeset(attrs \\ %{}) do
    %Study{}
    |> Study.changeset(attrs)
  end

  @doc """
  Creates a study.
  """
  def create_study(%Ecto.Changeset{} = changeset, researcher) do
    with {:ok, study} <-
           changeset
           |> Ecto.Changeset.put_assoc(:auth_node, Core.Authorization.make_node())
           |> Repo.insert() do
      :ok = Authorization.assign_role(researcher, study, :owner)
      {:ok, study}
    end
  end

  def create_study(attrs, researcher) do
    attrs
    |> get_study_changeset()
    |> create_study(researcher)
  end

  @doc """
  Updates a study.

  ## Examples

      iex> update_study(study, %{field: new_value})
      {:ok, %Study{}}

      iex> update_study(study, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_study(%Ecto.Changeset{} = changeset) do
    changeset
    |> Repo.update()
  end

  def update_study(%Study{} = study, attrs) do
    study
    |> Study.changeset(attrs)
    |> update_study
  end

  @doc """
  Deletes a study.

  ## Examples

      iex> delete_study(study)
      {:ok, %Study{}}

      iex> delete_study(study)
      {:error, %Ecto.Changeset{}}

  """
  def delete_study(%Study{} = study) do
    Repo.delete(study)
    # AUTH; how to check this.
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking study changes.

  ## Examples

      iex> change_study(study)
      %Ecto.Changeset{data: %Study{}}

  """
  def change_study(%Study{} = study, attrs \\ %{}) do
    Study.changeset(study, attrs)
  end

  def add_author(%Study{} = study, %User{} = researcher) do
    researcher
    |> Author.from_user()
    |> Author.changeset()
    |> Ecto.Changeset.put_assoc(:study, study)
    |> Ecto.Changeset.put_assoc(:user, researcher)
    |> Repo.insert()
  end

  def list_authors(%Study{} = study) do
    from(
      a in Author,
      where: a.study_id == ^study.id,
      preload: [user: [:profile]]
    )
    |> Repo.all()
  end

  def list_survey_tools(%Study{} = study) do
    from(s in Tool, where: s.study_id == ^study.id)
    |> Repo.all()
  end

  def list_tools(%Study{} = study, schema) do
    from(s in schema, where: s.study_id == ^study.id)
    |> Repo.all()
  end
end
