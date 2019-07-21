defmodule Exnoops.MashbotTest do
  use ExUnit.Case
  doctest Exnoops.Mashbot

  test "404" do
    assert Exnoops.Mashbot.query(error: true) == {:error, 404}
  end
end
