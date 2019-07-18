defmodule Exnoops.RiddlebotTest do
  use ExUnit.Case
  doctest Exnoops.Riddlebot

  test "start 404" do
    assert Exnoops.Riddlebot.start("NotAChallenger") == {:error, 404}
  end

  test "get_riddle 404" do
    assert Exnoops.Riddlebot.get_riddle("/riddlebot/riddles/NotARiddle") == {:error, 404}
  end

  test "submit_riddle 404" do
    assert Exnoops.Riddlebot.submit_riddle("/riddlebot/riddles/NotARiddle", "...") ==
             {:error, 404}
  end

  test "get_certificate 404" do
    assert Exnoops.Riddlebot.get_certificate("/riddlebot/certificate/NotACertificate") ==
             {:error, 404}
  end
end
