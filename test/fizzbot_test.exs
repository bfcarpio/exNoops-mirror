defmodule Exnoops.FizzbotTest do
  use ExUnit.Case
  doctest Exnoops.Fizzbot

  test "404" do
    assert Exnoops.Fizzbot.ask_question(987_654_321) == {:error, 404}
    assert Exnoops.Fizzbot.answer_question(987_654_321, %{"answer" => "COBOl"}) == {:error, 404}
  end
end
