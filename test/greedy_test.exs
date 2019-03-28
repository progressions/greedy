defmodule GreedyTest do
  use ExUnit.Case
  doctest Greedy

  test "greets the world" do
    assert Greedy.hello() == :world
  end
end
