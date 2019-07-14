defmodule Exnoops.Fizzbot do
  @moduledoc """
  Module to interact with Github's Noop: Fizzbot

  See the [official `noop` documentation](https://noopschallenge.com/challenges/fizzbot) for API information
  """

  require Logger
  import Exnoops.API

  @noop "fizzbot"

  @doc ~S"""
  Query Fizzbot for a question

  If you don't provide a question number, it will query the default endpoint which returns the instructions.

  **Note**: Due to the many possible keys in each response, minimal processing will occur.

  ## Examples

      iex> Exnoops.Fizzbot.ask_question()
      {:ok,
        %{
        "message" => "Thank you for your application to Noops Inc.\n\nOur automated fizzbot interview process will help us determine if you have what it takes to become a Noop.\n\nFor each question, you will GET the question and then give us the answer back to the same URL.\nYou will also find the URL for the next question in the nextQuestion parameter for each response.\n\nThe first question is at https://api.noopschallenge.com/fizzbot/questions/1.\n\nGood Luck\n",
        "nextQuestion" => "/fizzbot/questions/1"
        }
      }

      iex> Exnoops.Fizzbot.ask_question(1)
      {:ok,
        %{
        "message" => "What is your favorite programming language?\nMine is COBOL, of course.\nPOST your answer back to this URL in JSON format. If you are having difficulties, see the exampleResponse provided.",
        "exampleResponse" => %{ "answer" => "COBOL" }
        }
      }

      iex> Exnoops.Fizzbot.ask_question(1234567)
      {:ok,
        %{
          "message" => "FizzBuzz is the name of the game.\nHere's a list of numbers.\nSend me back a string as follows:\nFor each number:\nIf it is divisible by 3, print \"Fizz\".\nIf it is divisible by 5, print \"Buzz\".\nIf it is divisible by 3 and 5, print \"FizzBuzz\".\nOtherwise, print the number.\n\nEach entry in the string should be separated by a space.\n\nFor example, if the numbers are [1, 2, 3, 4, 5], you would send back:\n\n{\n  \"answer\": \"1 2 Fizz 4 Buzz\"\n}\n",
          "rules" => [
            %{ "number" => 3, "response" => "Fizz" },
            %{ "number" => 5, "response" => "Buzz" }
          ],
          "numbers" => [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 ],
          "exampleResponse" => %{ "answer" => "1 2 Fizz 4 Buzz..." }
        }
      }
  """
  @spec ask_question(integer()) :: {atom(), map()}
  def ask_question(question_id \\ 0) when is_integer(question_id) do
    Logger.debug("Calling Fizzbot.ask_question(#{question_id})")

    endpoint = if question_id == 0, do: "", else: "/questions/#{question_id}"

    case get("/" <> @noop <> endpoint, []) do
      {:ok, _} = res -> res
      error -> error
    end
  end

  @doc ~S"""
  Submit an answer to Fizzbot

  ## Examples

      iex> Exnoops.Fizzbot.answer_question(1, %{"answer" => "COBOL"})
      {:ok,
        %{
          "result" => "correct",
          "message" => "Of course. How interesting. Are you ready for your first REAL question?",
          "nextQuestion" => "/fizzbot/questions/1234567"
        }
      }
  """
  @spec answer_question(integer(), map()) :: {atom(), map()}
  def answer_question(question_id, %{"answer" => _} = answer) when is_integer(question_id) do
    Logger.debug("Calling Fizzbot.answer_question(#{question_id})")

    case post("/" <> @noop <> "/questions/#{question_id}", answer) do
      {:ok, %{"result" => _}} = res -> res
      error -> error
    end
  end
end
