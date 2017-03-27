defmodule Hora do
  @type opts :: map | list

  @doc false
  def init(opts) do
    [
      adapter: Hora.Util.get_config!(Hora, :adapter, opts),
      adapter_options: Hora.Util.get_config(Hora, :adapter_options, opts) || []
    ]
  end

  defmacro __using__(opts) do
    options = Hora.init(opts)

    quote do
      def authenticate(secured_password, password) do
        adapter = unquote(options)[:adapter]
        adapter_options = unquote(options)[:adapter_options]

        adapter
          .verify_password(password, secured_password, adapter.init(adapter_options))
      end

      def secure_password(password) do
        adapter = unquote(options)[:adapter]
        adapter_options = unquote(options)[:adapter_options]

        adapter
          .secure_password(password, adapter.init(adapter_options))
      end
    end
  end
end
