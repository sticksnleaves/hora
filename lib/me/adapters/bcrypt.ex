defmodule Me.Adapter.Bcrypt do
  @moduledoc """
  Adapter for managing passwords using bcrypt.

  ## Example

  ```
  defmodule MyModule do
    use Me, adapter: Me.Adapter.Bcrypt
  end
  ```
  """

  @behaviour Me.Adapter

  def init(opts) do
    verify_comeonin_dep()

    opts
  end

  def secure_password(password, _opts) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end

  def verify_password(password, secured_password, _opts) do
    Comeonin.Bcrypt.checkpw(password, secured_password)
  end

  # private

  defp verify_comeonin_dep do
    unless Code.ensure_loaded?(Comeonin) do
      raise """
      You tried to use Me.Adapter.Bcrypt, but the Comeonin module is not loaded.
      Please add comeonin to your dependencies.
      """
    end
  end
end
