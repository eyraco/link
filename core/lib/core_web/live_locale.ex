defmodule CoreWeb.Plug.LiveLocale do
  @moduledoc "A Plug that sets a session variable to the current locale."
  import Plug.Conn, only: [put_session: 3]

  def init(options) do
    options
  end

  def call(conn, _opts) do
    locale = Gettext.get_locale()
    put_session(conn, :locale, locale)
  end
end

defmodule CoreWeb.LiveLocale do
  @moduledoc "A LiveView helper that automatically sets the current locale from a session variable."

  defmacro __using__(_opts \\ nil) do
    quote do
      @before_compile CoreWeb.LiveLocale
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      defoverridable mount: 3

      def mount(params, %{"locale" => locale} = session, socket) do
        Gettext.put_locale(CoreWeb.Gettext, locale)
        Gettext.put_locale(EyraUI.Gettext, locale)
        Gettext.get_locale()
        super(params, session, socket)
      end
    end
  end
end
