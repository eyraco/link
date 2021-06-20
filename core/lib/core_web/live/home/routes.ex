defmodule CoreWeb.Live.Home.Routes do
  defmacro routes() do
    quote do
      scope "/", CoreWeb do
        pipe_through([:browser, :require_authenticated_user])

        live("/projects/:id", Home.Project)
      end
    end
  end
end
