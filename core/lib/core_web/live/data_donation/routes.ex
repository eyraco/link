defmodule CoreWeb.Live.DataDonation.Routes do
  defmacro routes() do
    quote do
      scope "/", CoreWeb do
        pipe_through([:browser, :require_authenticated_user])

        live("/data-donation/:id/content", DataDonation.Content)
        live("/data-donation/:id", DataDonation.Uploader)
      end
    end
  end
end