defmodule Exnoops.InterviewbotTest do
  use ExUnit.Case
  doctest Exnoops.Interviewbot

  test "query 404" do
    assert Exnoops.Interviewbot.query("/interviewbot/NotAPath") == {:error, 404}
  end

  test "submit 404" do
    assert Exnoops.Interviewbot.submit("/interviewbot/NotAPath", login: "...") == {:error, 404}
  end
end
