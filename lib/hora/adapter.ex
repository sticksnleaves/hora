defmodule Hora.Adapter do
  @moduledoc """
  Specifies the API an adapter is required to implement.
  """

  @doc """
  Initializes the adapter.

  The options returned from this function will be given to `verify_password/3`
  and `secure_password/2`.
  """
  @callback init(Hora.opts) :: Hora.opts

  @doc """
  Secures the password. This will most likely be by either hashing or encrypting
  the password provided.
  """
  @callback secure_password(String.t, Hora.opts) :: String.t

  @doc """
  Verifies that the plain text password and the secure password match.
  """
  @callback verify_password(String.t, String.t, Hora.opts) :: boolean
end
