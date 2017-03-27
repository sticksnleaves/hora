defmodule HoraTest do
  use ExUnit.Case

  defmodule TestModule do
    use Hora, adapter: Hora.Adapter.Mock
  end

  describe "authenticate/2" do
    test "calls adapter" do
      assert TestModule.authenticate("a", "a") == true
    end
  end

  describe "secure_password/1" do
    test "calls adapter" do
      assert TestModule.secure_password("a") == "MOCKPASSWORD"
    end
  end
end
