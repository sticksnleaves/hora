defmodule Hora.Adapter.Bcrypt do
  @moduledoc """
  Adapter for managing passwords using bcrypt.

  Note that you will need to add `comeonin` as a dependency to your project in
  order to use this adapter.

  ## Options

  * `log_rounds` -  the computational complexity of the generation of the
    password hash (default: value of `Comeonin.Config.bcrypt_log_rounds/0`)
  """

  @behaviour Hora.Adapter

  def init(opts) do
    verify_dep()

    opts
  end

  def secure_password(password, opts) do
    Bcrypt.hash_pwd_salt(password, opts)
  end

  def verify_password(password, secured_password, _opts) do
    Bcrypt.verify_pass(password, secured_password)
  end

  # private

  defp verify_dep do
    unless Code.ensure_loaded?(Bcrypt) do
      raise """
      You tried to use Hora.Adapter.Bcrypt, but the Bcrypt module is not loaded.
      Please add bcrypt_elixir to your dependencies.
      """
    end
  end
end
