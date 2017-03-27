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
    verify_comeonin_dep()

    [
      log_rounds: opts[:log_rounds] || Comeonin.Config.bcrypt_log_rounds()
    ]
  end

  def secure_password(password, opts) do
    salt = Comeonin.Bcrypt.gen_salt(opts[:log_rounds])

    Comeonin.Bcrypt.hashpass(password, salt)
  end

  def verify_password(password, secured_password, _opts) do
    Comeonin.Bcrypt.checkpw(password, secured_password)
  end

  # private

  defp verify_comeonin_dep do
    unless Code.ensure_loaded?(Comeonin) do
      raise """
      You tried to use Hora.Adapter.Bcrypt, but the Comeonin module is not loaded.
      Please add comeonin to your dependencies.
      """
    end
  end
end
