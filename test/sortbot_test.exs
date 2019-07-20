defmodule Exnoops.SortbotTest do
  use ExUnit.Case
  doctest Exnoops.Sortbot

  test "404" do
    assert Exnoops.Sortbot.submit("/sortbot/NotAPath", error: "...") == {:error, 404}
  end
end
