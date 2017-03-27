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
  use Me

  defstruct [:password_digest]
end
```

This will decorate your module with the `authenticate/2`, `secure_password/1`
and `verify_password/2` functions.

### Functions

* `authenticate/2` - used to verify a password against a value stored in a map
  or struct. The map or struct field used to verify the password against is
  defined in the `:secure_password_field_name` config option. The default field
  is `:password_digest`.

  **Example**

  ```elixir
  $> MyModule.authenticate(MyModule, "some password")
  true or false
  ```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/me](https://hexdocs.pm/me).
