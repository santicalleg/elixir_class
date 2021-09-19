defmodule Module2FizzBuzz do

  def fizz_buzz(n) when is_integer(n) and n > 0 do
    list = 1..n |> Enum.to_list()
    fizz_buzz(list, [])
  end
  def fizz_buzz(_), do: {:error, "Bad request"}

  defp fizz_buzz([], res), do: res
  defp fizz_buzz([h|t], res), do: fizz_buzz(t, res ++ [get_value(h)])

  defp get_value(n) when rem(n, 3) == 0 and rem(n, 5) == 0, do: :fizzbuzz
  defp get_value(n) when rem(n, 3) == 0, do: :fizz
  defp get_value(n) when rem(n, 5) == 0, do: :buzz
  defp get_value(n), do: n

end
