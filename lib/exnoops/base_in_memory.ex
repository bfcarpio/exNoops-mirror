defmodule Exnoops.BaseInMemory do
  @moduledoc false

  def get(endpoint, opts) do
    case {endpoint, opts} do
      {"/hexbot", []} ->
        {:ok, %{"colors" => [%{"value" => "#18453B"}]}}

      {"/hexbot", [count: 5, seed: ["FF7F50", "FFD700", "FF8C00"]]} ->
        {:ok,
         %{
           "colors" => [
             %{"value" => "#FFBB19"},
             %{"value" => "#FF8A0E"},
             %{"value" => "#FF8628"},
             %{"value" => "#FF9E00"},
             %{"value" => "#FF8433"}
           ]
         }}

      {"/drumbot/patterns", []} ->
        {:ok,
         [
           %{"name" => "oontza"},
           %{"name" => "bossanoopa"},
           %{"name" => "nipnop"},
           %{"name" => "botthisway"},
           %{"name" => "funkee"},
           %{"name" => "shlojam"},
           %{"name" => "botorik"},
           %{"name" => "swoop"},
           %{"name" => "schmaltz"},
           %{"name" => "bouncy"}
         ]}

      {"/drumbot/patterns/nipnop", []} ->
        {:ok,
         %{
           "name" => "nipnop",
           "beatsPerMinute" => 92,
           "stepCount" => 16,
           "tracks" => [
             %{
               "instrument" => "snare",
               "steps" => [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0]
             },
             %{
               "instrument" => "clap",
               "steps" => [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1]
             },
             %{
               "instrument" => "cowbell",
               "steps" => [0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0]
             },
             %{
               "instrument" => "kick",
               "steps" => [1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0]
             }
           ]
         }}

      {"/drumbot/patterns/oontza", []} ->
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

      {"/drumbot/patterns/botorik", []} ->
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

      {"/drumbot/patterns/NotAPattern", []} ->
        {:error, 404}

      {"/wordbot", []} ->
        {:ok, %{"words" => ["pepperoni"]}}

      {"/wordbot", [count: 7]} ->
        {:ok,
         %{
           "words" => [
             "extracorporeal",
             "behooves",
             "superregionals",
             "stepmother",
             "heckle",
             "clanks",
             "hippest"
           ]
         }}

      {"/wordbot", [count: 4, set: "dinosaurs"]} ->
        {:ok,
         %{
           "words" => [
             "Xixiposaurus",
             "Ischyrosaurus",
             "Crocodylomorph",
             "Tatankaceratops"
           ]
         }}

      {"/fizzbot", []} ->
        {:ok,
         %{
           "message" =>
             "Thank you for your application to Noops Inc.\n\nOur automated fizzbot interview process will help us determine if you have what it takes to become a Noop.\n\nFor each question, you will GET the question and then give us the answer back to the same URL.\nYou will also find the URL for the next question in the nextQuestion parameter for each response.\n\nThe first question is at https://api.noopschallenge.com/fizzbot/questions/1.\n\nGood Luck\n",
           "nextQuestion" => "/fizzbot/questions/1"
         }}

      {"/fizzbot/questions/1", []} ->
        {:ok,
         %{
           "message" =>
             "What is your favorite programming language?\nMine is COBOL, of course.\nPOST your answer back to this URL in JSON format. If you are having difficulties, see the exampleResponse provided.",
           "exampleResponse" => %{"answer" => "COBOL"}
         }}

      {"/fizzbot/questions/1234567", []} ->
        {:ok,
         %{
           "message" =>
             "What is your favorite programming language?\nMine is COBOL, of course.\nPOST your answer back to this URL in JSON format. If you are having difficulties, see the exampleResponse provided.",
           "rules" => [
             %{"number" => 3, "response" => "Fizz"},
             %{"number" => 5, "response" => "Buzz"}
           ],
           "numbers" => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
           "exampleResponse" => %{"answer" => "1 2 Fizz 4 Buzz..."}
         }}
    end
  end

  def post(endpoint, answer) do
    case {endpoint, answer} do
      {"/fizzbot/questions/1", %{"answer" => "COBOL"}} ->
        {:ok,
         %{
           "result" => "correct",
           "message" => "Of course. How interesting. Are you ready for your first REAL question?",
           "nextQuestion" => "/fizzbot/questions/1234567"
         }}
    end
  end
end
