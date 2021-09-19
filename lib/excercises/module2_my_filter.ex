defmodule Module2MyFilter do

  def filter([], _), do: {:error, "List is empty" }
  def filter(list, fun) when is_list(list) and is_function(fun) do
    res = int_filter(list, fun, [])
    {:ok, res}
  end
  def filter(_, _), do: {:error, "Bad arguments" }

  defp int_filter([],  _fun, res), do: res
  defp int_filter([h|t], fun, res) do
    fun.(h)
          |> int_filter(t, fun, res, h)
  end

  defp int_filter(true, list, fun, res, val), do: int_filter(list, fun, res ++ [val])
  defp int_filter(false, list, fun, res, _val), do: int_filter(list, fun, res)

end
