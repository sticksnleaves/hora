defmodule Hora do
  def secure_password(password, opts \\ []) do
    adapter = adapter(opts)
    adapter_options = adapter_options(opts)

    adapter
      .secure_password(password, adapter.init(adapter_options))
  end

  def verify_password(password, crypted_password, opts \\ []) do
    adapter = adapter(opts)
    adapter_options = adapter_options(opts)

    adapter
      .verify_password(password, crypted_password, adapter.init(adapter_options))
  end

  # private

  defp adapter(opts) do
    opts[:adapter] || Application.get_env(:hora, :adapter)
  end

  defp adapter_options(opts) do
    opts[:adapter] || Application.get_env(:hora, :adapter_options)
  end
end
