defmodule Hora.EctoTest do
  use ExUnit.Case

  defmodule TestModule do
    use Ecto.Schema

    import Ecto.Changeset
    import Hora.Changeset

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

  describe "put_secure_password/3" do
    test "adds secure password to changeset" do
      changeset = TestModule.changeset(%TestModule{}, %{password: "password"})

      assert Ecto.Changeset.get_change(changeset, :password_digest) == "MOCKPASSWORD"
    end

    test "does nothing if password did not change" do
      changeset = TestModule.changeset(%TestModule{}, %{})

      assert Ecto.Changeset.get_change(changeset, :password_digest) == nil
    end
  end
end
