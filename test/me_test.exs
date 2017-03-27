defmodule MeTest do
  use ExUnit.Case

  defmodule TestModule do
    use Me, adapter: Me.Adapter.Mock
  end

  describe "authenticate/2" do
    test "checks against the value in secure_password_field_name" do
      assert TestModule.authenticate(%{password_digest: "b"}, "b") == true
    end
  end

  describe "verify_password/2" do
    test "calls adapter" do
      assert TestModule.verify_password("a", "a") == true
    end
  end

  describe "secure_password/1" do
    test "calls adapter" do
      assert TestModule.secure_password("a") == "MOCKPASSWORD"
    end
  end
end
