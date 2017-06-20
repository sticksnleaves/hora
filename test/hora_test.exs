defmodule HoraTest do
  use ExUnit.Case

  describe "verify_password/3" do
    test "calls adapter" do
      assert Hora.verify_password("a", "a") == true
    end
  end

  describe "secure_password/2" do
    test "calls adapter" do
      assert Hora.secure_password("a") == "MOCKPASSWORD"
    end
  end
end
