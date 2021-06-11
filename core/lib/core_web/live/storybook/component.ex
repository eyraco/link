defmodule CoreWeb.Storybook.Component do

  defmacro __using__(_opts) do
    quote do
      import Surface, except: [sigil_H: 2]

      defmacrop sigil_H({:<<>>, meta, [string]} = ast, opts) do
        Module.put_attribute(__CALLER__.module, :code, string)

        quote do
          Surface.sigil_H(unquote(ast), unquote(opts))
        end
      end
    end
  end
end
