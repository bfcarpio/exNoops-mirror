defmodule Exnoops.PolybotTest do
  use ExUnit.Case
  doctest Exnoops.Polybot

  test "404" do
    assert Exnoops.Polybot.get_polygon(error: true) == {:error, 404}
  end
end
