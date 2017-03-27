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

Note that the configuration passed into the `Me` module will override values
provided in the application configuration.

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

## Ecto

Ecto isn't required to use Me. However, since this is probably the most common
use case we tried to make integration with Ecto easy.

Note that you will need to define `ecto` as a dependency in your project in
order to use `Me.Ecto`.

```elixir
defmodule MyModule do
  use Me.Ecto, adapter: Me.Adapter.Bcrypt
end
```

`Me.Ecto` will decorate your module with the same functions as `Me` with the
addition of `put_secure_password/1`.

### Configuration

All configuration options are the same as the `Me` module except for these
additions:

* `:password_field_name` - field in the schema to check for a changed value. The
  default value is `:password`.

Defining the configuration is similar to the `Me` module:

```elixir
config :me, Me.Ecto,
  adapter: Me.Adapter.Bcrypt,
  adapter_options: [log_rounds: 16],
  secure_password_field_name: :password_hash
```

or

```elixir
defmodule MyModule do
  use Me.Ecto, adapter: Me.Adapter.Bcrypt,
               adapter_options: [log_rounds: 16],
               :password_field_name: :pw,
               secure_password_field_name: :password_hash
end
```

### Functions

* `put_secure_password/1` - if the password has changed then generate a new
  secure password and add it as a change to the changeset; otherwise return the
  changeset without modification

  The field to check for change is defined using the configuration option
  `:password_field_name`.

  The field to put the generated password is defined as the configuration option
  `:secure_password_field_name`.
