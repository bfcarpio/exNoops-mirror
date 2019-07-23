defmodule Exnoops.MelodybotTest do
  use ExUnit.Case
  doctest Exnoops.Melodybot

  test "404" do
    assert Exnoops.Melodybot.get_melody(error: true) == {:error, 404}
  end
end
