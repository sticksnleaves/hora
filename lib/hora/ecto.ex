defmodule Hora.Ecto do
  def init(opts) do
    options = [
      password_field_name: Hora.Util.get_config(Hora.Ecto, :password_field_name, opts) || :password
    ]

    Hora.init(opts) ++ options
  end

  defmacro __using__(opts) do
    verify_ecto_dep()

    options = Hora.Ecto.init(opts)

    quote do
      use Hora, unquote(options)

      def put_secure_password(changeset) do
        password_field_name = unquote(options)[:password_field_name]
        secure_password_field_name = unquote(options)[:secure_password_field_name]

        if password = Ecto.Changeset.get_change(changeset, password_field_name) do
          Ecto.Changeset.put_change(changeset, secure_password_field_name, secure_password(password))
        else
          changeset
        end
      end
    end
  end

  # private

  defp verify_ecto_dep do
    unless Code.ensure_loaded?(Ecto) do
      raise "You tried to use Hora.Ecto, but the Ecto module is not loaded. " <>
        "Please add ecto to your dependencies."
    end
  end
end
