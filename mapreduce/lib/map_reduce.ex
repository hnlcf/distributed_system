defmodule MapReduce do
  @moduledoc """
  Documentation for `MapReduce`.
  """

  defmodule Entry do
    defstruct word: "", num: 0
  end

  def run(path) do
    result =
      path
      |> File.read!()
      |> map()
      |> reduce()
      |> Enum.map(fn {k, v} -> "#{k} #{v}" end)
      |> Enum.join("\n")

    File.write("output.txt", result)
  end

  @doc """
  Split the input string `string` by word, return a list where each element is
  the `{word, 1}`.
  """
  def map(string) do
    string
    |> String.split([" ", "\n", "\t", ","], trim: true)
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
    |> Enum.uniq()
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
