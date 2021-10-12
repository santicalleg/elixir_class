defmodule BancolombiaApp.Factorial do

  def of(0), do: 1
  def of(n), do: n * of(n - 1)

  def handle_message(:show, parent, state) do
    send(parent, {:ok, state})
    {:ok, state}
  end

  def handle_message({:compute, n}, parent, state) do
    send(parent, {:ok, of(n)})
    {:ok, state + 1}
  end

  def handle_message(_value, parent, state) do
    send(parent, {:error, :invalid})
    {:ok, state + 1}
  end

end
