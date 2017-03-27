defmodule Me.Adapter.BcryptTest do
  use ExUnit.Case

  describe "secure_password/2" do
    test "hashes the password using bcrypt" do
      opts = Me.Adapter.Bcrypt.init([])

      assert Regex.match?(~r/^\$2b\$.{56}$/, Me.Adapter.Bcrypt.secure_password("test", opts))
    end
  end

  describe "verify_password/3" do
    test "checks that the password is valid using bcrypt" do
      opts = Me.Adapter.Bcrypt.init([])
      hash = Comeonin.Bcrypt.hashpwsalt("test")

      assert Me.Adapter.Bcrypt.verify_password("test", hash, opts) == true
    end
  end
end
