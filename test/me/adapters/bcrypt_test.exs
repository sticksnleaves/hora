defmodule Hora.Adapter.BcryptTest do
  use ExUnit.Case

  describe "init/1" do
    test ":log_rounds uses default value of Comeonin.Config.bcrypt_log_rounds" do
      assert Hora.Adapter.Bcrypt.init([])[:log_rounds] == Comeonin.Config.bcrypt_log_rounds()
    end

    test ":log_rounds uses value specified" do
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
      hash = Comeonin.Bcrypt.hashpwsalt("test")

      assert Hora.Adapter.Bcrypt.verify_password("test", hash, opts) == true
    end
  end
end
