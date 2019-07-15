defmodule Exnoops.DirectbotTest do
  use ExUnit.Case
  doctest Exnoops.Directbot

  test "404" do
    assert Exnoops.Directbot.get_direction(error: true)
  end
end
