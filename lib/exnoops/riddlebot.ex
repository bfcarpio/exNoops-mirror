defmodule Exnoops.Riddlebot do
  @moduledoc """
  Module to interact with GIthub's Noop: Riddlebot

  See the [official `noop` documentation](https://noopschallenge.com/challenges/riddlebot)
  """

  require Logger
  import Exnoops.API

  @noop "riddlebot"

  @doc """
  Query Riddlebot for instructions

  ## Examples

      iex> Exnoops.Riddlebot.start()
      {:ok, %{
        "message" => "Post your GitHub login to this URL to get started",
        "exampleResponse" => %{ "login" => "noops-challenge" }
      }}
  """
  @spec start() :: {atom(), map()}
  def start() do
    Logger.debug("Calling Riddlebot.start()")

    case get("/" <> @noop <> "/start", []) do
      {:ok, _} = res ->
        res

      error ->
        error
    end
  end

  @doc """
  Start Riddlebot's challenge by passing in your github name

  ## Examples

      iex> Exnoops.Riddlebot.start("noop-challenger")
      {:ok, %{
        "message" => "Hello from Riddlebot. Get the first riddle at the provided riddlePath",
        "riddlePath" => "/riddlebot/riddles/Zsy4sdsCuYrIPwbnw5HOowNvsWcxmh_uo31C8tkN4wU"
      }}
  """
  @spec start(String.t()) :: {atom(), map()}
  def start(username) when is_binary(username) do
    Logger.debug("Calling Riddlebot.start(#{username})")

    case post("/riddlebot/start", %{"login" => username}) do
      {:ok, _} = res ->
        res

      error ->
        error
    end
  end

  @doc """
  Get Riddlebot riddle

  ## Examples

      iex> Exnoops.Riddlebot.get_riddle("/riddlebot/riddles/Zsy4sdsCuYrIPwbnw5HOowNvsWcxmh_uo31C8tkN4wU")
      {:ok, %{
        "message" => "The riddleText is reversed. When you have figured out the answer, post it back as JSON. See the exampleResponse for details.",
        "riddlePath" => "/riddlebot/riddles/Zsy4sdsCuYrIPwbnw5HOowNvsWcxmh_uo31C8tkN4wU",
        "exampleResponse" => %{ "answer" => "ANSWER GOES HERE" },
        "riddleType" => "reverse",
        "riddleText" => "EVIF EERHT OREZ XIS OWT OWT NEVES RUOF EVIF THGIE TA KCAB EM LLAC ESAELP TOBHTAP SI TI OLLEH"
      }}
  """
  @spec get_riddle(String.t()) :: {atom(), map()}
  def get_riddle(endpoint) when is_binary(endpoint) do
    Logger.debug("Calling Riddlebot.get_riddle(#{endpoint})")

    case get(endpoint, []) do
      {:ok, _} = res -> res
      error -> error
    end
  end

  @doc """
  Submmit Riddlebot riddle

  ## Examples

      iex> Exnoops.Riddlebot.submit_riddle("/riddlebot/riddles/Zsy4sdsCuYrIPwbnw5HOowNvsWcxmh_uo31C8tkN4wU", "...")
      {:ok, {:ok, %{
        "result" => "correct",
        "nextRiddlePath" => "/riddlebot/riddles/4LpseM7Yg8_wB0sX50eWCtQLPtassehfrZwjMSGhKLk"
      }}}
  """
  @spec submit_riddle(String.t(), String.t()) :: {atom(), map()}
  def submit_riddle(endpoint, answer) when is_binary(endpoint) do
    Logger.debug("Calling Riddlebot.get_riddle(#{endpoint}, #{answer})")

    case post(endpoint, %{"answer" => answer}) do
      {:ok, %{"result" => "correct"} = value} -> {:ok, {:ok, value}}
      {:ok, value} -> {:ok, {:error, value}}
      error -> error
    end
  end

  @doc """
  Get Riddlebot certificate (assuming to completed the riddles)

  ## Examples

      iex> Exnoops.Riddlebot.get_certificate("/riddlebot/certificate/613oBeHRK_2BzTZ8YgRwxEN-hBxrD1ZOnRspvSuJ4hJks8svZvSBynJ09sOdoFQM")
      {:ok, %{
        "message" => "This certifies that your-login-here completed the Riddlebot challenge.",
        "elapsed" => 1928,
        "completed" => "2019-06-24T22:11:39.231Z"
      }}
  """
  @spec get_certificate(String.t()) :: {atom(), map()}
  def get_certificate(endpoint) when is_binary(endpoint) do
    Logger.debug("Calling Riddlebot.get_certificate(#{endpoint})")

    case get(endpoint, []) do
      {:ok, _} = res -> res
      error -> error
    end
  end
end
