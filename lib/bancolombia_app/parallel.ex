defmodule BancolombiaApp.Parallel do

  def pmap(list, fun) do
    list
    |> Enum.map(fun)
  end

  def spawn_prcess_my_collection(e, parent, fun) do
    spawn_link(fn -> send parent, {self(), fun.(e)} end)
  end

end
