defmodule Core.APNS.SignalHandlers do
  use Core.Signals.Handlers
  use Bamboo.Phoenix, view: Core.Mailer.EmailView
  import Core.APNS, only: [send_notification: 2]

  @impl true
  def dispatch(:new_notification, %{box: box, data: %{title: title}}) do
    for user <- Core.Authorization.users_with_role(box, :owner) do
      send_notification(user, title)
    end
  end
end
