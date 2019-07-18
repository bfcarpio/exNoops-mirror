defmodule Exnoops.Mazebot do
  @moduledoc """
  Module to interact with Github's Noop: Mazebot

  See the [official `noop` documentation](https://noopschallenge.com/challenges/mazebot) for API information including the accepted parameters.
  """

  require Logger
  import Exnoops.API

  @noop "mazebot"

  @doc ~S"""
  Query Mazbot for random maze

  + Parameters are sent with a keyword list into the function.

  ## Examples

      iex> Exnoops.Mazebot.get_maze()
      {:ok, %{
        "name" => "Maze #236 (10x10)",
        "mazePath" => "/mazebot/mazes/ikTcNQMwKhux3bWjV3SSYKfyaVHcL0FXsvbwVGk5ns8",
        "startingPosition" => [ 4, 3 ],
        "endingPosition" => [ 3, 6 ],
        "message" => "When you have figured out the solution, post it back to this url. See the exampleSolution for more information.",
        "exampleSolution" => %{ "directions" => "ENWNNENWNNS" },
        "map" => [
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
      }}

      iex> Exnoops.Mazebot.get_maze([minSize: 10, maxSize: 20])
      {:ok, %{
        "name" => "Maze #142 (10x10)",
        "mazePath" => "/mazebot/mazes/dTXurZOonsCbWC9_PDBWpiRAvBME3VBDIf9hcwwCdNc",
        "startingPosition" => [9, 3],
        "endingPosition" => [7, 0],
        "message" => "When you have figured out the solution, post it back to this url. See the exampleSolution for more information.",
        "exampleSolution" => %{ "directions" => "ENWNNENWNNS" },
        "map" => [
          [ "X", " ", " ", " ", " ", " ", "X", "B", " ", " " ],
          [ " ", " ", " ", " ", "X", " ", " ", " ", "X", " " ],
          [ " ", "X", "X", "X", " ", "X", "X", "X", " ", "X" ],
          [ " ", " ", " ", " ", "X", " ", " ", "X", " ", "A" ],
          [ " ", "X", "X", "X", " ", "X", " ", "X", " ", " " ],
          [ " ", " ", " ", "X", " ", "X", " ", "X", " ", " " ],
          [ " ", "X", " ", "X", " ", "X", " ", "X", " ", "X" ],
          [ " ", " ", " ", "X", " ", "X", " ", "X", " ", " " ],
          [ "X", " ", "X", "X", " ", " ", " ", " ", " ", " " ],
          [ "X", " ", " ", " ", " ", "X", " ", " ", " ", "X" ]
        ]
      }}
  """
  @spec get_maze(keyword()) :: {atom(), map()}
  def get_maze(opts \\ []) when is_list(opts) do
    Logger.debug("Calling Mazebot.get_maze()")

    case get("/" <> @noop <> "/random", opts) do
      {:ok, _} = res -> res
      error -> error
    end
  end

  @doc ~S"""
  Query Mazebot for race mazes

  ## Exampes

      iex> Exnoops.Mazebot.get_race("/mazebot/race/Fh5Kt7l9gMQr41GvWkmoCg")
      {:ok, %{
        "name" => "Mazebot 500 Stage#1 (5x5)",
        "mazePath" => "/mazebot/race/Fh5Kt7l9gMQr41GvWkmoCg",
        "map" => [
            [ "A", " ", " ", " ", " "  ],
            [ " ", "X", "X", "X", " "  ],
            [ " ", " ", "X", " ", " "  ],
            [ "X", " ", "X", "B", "X"  ],
            [ "X", " ", " ", " ", "X"  ]
          ],
        "message" => "When you have figured out the solution, post it back to this url in JSON format. See the exampleSolution for more information.",
        "startingPosition" => [0, 0],
        "endingPosition" => [3, 3],
        "exampleSolution" => %{ "directions" => "ENWNNENWNNS"  }
      }}
  """
  @spec get_race(binary()) :: {atom(), map()}
  def get_race(path) when is_binary(path) do
    Logger.debug("Calling Mazebot.get_race()")

    case get(path, []) do
      {:ok, _} = res -> res
      error -> error
    end
  end

  @doc """
  Starts a maze race with Mazebot

  ## Examples

      iex> Exnoops.Mazebot.start_race("yourgithubloginhere")
      {:ok, %{
        "message" => "Start your engines!",
        "nextMaze" => "/mazebot/race/iEGpDT1I0qFzGU81yb49JY3Srj1daT70P6e-Zr6bpR0"
      }}
  """
  @spec start_race(binary()) :: {atom(), map()}
  def start_race(username) when is_binary(username) do
    Logger.debug("Calling Mazebot.start_race(#{username})")

    case post("/mazebot/race/start", %{"login" => username}) do
      {:ok, _} = res -> res
      error -> error
    end
  end

  @doc ~S"""
  Submits an answer to a race

  Takes in race url and string of solved directions

  Returns an outer tuple to denote status of the HTTP response and inner tuple for status of maze solution.

  ## Examples

      iex> Exnoops.Mazebot.submit_maze("/mazebot/mazes/dTXurZOonsCbWC9_PDBWpiRAvBME3VBDIf9hcwwCdNc", "ENNNN....")
      {:ok, {:ok, %{
        "result" => "success",
        "message" => "You solved it in 0.029 seconds with 56 steps, the shortest possible solution.",
        "shortestSolutionLength" => 56,
        "yourSolutionLength" => 56,
        "elapsed" => 29
      }}}

    iex> Exnoops.Mazebot.submit_maze("/mazebot/mazes/17pSAsql1EEaCvEe28UnAQ", "ESS")
    {:ok, {:error, %{"message" => "Hit a wall at directions[1]", "result" => "failed"}}}
  """
  @spec submit_maze(binary(), binary()) :: {atom(), {atom(), map()}}
  def submit_maze(path, directions) when is_binary(path) and is_binary(directions) do
    Logger.debug("Calling Mazebot.submit_maze()")

    case post(path, %{"directions" => directions}) do
      {:ok, %{"result" => "success"} = res} -> {:ok, {:ok, res}}
      {:ok, %{"result" => "failed"} = res} -> {:ok, {:error, res}}
      error -> error
    end
  end
end
