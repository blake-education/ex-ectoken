defmodule Ectoken.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ectoken,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      description: description(),
      package: package(),
    ]
  end

  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
    ]
  end

  defp description do
    "Elixir impl of https://github.com/VerizonDigital/ectoken, used in our DRM for books"
  end

  defp package do
    [
      # This option is only needed when you don't want to use the OTP application name
      # name: "postgrex",
      # These are the default files included in the package
      # files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
      organization: "blake_elearning",
      maintainers: ["Martin Stannard"],
      licenses: ["Blake"],
      links: %{"GitHub" => "https://github.com/blake-education/ex-ectoken"}
    ]
  end
end
