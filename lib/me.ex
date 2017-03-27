defmodule Me do
  @type opts :: map | list

  @doc false
  def init(opts) do
    [
      adapter: Me.Util.get_config!(Me, :adapter, opts),
      adapter_options: Me.Util.get_config(Me, :adapter_options, opts) || [],
      secure_password_field_name: Me.Util.get_config(Me, :secure_password_field_name, opts) || :password_digest
    ]
  end

  defmacro __using__(opts) do
    options = Me.init(opts)

    quote do
      def authenticate(%{} = schema, password) do
        secure_password_field_name = unquote(options)[:secure_password_field_name]
        secured_password = schema[secure_password_field_name]

        verify_password(secured_password, password)
      end

      def secure_password(password) do
        adapter = unquote(options)[:adapter]
        adapter_options = unquote(options)[:adapter_options]

        adapter
          .secure_password(password, adapter.init(adapter_options))
      end

      def verify_password(secured_password, password) do
        adapter = unquote(options)[:adapter]
        adapter_options = unquote(options)[:adapter_options]

        adapter
          .verify_password(password, secured_password, adapter.init(adapter_options))
      end
    end
  end
end
