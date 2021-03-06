defmodule BancolombiaApp.AdventOfCode do
  def get_floor(instructions) do
    instructions
    |> String.split("")
    |> Enum.map(&eval/1)
    |> Enum.sum()
  end

  defp eval("("), do: 1
  defp eval(")"), do: -1
  defp eval(_), do: 0

  #fn "(" -> 1, ")" -> -1, _ -> 0 end
end
