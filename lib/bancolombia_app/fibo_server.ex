defmodule BancolombiaApp.FiboServer do

  def start() do
    # parent = self()
    # IO.inspect(parent)
    spawn(__MODULE__, :loop, [self()])
  end

  def loop(parent) do
      receive do
        {:compute, n} ->
          IO.inspect(parent)
          send(parent, {:ok, BancolombiaApp.Fibonacci.sequence(n)})
          loop(parent)

        :kill -> send(parent, {:ok, :killed})

        _ ->
          send(self(), {:error, :invalud})
          loop(parent)
      end
  end

end
