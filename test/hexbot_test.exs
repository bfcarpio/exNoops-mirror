defmodule Exnoops.HexbotTest do
  use ExUnit.Case
  doctest Exnoops.Hexbot

  test "404" do
    assert Exnoops.Hexbot.get_color(error: true) == {:error, 404}
  end
end
