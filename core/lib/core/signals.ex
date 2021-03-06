defmodule Core.Signals do
  @signal_handlers [
    Core.NotificationCenter.SignalHandlers,
    Core.Mailer.SignalHandlers,
    Core.WebPush.SignalHandlers,
    Core.APNS.SignalHandlers
  ]

  def dispatch(signal, message) do
    for handler <- @signal_handlers do
      handler.dispatch(signal, message)
    end

    :ok
  end

  def dispatch!(signal, message) do
    :ok = dispatch(signal, message)
  end

  def multi_dispatch(multi, signal, message) do
    Ecto.Multi.run(multi, :dispatch_signal, fn _, _ ->
      :ok = dispatch(signal, message)
      {:ok, nil}
    end)
  end
end
