defmodule BancolombiaApp.FibonacciGenServer do
  use GenServer

  def init(args) do
    {:ok, args}
  end

  ## En este caso si se adicionó un nombre debido que solo se require 1 solo FibonacciServer
  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def compute(n) do
    GenServer.call(__MODULE__, {:compute, n})
  end

  def handle_call({:compute, n}, _from, state) do
    {:reply, BancolombiaApp.Fibonacci.sequence(n), state}
  end
end
