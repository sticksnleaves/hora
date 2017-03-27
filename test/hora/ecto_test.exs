defmodule Hora.EctoTest do
  use ExUnit.Case

  defmodule TestModule do
    use Ecto.Schema

    use Hora.Ecto, adapter: Hora.Adapter.Mock

    import Ecto.Changeset

    schema "some schema" do
      field :password, :string, virtual: true
      field :password_digest, :string
    end

    def changeset(schema, params) do
      schema
      |> cast(params, [:password])
      |> put_secure_password(:password, :password_digest)
    end
  end

  describe "put_secure_password/2" do
    test "adds secure password to changeset" do
      changeset = TestModule.changeset(%TestModule{}, %{password: "password"})

      assert Ecto.Changeset.get_change(changeset, :password_digest) == "MOCKPASSWORD"
    end
  end
end
