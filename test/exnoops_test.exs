defmodule ExnoopsTest do
  use ExUnit.Case
  doctest Exnoops

  test "greets the world" do
    assert Exnoops.hello() == :world
  end
end
