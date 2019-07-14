defmodule Exnoops.VexbotTest do
  use ExUnit.Case
  doctest Exnoops.Vexbot

  test "404" do
    assert Exnoops.Vexbot.get_vector(error: true) == {:error, 404}
  end
end
