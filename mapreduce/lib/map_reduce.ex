defmodule MapReduce do
  @moduledoc """
  Documentation for `MapReduce`.
  """

  def run(path) do
    result =
      path
      |> File.read!()
      |> map()
      |> reduce()
      |> Enum.map(fn {k, v} -> "#{k} #{v}" end)
      |> Enum.join("\n")

    File.write!("example/output.txt", result)
  end

  def map(string) do
    string
    |> String.split([" ", ", ", "\t", "\n"], trim: true)
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
      |> Enum.map(fn {_k, v} -> v end)
      |> Enum.sum()

    {key, sum}
  end
end
