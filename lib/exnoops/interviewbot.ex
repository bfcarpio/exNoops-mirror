defmodule Exnoops.Interviewbot do
  @moduledoc """
  Module to interact with Github's Noop: Interviewbot

  See the [official `noop` documentation](https://noopschallenge.com/challenges/interviewbot) for API information including the accepted parameters.
  """

  require Logger
  import Exnoops.API

  @doc """
  Query Interviewbot for question(s)

  + Parameters are sent with a keyword list into the function.
  + Parameters that accept multiple values should be put into the keyword list like `{:key, [value1, value2]}`. See example below.

  ## Examples

      iex> Exnoops.Interviewbot.query()
      {:ok, %{
        "message" => "Welcome to your interview. Please POST your GitHub login to this URL to get started. See the exampleResponse for more information.",
        "exampleResponse" => %{ "login" => "noops-challenger" }
      }}

      iex> Exnoops.Interviewbot.query("/interviewbot/questions/izZhyS2sCY7kZtZJf8yjizYuMo7zLE0m4Ucom4NeJYc")
      {:ok, %{
        "questionPath" => "/interviewbot/questions/izZhyS2sCY7kZtZJf8yjizYuMo7zLE0m4Ucom4NeJYc",
        "question" => 12111900247,
        "message" => "Find the prime factors of the number 12111900247. The prime factors of a number are the prime numbers that result in the number when multiplied together. The prime factors of 12 would be [2,2,3] because 2 * 2 * 3 = 12.",
        "exampleResponse" => %{
          "answer" => [ 2, 3, 5, 7 ]
        }
      }}
  """
  @spec query(String.t()) :: {atom(), map()}
  def query(endpoint \\ "/interviewbot/start") when is_binary(endpoint) do
    Logger.debug("Calling Interviewbot.query(#{endpoint})")

    case get(endpoint, []) do
      {:ok, _} = res ->
        res

      error ->
        error
    end
  end

  @doc """
  Submit answers to Interviewbot

  ## Exmaples

      iex> Exnoops.Interviewbot.submit("/interviewbot/start", login: "noops-challenger")
      {:ok, %{
        "message" => "Hello noops-challenger, get ready for your interview. Your first question is at /interviewbot/questions/izZhyS2sCY7kZtZJf8yjizYuMo7zLE0m4Ucom4NeJYc",
        "nextQuestion" => "/interviewbot/questions/izZhyS2sCY7kZtZJf8yjizYuMo7zLE0m4Ucom4NeJYc"
      }}
  """
  @spec submit(String.t(), keyword()) :: {atom(), map()}
  def submit(endpoint, body) when is_binary(endpoint) and is_list(body) do
    Logger.debug("Calling Interviewbot.submit()")

    case post(endpoint, body) do
      {:ok, _} = res ->
        res

      error ->
        error
    end
  end
end
