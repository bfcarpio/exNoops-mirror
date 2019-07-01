defmodule Exnoops.DrumbotTest do
  use ExUnit.Case
  doctest Exnoops.Drumbot

  test "ootza pattern" do
    assert Exnoops.Drumbot.get_pattern("oontza") ==
             {:ok,
              %{
                "beatsPerMinute" => 110,
                "name" => "oontza",
                "stepCount" => 16,
                "tracks" => [
                  %{
                    "instrument" => "hihat",
                    "steps" => [0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1]
                  },
                  %{
                    "instrument" => "snare",
                    "steps" => [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0]
                  },
                  %{
                    "instrument" => "kick",
                    "steps" => [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]
                  }
                ]
              }}
  end

  test "botorik pattern" do
    assert Exnoops.Drumbot.get_pattern("botorik") ==
             {:ok,
              %{
                "beatsPerMinute" => 120,
                "name" => "botorik",
                "stepCount" => 16,
                "tracks" => [
                  %{
                    "instrument" => "hihat",
                    "steps" => [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]
                  },
                  %{
                    "instrument" => "snare",
                    "steps" => [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0]
                  },
                  %{
                    "instrument" => "kick",
                    "steps" => [1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0]
                  },
                  %{
                    "instrument" => "cowbell",
                    "steps" => [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]
                  }
                ]
              }}
  end

  test "Not a pattern" do
    assert Exnoops.Drumbot.get_pattern("NotAPattern") == {:error, 404}
  end
end
