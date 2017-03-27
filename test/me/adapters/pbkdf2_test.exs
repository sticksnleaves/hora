defmodule Me.Adapter.Pbkdf2Test do
  use ExUnit.Case

  describe "secure_password/2" do
    test "hashes the password using pbkdf2" do
      opts = Me.Adapter.Pbkdf2.init([])

      assert Regex.match?(~r/^\$pbkdf2-sha512\$\d{6}\$.{109}$/, Me.Adapter.Pbkdf2.secure_password("test", opts))
    end
  end

  describe "verify_password/3" do
    test "checks that the password is valid using pbkdf2" do
      opts = Me.Adapter.Pbkdf2.init([])
      hash = Comeonin.Pbkdf2.hashpwsalt("test")

      assert Me.Adapter.Pbkdf2.verify_password("test", hash, opts) == true
    end
  end
end
