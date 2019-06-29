defmodule Exnoops.HexbotTest do
  use ExUnit.Case
  doctest Exnoops

  test "get_color()" do
    assert Exnoops.Hexbot.get_color() == "#18453B"
  end
end
