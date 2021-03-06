defmodule CoreWeb.Notifications do
  use CoreWeb, :live_view
  alias Core.NotificationCenter

  data(notifications, :any)

  def mount(_params, _session, %{assigns: %{current_user: user}} = socket) do
    {:ok, socket |> assign(:notifications, NotificationCenter.list(user))}
  end

  def render(assigns) do
    ~H"""
    <div>
    Notifications
    <ul>
    <li :for={{ notification <- @notifications }}>
      {{ notification.title }}
    </li>
    </ul>
    </div>
    """
  end
end
