# Hora

Assumption free, adapter based password management for Elixir.

## Installation

This package can be installed by adding `hora` to your list of dependencies in
`mix.exs`:

```elixir
def deps do
  [
    {:hora, "~> 1.0.0"},
    {:comeonin, "~> 3.0"}, # optional, needed for bcrypt and pbkdf2_sha512 support
    {:ecto, "~> 2.1"} # optional, needed for changeset support
  ]
end
```

## Adapters

Hora takes an adapter based strategy for defining the cryptographic functions
used to secure passwords. We provide support for bcrypt and pbkdf2_sha512 but
it's possible to use your own custom adapters as well.

* [`Hora.Adapter.Bcrypt`](https://hexdocs.pm/hora/Hora.Adapter.Bcrypt.html)
* [`Hora.Adapter.Pbkdf2`](https://hexdocs.pm/hora/Hora.Adapter.Pbkdf2.html)

## Usage

```elixir
iex> Hora.verify_password("uncrypted_password", "crypted_password")

iex> Hora.secure_password("uncrypted_password")
```

## Ecto

```elixir
defmodule MyModule do
  use Ecto.Schema

  schema "my_schema" do
    field :password,        :string, virtual: true
    field :password_digest, :string
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:password])
    |> Hora.Changeset.put_secure_password(:password, :password_digest)
  end
end
```

## Configuration

You can define which adapter to use and it's options in one of two ways:

1. Through application configuration

  **Example**

  ```elixir
  config :hora,
    adapter: Hora.Adapter.Bcrypt,
    adapter_options: [log_rounds: 14]
  ```
2. When using the Hora functions:

  **Example**

  ```elixir
  Hora.secure_password("uncrypted_password", adapter: Hora.Adapter.Bcrypt)
  ```

  ```elixir
  Hora.verify_password("uncrypted_password", "crypted_password", adapter: Hora.Adapter.Bcrypt)
  ```

  ```elixir
  Hora.Changeset.put_secure_password("uncrypted_password", adapter: Hora.Adapter.Bcrypt)
  ```
