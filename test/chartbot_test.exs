defmodule Exnoops.ChartbotTest do
  use ExUnit.Case
  doctest Exnoops.Chartbot

  test "404" do
    assert Exnoops.Chartbot.get_chart(type: "error")
  end
end
