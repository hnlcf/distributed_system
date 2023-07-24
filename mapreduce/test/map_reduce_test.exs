defmodule MapReduceTest do
  use ExUnit.Case
  doctest MapReduce

  test "greets the world" do
    assert MapReduce.map("this is my test case") == [
             {"this", 1},
             {"is", 1},
             {"my", 1},
             {"test", 1},
             {"case", 1}
           ]
  end
end
