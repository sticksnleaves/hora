defmodule Me.Adapter.Mock do
  @moduledoc """
  Mock adapter used for testing.
  """

  @behaviour Me.Adapter

  @doc false
  def init(opts), do: opts

  @doc false
  def verify_password(_password, _secured_password, _opts) do
    true
  end

  @doc false
  def secure_password(_password, _opts) do
    "MOCKPASSWORD"
  end
end
