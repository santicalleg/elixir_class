defmodule Module1Exercises do

  #lenght
  def get_length(list) when is_list(list) do
    get_length(list, 0)
  end
  def get_length(_), do: {:bad_request, 0}

  defp get_length([], count), do: {:ok, count}
  defp get_length([_h | t], count) do
    get_length(t, count + 1)
  end

  #Greatest common divisor
  def mcd(a, b) when is_number(a) and is_number(b) and a > b do
    mcd_op(a, b)
  end
  def mcd(a, b) when is_number(a) and is_number(b) and b > a do
    mcd_op(b, a)
  end
  def mcd(_a, _b), do: {:bad_request}

  defp mcd_op(a, 0), do: {:ok, a}
  defp mcd_op(a, b), do: mcd_op(b, rem(a, b))

end
