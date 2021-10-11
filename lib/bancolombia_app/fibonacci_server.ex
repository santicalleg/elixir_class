defmodule BancolombiaApp.FibonacciServer do

  # def start do
  #   spawn(FibonacciServer, :loop, [])
  #   # spawn(fn ->
  #   #   receive do
  #   #     {:compute, n} -> IO.puts(n)
  #   #    _ -> IO.puts("Error")
  #   #   end
  #   # end)
  # end

  # def loop do
  #   receive do
  #     {:compute, n} -> IO.puts(Fibonacci.sequence(n))
  #    _ -> IO.puts("Error")
  #   end

  #   loop()
  # end

  def start(parent) do
    spawn(__MODULE__, :loop, [parent])
    # spawn(fn ->
    #   receive do
    #     {:compute, n} -> IO.puts(n)
    #    _ -> IO.puts("Error")
    #   end
    # end)
  end

  def loop(parent) do
    receive do
      {:compute, n} ->
        send(parent, {:ok, BancolombiaApp.Fibonacci.sequence(n)})
        loop(parent)

      :kill -> send(parent, {:ok, :kille})

      _ ->
        send(parent, {:error, :invalid})
        loop(parent)
    end

  end

end
