defmodule Exnoops.Sortbot do
  @moduledoc """
  Module to interact with Github's Noop: Sortbot

  See the [official `noop` documentation](https://noopschallenge.com/challenges/sortbot) for API information including the accepted parameters.
  """

  require Logger
  import Exnoops.API

  @noop "sortbot"

  @doc """
  Query Sortbot for welcome

  ## Examples

      iex> Exnoops.Sortbot.welcome()
      {:ok, "Hello there, welcome to the Sortbot. Get started at /sortbot/exam"}
  """
  @spec welcome :: {atom(), String.t()}
  def welcome do
    Logger.debug("Calling Sortbot.welcome()")

    case get("/" <> @noop, []) do
      {:ok, %{"message" => value}} -> {:ok, value}
      error -> error
    end
  end

  @doc """
  Submit responses to Sortbot

  ## Examples

      iex> Exnoops.Sortbot.submit("/sortbot/exam/start", login: "test")
      {:ok, %{
        "message" => "Hello test, get ready for all sorts of fun. Get it?",
        "nextSet" => "/sortbot/exam/3qm7iTRNtpn8NIUqtBubvQ"
      }}

      iex> Exnoops.Sortbot.submit("/sortbot/exam/3qm7iTRNtpn8NIUqtBubvQ", solution: [32, 35, 40, 46, 52, 53, 73, 80, 95, 96])
      {:ok, %{
        "result" => "success",
        "message" => "Great job!",
        "elapsed" => 0,
        "nextSet" => "/sortbot/exam/6YXxoDcJDtzp8Aj3iY0W0A"
      }}
  """
  @spec submit(String.t(), keyword()) :: {atom(), map()}
  def submit(path, body) when is_binary(path) and is_list(body) do
    Logger.debug("Calling Sortbot.submit()")

    case post(path, body) do
      {:ok, _} = res ->
        res

      error ->
        error
    end
  end
end
