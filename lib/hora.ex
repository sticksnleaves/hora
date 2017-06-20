defmodule Hora do
  @doc """
  Processes the provided password using the configured adapter.

  ## Example

  ```elixir
  Hora.secure_password("this is my password")
  ```
  """
  @spec secure_password(binary(), list()) :: String.t
  def secure_password(password, opts \\ []) do
    adapter = adapter(opts)
    adapter_options = adapter_options(opts)

    adapter
      .secure_password(password, adapter.init(adapter_options))
  end

  @doc """
  Checks to see if the provided password matches the provided secure password.

  ## Example

  ```elixir
  Hora.verify_password("this is my password", "this is a secure password")
  ```
  """
  @spec verify_password(binary(), binary(), list()) :: boolean()
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
