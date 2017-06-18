defmodule Me.Mixfile do
  use Mix.Project

  @version "1.0.0"

  def project do
    [app: :hora,
     name: "Hora",
     description: "Extensible password management",
     version: @version,
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package(),
     preferred_cli_env: [
       "coveralls": :test,
       "coveralls.html": :test,
       "coveralls.travis": :test
     ],
     test_coverage: [tool: ExCoveralls]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:comeonin, "~> 3.0", optional: true},
      {:ecto, "~> 2.1", optional: true},
      # dev
      {:credo, "~> 0.7", only: :dev, runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev},
      # test
      {:excoveralls, "~> 0.7.0", only: :test, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Anthony Smith"],
      licenses: ["MIT"],
      links: %{
        GitHub: "https://github.com/sticksnleaves/hora"
      }
    ]
  end
end
