defmodule Me.Util do
  @moduledoc false

  @doc """
  Get config value from either the provided `opts` or `Application` config. If
  no value is found `nil` will be returned.
  """
  def get_config(module, key, opts) do
    opts[key]
    || Application.get_env(:me, module)[key]
  end

  @doc """
  Get config value from either the provided `opts` or `Application` config. If
  not value is found an `ArgumentError` will be raised.
  """
  def get_config!(module, key, opts) do
    get_config(module, key, opts)
    || raise ArgumentError
  end
end
