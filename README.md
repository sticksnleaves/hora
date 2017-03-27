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

## Usage

```elixir
defmodule MyModule do
  use Hora, adapter: Hora.Adapter.Bcrypt
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
config :hora, Hora,
  adapter: Hora.Adapter.Bcrypt,
  adapter_options: [log_rounds: 16],
  secure_password_field_name: :password_hash
```

or when including `Hora`:

```elixir
defmodule MyModule do
  use Hora, adapter: Hora.Adapter.Bcrypt,
            adapter_options: [log_rounds: 16],
            secure_password_field_name: :password_hash
end
```

Note that the configuration passed into the `Hora` module will override values
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

Ecto isn't required to use Hora. However, since this is probably the most common
use case we tried to make integration with Ecto easy.

Note that you will need to define `ecto` as a dependency in your project in
order to use `Hora.Ecto`.

```elixir
defmodule MyModule do
  use Hora.Ecto, adapter: Hora.Adapter.Bcrypt

  schema "my_schema" do
    field :password, :string, virtual: true
    field :password_digest, :string
  end
end
```

`Hora.Ecto` will decorate your module with the same functions as `Hora` with the
addition of `put_secure_password/1`.

### Configuration

All configuration options are the same as the `Hora` module except for these
additions:

* `:password_field_name` - field in the schema to check for a changed value when
  generating a new secure password. The default value is `:password`.

Defining the configuration is similar to the `Hora` module:

```elixir
config :hora, Hora.Ecto,
  adapter: Hora.Adapter.Bcrypt,
  adapter_options: [log_rounds: 16],
  password_field_name: :pw,
  secure_password_field_name: :password_hash
```

or

```elixir
defmodule MyModule do
  use Hora.Ecto, adapter: Hora.Adapter.Bcrypt,
                 adapter_options: [log_rounds: 16],
                 password_field_name: :pw,
                 secure_password_field_name: :password_hash
end
```

### Functions

* `put_secure_password/1` - if the password has changed then generate a new
  secure password and add it as a change to the changeset; otherwise return the
  changeset without modification

  The field to check for change is defined using the configuration option
  `:password_field_name`.

  The field to put the generated secure password is defined as the configuration
  option `:secure_password_field_name`.

## Adapters

Note that both of the packaged adapter rely on Comeonin. In order to use these
adapter you will need to add `comeonin` as a dependency to your project.

### Hora.Adapter.Bcrypt

**Adapter Options**

* `:log_rounds` - the computational complexity of the generation of the
  password hash (default: value of `Comeonin.Config.bcrypt_log_rounds/0`)

### Hora.Adapter.Pbkdf2

**Adapter Options**

* `:rounds` - the number of calculations used to generate the hash
  (default: value of `Comeonin.Config.pbkdf2_rounds/0`)
* `:salt_length` - length of salt to generate (default: 16)
