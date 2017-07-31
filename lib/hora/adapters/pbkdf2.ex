defmodule Hora.Adapter.Pbkdf2 do
  @moduledoc """
  Adapter for managing passwords using pbkdf2_sha512.

  Note that you will need to add `comeonin` as a dependency to your project in
  order to use this adapter.

  ## Options

  * `rounds` - the number of calculations used to generate the hash
    (default: value of `Comeonin.Config.pbkdf2_rounds/0`)
  * `salt_length` - length of salt to generate (default: 16)
  """

  @behaviour Hora.Adapter

  def init(opts) do
    verify_dep()

    opts
  end

  def secure_password(password, opts) do
    Pbkdf2.hash_pwd_salt(password, opts)
  end

  def verify_password(password, secured_password, _opts) do
    Pbkdf2.verify_pass(password, secured_password)
  end

  # private

  defp verify_dep do
    unless Code.ensure_loaded?(Pbkdf2) do
      raise """
      You tried to use Hora.Adapter.Pbkdf2, but the Comeonin module is not loaded.
      Please add comeonin to your dependencies.
      """
    end
  end
end
