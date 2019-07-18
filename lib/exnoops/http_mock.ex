defmodule Exnoops.API.HttpMock do
  @moduledoc false
  @behaviour Exnoops.API.Behaviour

  defp mock_mojito(status_code, response) do
    {:ok, %Mojito.Response{status_code: status_code, body: response}}
  end

  @impl Exnoops.API.Behaviour
  def http_get(endpoint) do
    case endpoint do
      "/hexbot" ->
        mock_mojito(200, ~S/{
          "colors": [
            { "value": "#18453B" }
          ]
        }/)

      "/hexbot?error=true" ->
        mock_mojito(404, ~S/{
          "message": "The requested resource was not found"
        }/)

      "/hexbot?count=5&seed=FF7F50,FFD700,FF8C00" ->
        mock_mojito(200, ~S/{
          "colors": [
            { "value": "#FFBB19" },
            { "value": "#FF8A0E" },
            { "value": "#FF8628" },
            { "value": "#FF9E00" },
            { "value": "#FF8433" }
          ]
        }/)

      "/drumbot/patterns" ->
        mock_mojito(200, ~S/[
          { "name": "oontza" },
          { "name": "bossanoopa" },
          { "name": "nipnop" },
          { "name": "botthisway" },
          { "name": "funkee" },
          { "name": "shlojam" },
          { "name": "botorik" },
          { "name": "swoop" },
          { "name": "schmaltz" },
          { "name": "bouncy" }
        ]/)

      "/drumbot/patterns/nipnop" ->
        mock_mojito(200, ~S/{
          "name": "nipnop",
          "stepCount": 16,
          "beatsPerMinute": 92,
          "tracks": [
            {
              "instrument": "snare",
              "steps": [ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 ]
            },
            {
              "instrument": "clap",
              "steps": [ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1 ]
            },
            {
              "instrument": "cowbell",
              "steps": [ 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0 ]
            },
            {
              "instrument": "kick",
              "steps": [ 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0 ]
            }
          ]
        }/)

      "/drumbot/patterns/oontza" ->
        mock_mojito(200, ~S/{
          "beatsPerMinute": 110,
          "name": "oontza",
          "stepCount": 16,
          "tracks": [
            {
              "instrument": "hihat",
              "steps": [0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1]
            },
            {
              "instrument": "snare",
              "steps": [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0]
            },
            {
              "instrument": "kick",
              "steps": [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]
            }
          ]
        }/)

      "/drumbot/patterns/botorik" ->
        mock_mojito(200, ~S/{
          "beatsPerMinute": 120,
          "name": "botorik",
          "stepCount": 16,
          "tracks": [
            {
              "instrument": "hihat",
              "steps": [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]
            },
            {
              "instrument": "snare",
              "steps": [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0]
            },
            {
              "instrument": "kick",
              "steps": [1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0]
            },
            {
              "instrument": "cowbell",
              "steps": [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]
            }
          ]
        }/)

      "/drumbot/patterns/NotAPattern" ->
        mock_mojito(404, ~S/{
          "message": "The requested resource was not found"
        }/)

      "/wordbot" ->
        mock_mojito(200, ~S/{
          "words": [ "pepperoni" ]
        }/)

      "/wordbot/sets" ->
        mock_mojito(200, ~S/[
          "adjectives",
          "adverbs",
          "all",
          "animals",
          "cats",
          "common",
          "default",
          "dinosaurs",
          "dogs",
          "encouragement",
          "fabrics",
          "flowers",
          "fruits",
          "gemstones",
          "genres",
          "horses",
          "instruments",
          "knots",
          "menu",
          "metals",
          "moods",
          "nouns",
          "objects",
          "occupations",
          "prepositions",
          "rhymeless",
          "sports",
          "vegetables",
          "verbs",
          "verbs_past",
          "weather",
          "wrestlers"
        ]/)

      "/wordbot?count=4&set=dinosaurs" ->
        mock_mojito(200, ~S/{
           "words": [
             "Xixiposaurus",
             "Ischyrosaurus",
             "Crocodylomorph",
             "Tatankaceratops"
           ]
         }/)

      "/wordbot?count=7" ->
        mock_mojito(200, ~S/{
          "words": [
            "extracorporeal",
            "behooves",
            "superregionals",
            "stepmother",
            "heckle",
            "clanks",
            "hippest"
          ]
        }/)

      "/fizzbot" ->
        mock_mojito(200, ~S<{
          "message": "Thank you for your application to Noops Inc.\n\nOur automated fizzbot interview process will help us determine if you have what it takes to become a Noop.\n\nFor each question, you will GET the question and then give us the answer back to the same URL.\nYou will also find the URL for the next question in the nextQuestion parameter for each response.\n\nThe first question is at https://api.noopschallenge.com/fizzbot/questions/1.\n\nGood Luck\n",
          "nextQuestion": "/fizzbot/questions/1"
        }>)

      "/fizzbot/questions/987654321" ->
        mock_mojito(404, ~S/{
          "message": "The requested resource was not found"
        }/)

      "/fizzbot/questions/1" ->
        mock_mojito(200, ~S<{
          "message": "What is your favorite programming language?\nMine is COBOL, of course.\nPOST your answer back to this URL in JSON format. If you are having difficulties, see the exampleResponse provided.",
          "exampleResponse": { "answer": "COBOL" }
        }>)

      "/fizzbot/questions/1234567" ->
        mock_mojito(200, ~S<{
          "message": "FizzBuzz is the name of the game.\nHere's a list of numbers.\nSend me back a string as follows:\nFor each number:\nIf it is divisible by 3, print \"Fizz\".\nIf it is divisible by 5, print \"Buzz\".\nIf it is divisible by 3 and 5, print \"FizzBuzz\".\nOtherwise, print the number.\n\nEach entry in the string should be separated by a space.\n\nFor example, if the numbers are [1, 2, 3, 4, 5], you would send back:\n\n{\n  \"answer\": \"1 2 Fizz 4 Buzz\"\n}\n",
          "rules": [
            { "number": 3, "response": "Fizz" },
            { "number": 5, "response": "Buzz" }
          ],
          "numbers": [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 ],
          "exampleResponse": { "answer": "1 2 Fizz 4 Buzz..." }
        }>)

      "/vexbot" ->
        mock_mojito(200, ~S<{
          "vectors": [
            {
              "a": {
                "x": 743,
                "y": 147
              },
              "b": {
                "x": 60,
                "y": 601
              },
              "speed": 71
            }
          ]
        }>)

      "/vexbot?error=true" ->
        mock_mojito(404, ~S/{
          "message": "The requested resource was not found"
        }/)

      "/vexbot?count=2" ->
        mock_mojito(200, ~S/{
          "vectors": [
            {
              "a": {
                "x": 743,
                "y": 147
              },
              "b": {
                "x": 60,
                "y": 601
              },
              "speed": 71
            },
            {
              "a": {
                "x": 12,
                "y": 34
              },
              "b": {
                "x": 56,
                "y": 78
              },
              "speed": 90
            }]}/)

      "/directbot" ->
        mock_mojito(200, ~S/{
          "directions": [
            { "direction": "up", "distance": 96, "speed": 97 }
          ]
        }/)

      "/directbot?count=5" ->
        mock_mojito(200, ~S/{
          "directions": [
            { "direction": "down", "distance": 73, "speed": 58 },
            { "direction": "right", "distance": 58, "speed": 69 },
            { "direction": "down", "distance": 42, "speed": 12 },
            { "direction": "right", "distance": 51, "speed": 84 },
            { "direction": "down", "distance": 35, "speed": 14 }
          ]
        }/)

      "/directbot?count=5&speed=5&distance=10" ->
        mock_mojito(200, ~S/{
          "directions": [
            { "direction": "left", "distance": 10, "speed": 2 },
            { "direction": "down", "distance": 10, "speed": 2 },
            { "direction": "right", "distance": 10, "speed": 2 },
            { "direction": "down", "distance": 10, "speed": 1 },
            { "direction": "up", "distance": 10, "speed": 4 }
          ]
        }/)

      "/directbot?count=1&connected=1" ->
        mock_mojito(200, ~S/{
        "directions": [
          {
            "coordinates": {
              "a": { "x": 84, "y": 609 },
              "b": { "x": 91, "y": 609 }
            },
            "direction": "up",
            "distance": 32,
            "speed": 6
          }]}/)

      "/directbot?error=true" ->
        mock_mojito(404, ~S/{
          "message": "The requested resource was not found"
        }/)

      "/polybot" ->
        mock_mojito(200, ~S/{
          "polygons": [
            [
              {"x":157,"y":998},
              {"x":145,"y":1000},
              {"x":122,"y":1000},
              {"x":106,"y":989},
              {"x":151,"y":972}
            ]
          ]
        }/)

      "/polybot?error=true" ->
        mock_mojito(404, ~S/{
          "message": "The requested resource was not found"
        }/)

      "/mazebot/random" ->
        mock_mojito(200, ~S<{
          "name": "Maze #236 (10x10)",
          "mazePath": "/mazebot/mazes/ikTcNQMwKhux3bWjV3SSYKfyaVHcL0FXsvbwVGk5ns8",
          "startingPosition": [ 4, 3 ],
          "endingPosition": [ 3, 6 ],
          "message": "When you have figured out the solution, post it back to this url. See the exampleSolution for more information.",
          "exampleSolution": { "directions": "ENWNNENWNNS" },
          "map": [
            [ " ", " ", "X", " ", " ", " ", "X", " ", "X", "X" ],
            [ " ", "X", " ", " ", " ", " ", " ", " ", " ", " " ],
            [ " ", "X", " ", "X", "X", "X", "X", "X", "X", " " ],
            [ " ", "X", " ", " ", "A", " ", " ", " ", "X", " " ],
            [ " ", "X", "X", "X", "X", "X", "X", "X", " ", " " ],
            [ "X", " ", " ", " ", "X", " ", " ", " ", "X", " " ],
            [ " ", " ", "X", "B", "X", " ", "X", " ", "X", " " ],
            [ " ", " ", "X", " ", "X", " ", "X", " ", " ", " " ],
            [ "X", " ", "X", "X", "X", "X", "X", " ", "X", "X" ],
            [ "X", " ", " ", " ", " ", " ", " ", " ", "X", "X" ]
          ]
        }>)

      "/mazebot/random?minSize=10&maxSize=20" ->
        mock_mojito(200, ~S<{
        "name": "Maze #142 (10x10)",
        "mazePath": "/mazebot/mazes/dTXurZOonsCbWC9_PDBWpiRAvBME3VBDIf9hcwwCdNc",
        "startingPosition": [ 9, 3  ],
        "endingPosition": [ 7, 0  ],
        "message": "When you have figured out the solution, post it back to this url. See the exampleSolution for more information.",
        "exampleSolution": { "directions": "ENWNNENWNNS"  },
        "map": [
            [ "X", " ", " ", " ", " ", " ", "X", "B", " ", " "  ],
            [ " ", " ", " ", " ", "X", " ", " ", " ", "X", " "  ],
            [ " ", "X", "X", "X", " ", "X", "X", "X", " ", "X"  ],
            [ " ", " ", " ", " ", "X", " ", " ", "X", " ", "A"  ],
            [ " ", "X", "X", "X", " ", "X", " ", "X", " ", " "  ],
            [ " ", " ", " ", "X", " ", "X", " ", "X", " ", " "  ],
            [ " ", "X", " ", "X", " ", "X", " ", "X", " ", "X"  ],
            [ " ", " ", " ", "X", " ", "X", " ", "X", " ", " "  ],
            [ "X", " ", "X", "X", " ", " ", " ", " ", " ", " "  ],
            [ "X", " ", " ", " ", " ", "X", " ", " ", " ", "X"  ]
          ]
      }>)

      "/mazebot/race/Fh5Kt7l9gMQr41GvWkmoCg" ->
        mock_mojito(200, ~S<{
          "name": "Mazebot 500 Stage#1 (5x5)",
          "mazePath": "/mazebot/race/Fh5Kt7l9gMQr41GvWkmoCg",
          "map": [
            [ "A", " ", " ", " ", " " ],
            [ " ", "X", "X", "X", " " ],
            [ " ", " ", "X", " ", " " ],
            [ "X", " ", "X", "B", "X" ],
            [ "X", " ", " ", " ", "X" ]
          ],
          "message": "When you have figured out the solution, post it back to this url in JSON format. See the exampleSolution for more information.",
          "startingPosition": [ 0, 0 ],
          "endingPosition": [ 3, 3 ],
          "exampleSolution": { "directions": "ENWNNENWNNS" }
        }>)

      "/mazebot/random?error=true" ->
        mock_mojito(404, ~S/{
          "message": "The requested resource was not found"
        }/)

      "/mazebot/NotRealPath" ->
        mock_mojito(404, ~S/{
          "message": "The requested resource was not found"
        }/)
    end
  end

  @impl Exnoops.API.Behaviour
  def http_post(endpoint, answer) do
    case {endpoint, answer} do
      {"/fizzbot/questions/1", ~S<{"answer":"COBOL"}>} ->
        mock_mojito(200, ~S<{
           "result": "correct",
           "message": "Of course. How interesting. Are you ready for your first REAL question?",
           "nextQuestion": "/fizzbot/questions/1234567"
         }>)

      {"/fizzbot/questions/987654321", "{\"answer\":\"COBOl\"}"} ->
        mock_mojito(404, ~S/{
          "message": "The requested resource was not found"
        }/)

      {"/mazebot/mazes/dTXurZOonsCbWC9_PDBWpiRAvBME3VBDIf9hcwwCdNc",
       "{\"directions\":\"ENNNN....\"}"} ->
        mock_mojito(200, ~S<{
          "result": "success",
          "message": "You solved it in 0.029 seconds with 56 steps, the shortest possible solution.",
          "shortestSolutionLength": 56,
          "yourSolutionLength": 56,
          "elapsed": 29
        }>)

      {"/mazebot/mazes/17pSAsql1EEaCvEe28UnAQ", "{\"directions\":\"ESS\"}"} ->
        mock_mojito(200, ~S<{ "message": "Hit a wall at directions[1]", "result": "failed" }>)

      {"/mazebot/NotRealPath", "{\"directions\":\"ESS\"}"} ->
        mock_mojito(404, ~S/{
          "message": "The requested resource was not found"
        }/)
    end
  end
end
