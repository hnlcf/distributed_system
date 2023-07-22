defmodule MapReduce do
  @moduledoc """
  Documentation for `MapReduce`.
  """

  def map(s) do
    s
    |> String.split([" ", "\n", "\t", ","])
    |> Enum.filter(fn w -> String.length(w) != 0 end)
    |> Enum.map(fn w -> {w, 1} end)
  end

  def reduce(list) do
    list
    |> get_keys()
    |> Enum.map(fn k -> reduce_by_key(k, list) end)
  end

  defp get_keys(list) do
    list
    |> Enum.map(fn {k, _v} -> k end)
    |> Enum.sort()
    |> Enum.dedup()
  end

  defp reduce_by_key(key, list) do
    sum =
      list
      |> Enum.filter(fn {k, _v} -> k == key end)
      |> List.foldl(0, fn {_k, v}, acc -> acc + v end)

    {key, sum}
  end
end
