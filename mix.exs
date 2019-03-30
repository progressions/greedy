defmodule Greedy.MixProject do
  use Mix.Project

  def project do
    [
      app: :greedy,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ] ++ docs()
  end

  def docs do
    [
      name: "Greedy",
      source_url: "https://github.com/progressions/greedy",
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Greedy.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:kafka_ex, "~> 0.9.0"},
      {:avro_ex, "~> 0.1.0-beta.0"},
      {:ex_doc, "~> 0.19", [only: :dev, runtime: false]},
      {:gen_stage, "~> 0.14.1"},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
