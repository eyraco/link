defmodule Core.NotificationCenterTest do
  use Core.DataCase
  alias Core.Factories
  alias Core.NotificationCenter
  doctest NotificationCenter

  setup do
    %{user: Factories.insert!(:member)}
  end

  @notification %{
    title: "Test"
  }

  describe "notify/2" do
    test "notify user", %{user: user} do
      assert NotificationCenter.notify(user, @notification) == :ok
    end

    test "notify accepts keyword argument", %{user: user} do
      assert NotificationCenter.notify(user, title: "Nice") == :ok
    end

    test "sends message to multiple users", %{user: user} do
      another_user = Factories.insert!(:member)

      {:ok, _} = NotificationCenter.notify([user, another_user], %{title: "Testing"})

      assert NotificationCenter.list(user) |> Enum.map(& &1.title) == ["Testing"]
      assert NotificationCenter.list(another_user) |> Enum.map(& &1.title) == ["Testing"]
    end
  end

  describe "list/1" do
    test "an empty list is returned when there are no notifications", %{user: user} do
      assert NotificationCenter.list(user) == []
    end

    test "a list of notifications is returned when they have been notifyed", %{user: user} do
      :ok = NotificationCenter.notify(user, @notification)

      assert NotificationCenter.list(user) |> Enum.map(& &1.title) == ["Test"]
    end

    test "notifications are listed in reverse chronological order", %{user: user} do
      expected =
        for i <- 1..5 do
          title = "N#{i}"

          :ok =
            NotificationCenter.notify(
              user,
              Map.merge(@notification, %{title: title})
            )

          title
        end
        |> Enum.reverse()

      assert NotificationCenter.list(user) |> Enum.map(& &1.title) == expected
    end

    test "list notifications only matching the user they belong to" do
      users = 1..3 |> Enum.map(fn _ -> Factories.insert!(:member) end)

      titles =
        users
        |> Enum.map(fn user ->
          title = user.id |> Integer.to_string()
          :ok = NotificationCenter.notify(user, Map.put(@notification, :title, title))
          title
        end)

      :ok =
        Enum.zip(titles, users)
        |> Enum.each(fn {title, user} ->
          assert NotificationCenter.list(user) |> Enum.map(& &1.title) == [title]
        end)
    end

    test "archived notifications are no longer listed", %{user: user} do
      :ok = NotificationCenter.notify(user, @notification)
      [%{id: id}] = NotificationCenter.list(user)
      {:ok, _} = id |> NotificationCenter.get() |> NotificationCenter.mark(:archived)

      assert NotificationCenter.list(user) == []
    end
  end

  describe "get/2" do
    test "fetch a single notification", %{user: user} do
      :ok = NotificationCenter.notify(user, @notification)
      [%{id: notification_id}] = NotificationCenter.list(user)
      assert NotificationCenter.get(notification_id).title == @notification.title
    end
  end

  describe "mark/2" do
    setup %{user: user} do
      :ok = NotificationCenter.notify(user, @notification)
      [%{id: notification_id}] = NotificationCenter.list(user)
      %{notification: NotificationCenter.get(notification_id)}
    end

    test "mark a notification as read changes it's status", %{notification: notification} do
      {:ok, _} = NotificationCenter.mark(notification, :read)
      assert NotificationCenter.get(notification.id).status == :read
    end

    test "mark a notification as archived changes it's status", %{notification: notification} do
      {:ok, _} = NotificationCenter.mark(notification, :archived)
      assert NotificationCenter.get(notification.id).status == :archived
    end
  end

  describe "notify_users_with_role/3" do
    test "sends message to users with matching role", %{user: user} do
      box = NotificationCenter.get_or_create_box(user)

      {:ok, _} = NotificationCenter.notify_users_with_role(box, :owner, %{title: "Testing"})

      assert NotificationCenter.list(user) |> Enum.map(& &1.title) == ["Testing"]
    end
  end
end
