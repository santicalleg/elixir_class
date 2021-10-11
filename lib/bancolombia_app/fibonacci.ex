defmodule BancolombiaApp.Fibonacci do

  def sequence(0), do: 0
  def sequence(1), do: 1
  def sequence(n) do
    sequence(n-1) + sequence(n-2)
  end

  def handle_message(:show, parent, state) do
    send(parent, {:ok, state})
    {:ok, state}
  end

  def handle_message({:compute, n}, parent, state) do
    result = sequence(n)
    send(parent, {:ok, result})
    {:ok, [result | state]}
  end

  ##este ya no se utiliza porque desde el genericserver es donde se termina el proceso
  # def handle_message(:kill, parent) do
  #   send(parent, {:ok, :killed})
  # end
  def handle_message(_, parent, state) do
    send(parent, {:error, :invalid})
    {:ok, state}
  end

end
