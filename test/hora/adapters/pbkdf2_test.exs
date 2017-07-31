defmodule Hora.Adapter.Pbkdf2Test do
  use ExUnit.Case

  describe "secure_password/2" do
    test "hashes the password using pbkdf2" do
      opts = Hora.Adapter.Pbkdf2.init([])

      assert Regex.match?(~r/^\$pbkdf2-sha512\$\d{6}\$.{109}$/, Hora.Adapter.Pbkdf2.secure_password("test", opts))
    end
  end

  describe "verify_password/3" do
    test "checks that the password is valid using pbkdf2" do
      opts = Hora.Adapter.Pbkdf2.init([])
      hash = Pbkdf2.hash_pwd_salt("test")

      assert Hora.Adapter.Pbkdf2.verify_password("test", hash, opts) == true
    end
  end
end
