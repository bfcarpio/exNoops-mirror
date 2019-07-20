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

      "/riddlebot/start" ->
        mock_mojito(200, ~S<{
          "message": "Post your GitHub login to this URL to get started",
          "exampleResponse": { "login": "noops-challenge" }
        }>)

      "/riddlebot/riddles/NotARiddle" ->
        mock_mojito(404, ~S/{
          "message": "The requested resource was not found"
        }/)

      "/riddlebot/riddles/Zsy4sdsCuYrIPwbnw5HOowNvsWcxmh_uo31C8tkN4wU" ->
        mock_mojito(200, ~S<{
          "message": "The riddleText is reversed. When you have figured out the answer, post it back as JSON. See the exampleResponse for details.",
          "riddlePath": "/riddlebot/riddles/Zsy4sdsCuYrIPwbnw5HOowNvsWcxmh_uo31C8tkN4wU",
          "exampleResponse": { "answer": "ANSWER GOES HERE" },
          "riddleType": "reverse",
          "riddleText": "EVIF EERHT OREZ XIS OWT OWT NEVES RUOF EVIF THGIE TA KCAB EM LLAC ESAELP TOBHTAP SI TI OLLEH"
        }>)

      "/riddlebot/certificate/NotACertificate" ->
        mock_mojito(404, ~S/{
          "message": "The requested resource was not found"
        }/)

      "/riddlebot/certificate/613oBeHRK_2BzTZ8YgRwxEN-hBxrD1ZOnRspvSuJ4hJks8svZvSBynJ09sOdoFQM" ->
        mock_mojito(200, ~S<{
          "message": "This certifies that your-login-here completed the Riddlebot challenge.",
          "elapsed": 1928,
          "completed": "2019-06-24T22:11:39.231Z"
        }>)

      "/sortbot" ->
        mock_mojito(200, ~S<{
          "message": "Hello there, welcome to the Sortbot. Get started at /sortbot/exam"
        }>)

      "/interviewbot/start" ->
        mock_mojito(200, ~S<{
          "message": "Welcome to your interview. Please POST your GitHub login to this URL to get started. See the exampleResponse for more information.",
          "exampleResponse": { "login": "noops-challenger" }
        }>)

      "/interviewbot/NotAPath" ->
        mock_mojito(404, ~S/{
          "message": "The requested resource was not found"
        }/)

      "/interviewbot/questions/izZhyS2sCY7kZtZJf8yjizYuMo7zLE0m4Ucom4NeJYc" ->
        mock_mojito(200, ~S<{
            "questionPath": "/interviewbot/questions/izZhyS2sCY7kZtZJf8yjizYuMo7zLE0m4Ucom4NeJYc",
            "question": 12111900247,
            "message": "Find the prime factors of the number 12111900247. The prime factors of a number are the prime numbers that result in the number when multiplied together. The prime factors of 12 would be [2,2,3] because 2 * 2 * 3 = 12.",
            "exampleResponse": {
              "answer": [ 2, 3, 5, 7 ]
            }
          }>)
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

      {"/mazebot/race/start", "{\"login\":\"yourgithubloginhere\"}"} ->
        mock_mojito(200, ~S<{
          "message": "Start your engines!",
          "nextMaze": "/mazebot/race/iEGpDT1I0qFzGU81yb49JY3Srj1daT70P6e-Zr6bpR0"
        }>)

      {"/mazebot/race/start", "{\"login\":\"NotAName\"}"} ->
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

      {"/riddlebot/start", "{\"login\":\"NotAChallenger\"}"} ->
        mock_mojito(404, ~S/{
          "message": "The requested resource was not found"
        }/)

      {"/riddlebot/start", "{\"login\":\"noop-challenger\"}"} ->
        mock_mojito(200, ~S<{
          "message": "Hello from Riddlebot. Get the first riddle at the provided riddlePath",
          "riddlePath": "/riddlebot/riddles/Zsy4sdsCuYrIPwbnw5HOowNvsWcxmh_uo31C8tkN4wU"
        }>)

      {"/riddlebot/riddles/NotARiddle", "{\"answer\":\"...\"}"} ->
        mock_mojito(404, ~S/{
          "message": "The requested resource was not found"
        }/)

      {"/riddlebot/riddles/Zsy4sdsCuYrIPwbnw5HOowNvsWcxmh_uo31C8tkN4wU", "{\"answer\":\"...\"}"} ->
        mock_mojito(200, ~S<{
          "result": "correct",
          "nextRiddlePath": "/riddlebot/riddles/4LpseM7Yg8_wB0sX50eWCtQLPtassehfrZwjMSGhKLk"
        }>)

      {"/pathbot/rooms/NotARoom", "{\"direction\":\"...\"}"} ->
        mock_mojito(404, ~S/{
          "message": "The requested resource was not found"
        }/)

      {"/pathbot/rooms/LU62ZaD_SqudPvH3Qt3kJQ", "{\"direction\":\"N\"}"} ->
        mock_mojito(200, ~S<{
          "status": "in-progress",
          "message": "You are trapped in a maze",
          "exits": [ "N", "S" ],
          "description": "You are in a chartreuse rectangular storage room with exits to the North and South. You sense that the maze's exit is to the North, at least 5 rooms away..",
          "mazeExitDirection": "N",
          "mazeExitDistance": 5,
          "locationPath": "/pathbot/rooms/OkNMk8D_XfLtYgnicZWzcA"
        }>)

      {"/pathbot/rooms/RPq3xhL51USGI_iU16alKA", "{\"direction\":\"N\"}"} ->
        mock_mojito(200, ~S<{
          "status": "finished",
          "description": "Congratulations! You have escaped the maze."
        }>)

      {"/pathbot/start", "[]"} ->
        mock_mojito(200, ~S<{
          "status": "in-progress",
          "message": "You find yourself in a strange room. You're not sure how you got here but you know you need to escape, somehow.",
          "exits": [ "N", "S" ],
          "description": "You are in a bright long dining room with exits to the North and South. You sense that the maze's exit is to the North, at least 6 rooms away..",
          "mazeExitDirection": "N",
          "mazeExitDistance": 6,
          "locationPath": "/pathbot/rooms/LU62ZaD_SqudPvH3Qt3kJQ"
        }>)

      {"/sortbot/exam/3qm7iTRNtpn8NIUqtBubvQ", "{\"solution\":[32,35,40,46,52,53,73,80,95,96]}"} ->
        mock_mojito(200, ~S<{
          "result": "success",
          "message": "Great job!",
          "elapsed": 0,
          "nextSet": "/sortbot/exam/6YXxoDcJDtzp8Aj3iY0W0A"
        }>)

      {"/sortbot/exam/start", "{\"login\":\"test\"}"} ->
        mock_mojito(200, ~S<{
          "message": "Hello test, get ready for all sorts of fun. Get it?",
          "nextSet": "/sortbot/exam/3qm7iTRNtpn8NIUqtBubvQ"
        }>)

      {"/sortbot/NotAPath", "{\"error\":\"...\"}"} ->
        mock_mojito(404, ~S/{
          "message": "The requested resource was not found"
        }/)

      {"/interviewbot/NotAPath", "{\"login\":\"...\"}"} ->
        mock_mojito(404, ~S/{
          "message": "The requested resource was not found"
        }/)

      {"/interviewbot/start", "{\"login\":\"noops-challenger\"}"} ->
        mock_mojito(200, ~S<{
          "message": "Hello noops-challenger, get ready for your interview. Your first question is at /interviewbot/questions/izZhyS2sCY7kZtZJf8yjizYuMo7zLE0m4Ucom4NeJYc",
          "nextQuestion": "/interviewbot/questions/izZhyS2sCY7kZtZJf8yjizYuMo7zLE0m4Ucom4NeJYc"
        }>)
    end
  end
end
