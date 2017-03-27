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
    verify_comeonin_dep()

    [
      rounds: opts[:rounds] || Comeonin.Config.pbkdf2_rounds(),
      salt_length: opts[:salt_length] || 16
    ]
  end

  def secure_password(password, opts) do
    salt = Comeonin.Pbkdf2.gen_salt(opts[:salt_length])

    Comeonin.Pbkdf2.hashpass(password, salt, opts[:rounds])
  end

  def verify_password(password, secured_password, _opts) do
    Comeonin.Pbkdf2.checkpw(password, secured_password)
  end

  # private

  defp verify_comeonin_dep do
    unless Code.ensure_loaded?(Comeonin) do
      raise """
      You tried to use Hora.Adapter.Pbkdf2, but the Comeonin module is not loaded.
      Please add comeonin to your dependencies.
      """
    end
  end
end
