defmodule Exnoops.PathbotTest do
  use ExUnit.Case
  doctest Exnoops.Pathbot

  test "404" do
    assert Exnoops.Pathbot.submit_direction("/pathbot/rooms/NotARoom", "...")
  end
end
