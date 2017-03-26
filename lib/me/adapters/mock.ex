defmodule Me.Adapter.Mock do
  @behaviour Me.Adapter

  def init(opts), do: opts

  def verify_password(_password, _secured_password, _opts) do
    true
  end

  def secure_password(_password, _opts) do
    "MOCKPASSWORD"
  end
end
