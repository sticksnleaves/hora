# Me

Assumption free, adapter based password management for Elixir.

## Installation

This package can be installed by adding `me` to your list of dependencies in
`mix.exs`:

```elixir
def deps do
  [{:me, "~> 0.1.0"}]
end
```

## Usage

This library doesn't make any assumptions on where you intend to use it. It's
easy to get started by just including `Me` in your module.

```elixir
defmodule MyModule do
  use Me, adapter: Me.Adapter.Bcrypt
end
```

This will decorate your module with the `authenticate/2`, `secure_password/1`
and `verify_password/2` functions.

### Configuration

* `:adapter` - behaviour used to secure or verify a password
* `:adapter_options` - options provided to the adapter when securing or
  verifying a password
* `:secure_password_field_name` - field in map or struct to check against when
  using `authenticate/2`

Configuration options can be provided as application configuration:

**Example**

```elixir
config :me, Me,
  adapter: Me.Adapter.Bcrypt,
  adapter_options: [log_rounds: 16],
  secure_password_field_name: :password_hash
```

or when including `Me`:

```elixir
defmodule MyModule do
  use Me, adapter: Me.Adapter.Bcrypt,
          adapter_options: [log_rounds: 16],
          secure_password_field_name: :password_hash
end
```

### Functions

* `authenticate/2` - verifies a password against a value stored in a map or
  struct. The map or struct field used to verify the password against is defined
  with the `:secure_password_field_name` config option. The default field is
  `:password_digest`.

  **Example**

  ```elixir
  iex> MyModule.authenticate(MyModule, "some password")
  # true or false
  ```
* `secure_password/1` - generates a secure password using the defined adapter

  **Example**

  ```elixir
  iex> MyModule.secure_password("some password")
  # the secure password returned by :adapter
  ```
* `verify_password/2` - verifies that a password and a secure string match using
  the defined adapter

  **Example**

  ```elixir
  iex> MyModule.verify_password("crypted password", "some password")
  # true or false
  ```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/me](https://hexdocs.pm/me).
