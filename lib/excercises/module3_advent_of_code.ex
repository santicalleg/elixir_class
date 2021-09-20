defmodule Elves do

  @doc """
  Example input: 13x17x8 2x25x24 19x21x3 28x8x14 6x29x28
  """
  def total_wrapper_paper(instructions) do
    instructions
    |> String.split(" ")
    |> square_feet(0)
  end

  defp square_feet([], accum), do: {:ok, accum}
  defp square_feet([head | tail], accum) do
    [l, w, h] = head
                |> String.split("x")

    sum = square_feet(get_integer(l), get_integer(w), get_integer(h))
    square_feet(tail, sum + accum)

  end
  defp square_feet(_list, _accum), do: {:error, :invalid}

  defp square_feet(l, w, h) when is_number(l) and l > 0 and is_number(w) and w > 0 and is_number(h) and h > 0 do
    list = [%{a: l*w, s: 2*l*w}] ++ [%{a: w*h, s: 2*w*h}] ++ [%{a: h*l, s: 2*h*l}]
    get_sum(list) + get_smallest(list)
  end

  defp get_sum(list) do
    get_sum(list, 0)
  end
  defp get_sum([], res), do: res
  defp get_sum([h | t], res) do
    get_sum(t, res + h.s)
  end

  defp get_smallest(list) do
    get_smallest(list, 0)
  end

  defp get_smallest([], res), do: res
  defp get_smallest([h | t], res) when res == 0, do: get_smallest(t, h.a)
  defp get_smallest([h | t], res) when h.a <= res, do: get_smallest(t, h.a)
  defp get_smallest([h | t], res) when h.a > res, do: get_smallest(t, res)

  defp get_integer(val) do
    {res, ""} = Integer.parse(val)
    res
  end

end
