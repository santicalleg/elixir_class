defmodule Module2AdventOfCode do
  def get_basement(instructions) do
    instructions
    |> String.split("", trim: true)
    |> Enum.map(&eval/1)
    |> Enum.scan(&(&1 + &2))
    |> Enum.find_index(&(&1 == -1))
    |> result()
  end

  defp eval("("), do: 1
  defp eval(")"), do: -1
  defp eval(_), do: 0

  defp result(nil), do: {:not_found}
  defp result(x), do: x + 1

end
