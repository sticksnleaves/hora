# Hora

Assumption free, adapter based password management for Elixir.

## Installation

This package can be installed by adding `hora` to your list of dependencies in
`mix.exs`:

```elixir
def deps do
  [{:hora, "~> 0.1.0"}]
end
```

## Dependencies

When building Hora we tried our best not to make any assumptions on how it would
be used. However, we did want to make sure that we removed any friction when
using Hora for the most common use cases.

Therefore, if you want to take advantage of our Ecto and Comeonin integrations
you will need to include them as dependencies in your project.

## Usage

Hora takes an adapter based strategy for defining the cryptographic functions
used to secure passwords. We provide support for bcrypt and pbkdf2_sha512 but
it's possible to use your own custom adapters as well.

To get started you just need to configure which adapter to use and then include
`Hora` in your module.

```elixir
defmodule MyModule do
  use Hora, adapter: Hora.Adapter.Bcrypt

  defstruct [:password, :password_digest]
end

iex> MyModule.authenticate("crypted_password", "uncrypted_password")
# true or false

iex> MyModule.secure_password("uncrypted_password")
# crypted password
```

If you're using Ecto use `Hora.Ecto` instead.

```elixir
defmodule MyModule do
  use Hora.Ecto, adapter: Hora.Adapter.Bcrypt

  schema "my_schema" do
    field :password,        :string, virtual: true
    field :password_digest, :string
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:password])
    |> put_secure_password(:password, :password_digest)
  end
end

iex> MyModule.authenticate(my_module.password_digest, "uncrypted_password")
# true or false

iex> MyModule.secure_password("uncrypted_password")
# crypted password
```

## Configuration

You can define which adapter to use and it's options in one of two ways:

1. Through application configuration

  **Example**

  ```elixir
  config :hora, Hora,
    adapter: Hora.Adapter.Bcrypt,
    adapter_options: [log_rounds: 14]
  ```
2. When including `Hora` in your module

  **Example**

  ```elixir
  defmodule MyModule do
    use Hora, adapter: Hora.Adapter.Bcrypt,
              adapter_options: [log_rounds: 14]
  end
  ```

## Adapters

* [`Hora.Adapter.Bcrypt`](https://hexdocs.pm/hora/Hora.Adapter.Bcrypt.html)
* [`Hora.Adapter.Pbkdf2`](https://hexdocs.pm/hora/Hora.Adapter.Pbkdf2.html)
