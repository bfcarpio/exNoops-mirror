defmodule Exnoops.MazebotTest do
  use ExUnit.Case
  doctest Exnoops.Mazebot

  test "get_maze 404" do
    assert Exnoops.Mazebot.get_maze(error: true) == {:error, 404}
  end

  test "get_race 404" do
    assert Exnoops.Mazebot.get_race("/mazebot/NotRealPath") == {:error, 404}
  end

  test "submit_maze 404" do
    assert Exnoops.Mazebot.submit_maze("/mazebot/NotRealPath", "ESS") == {:error, 404}
  end
end
