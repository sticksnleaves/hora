defmodule Hora.Adapter.BcryptTest do
  use ExUnit.Case

  describe "init/1" do
    test "uses provided opts value" do
      assert Hora.Adapter.Bcrypt.init([log_rounds: 13])[:log_rounds] == 13
    end
  end

  describe "secure_password/2" do
    test "hashes the password using bcrypt" do
      opts = Hora.Adapter.Bcrypt.init([])

      assert Regex.match?(~r/^\$2b\$.{56}$/, Hora.Adapter.Bcrypt.secure_password("test", opts))
    end
  end

  describe "verify_password/3" do
    test "checks that the password is valid using bcrypt" do
      opts = Hora.Adapter.Bcrypt.init([])
      hash = Bcrypt.hash_pwd_salt("test")

      assert Hora.Adapter.Bcrypt.verify_password("test", hash, opts) == true
    end
  end
end
