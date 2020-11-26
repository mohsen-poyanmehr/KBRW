defmodule TRAININGTest do
  use ExUnit.Case
  doctest TRAINING

  test "greets the world" do
    assert TRAINING.hello() == :world
  end
end
