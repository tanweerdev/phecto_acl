defmodule ExAcl.MixProject do
  use Mix.Project

  def project do
    [
      app: :acl,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {ExAcl, []},
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test"]
  defp elixirc_paths(_), do: ["lib"]
  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:core, in_umbrella: true}
      {:ecto, "~> 3.2"},
      {:ecto_sql, "~> 3.3"},
      {:plug, "~> 1.8.3"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      # {:sibling_app_in_umbrella, in_umbrella: true}
    ]
  end

  defp aliases do
    [
      "ecto.init": [],
      "ecto.create": ["ecto.create"],
      "ecto.migrate": ["ecto.migrate"],
      role_action_seeds: [],
      "ecto.setup.quite": ["ecto.create", "ecto.init", "ecto.migrate"],
      test: [
        "test"
      ]
    ]
  end
end
