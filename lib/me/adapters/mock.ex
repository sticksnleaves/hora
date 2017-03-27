defmodule Me.Adapter.Mock do
  @moduledoc """
  Mock adapter used for testing.
  """

  @behaviour Me.Adapter

  @doc false
  def init(opts), do: opts

  @doc false
  def verify_password(password, secured_password, _opts) do
    password == secured_password
  end

  @doc false
  def secure_password(_password, _opts) do
    "MOCKPASSWORD"
  end
end
