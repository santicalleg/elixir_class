defmodule BancolombiaApp.Greeting do

  def hello(), do: "#{phrase()} anon"
  def hello(name), do: "Hello " <> name
  def hello(name, lastname), do: "Hello #{name} Family #{lastname}"

  def phrase(), do: "What's up "

end
