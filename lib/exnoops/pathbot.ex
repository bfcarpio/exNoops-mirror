defmodule Exnoops.Pathbot do
  @moduledoc """
  Module to interact with Github's Noop: Pathbot

  See the [official `noop` documentation](https://noopschallenge.com/challenges/pathbot) for API information including the accepted parameters.
  """

  require Logger
  import Exnoops.API

  @noop "pathbot"

  @doc """
  Start helping `pathbot` out of the maze!

  ## Examples

      iex> Exnoops.Pathbot.start()
      {:ok, %{
        "status" => "in-progress",
        "message" => "You find yourself in a strange room. You're not sure how you got here but you know you need to escape, somehow.",
        "exits" => [ "N", "S" ],
        "description" => "You are in a bright long dining room with exits to the North and South. You sense that the maze's exit is to the North, at least 6 rooms away..",
        "mazeExitDirection" => "N",
        "mazeExitDistance" => 6,
        "locationPath" => "/pathbot/rooms/LU62ZaD_SqudPvH3Qt3kJQ"
      }}
  """
  @spec start() :: {atom(), map()}
  def start() do
    Logger.debug("Calling Pathbot.start()")

    case post("/" <> @noop <> "/start", []) do
      {:ok, _} = res ->
        res

      error ->
        error
    end
  end

  @doc """
  Submit directions to pathbot

  ## Examples

      iex> Exnoops.Pathbot.submit_direction("/pathbot/rooms/LU62ZaD_SqudPvH3Qt3kJQ", "N")
      {:ok, %{
        "status" => "in-progress",
        "message" => "You are trapped in a maze",
        "exits" => [ "N", "S" ],
        "description" => "You are in a chartreuse rectangular storage room with exits to the North and South. You sense that the maze's exit is to the North, at least 5 rooms away..",
        "mazeExitDirection" => "N",
        "mazeExitDistance" => 5,
        "locationPath" => "/pathbot/rooms/OkNMk8D_XfLtYgnicZWzcA"
      }}

      iex> Exnoops.Pathbot.submit_direction("/pathbot/rooms/RPq3xhL51USGI_iU16alKA", "N")
      {:ok, %{
        "status" => "finished",
        "description" => "Congratulations! You have escaped the maze."
      }}
  """
  @spec submit_direction(String.t(), String.t()) :: {atom(), map()}
  def submit_direction(path, direction) when is_binary(path) and is_binary(direction) do
    Logger.debug("Calling Pathbot.submit_direction(#{path}, #{direction}")

    case post(path, %{"direction" => direction}) do
      {:ok, _} = res ->
        res

      error ->
        error
    end
  end
end
