defmodule Exnoops.Drumbot do
  @moduledoc """
  Module to interactive with Github's Noop: Drumbot

  See the [official `noop` documentation](https://noopschallenge.com/challenges/drumbot)
  """

  require Logger
  use Exnoops.API

  @noop "drumbot"

  @doc """
  Query Drumbot for patterns

  ## Examples

      iex> Exnoops.Drumbot.get_patterns()
      {:ok,
        [
          "oontza",
          "bossanoopa",
          "nipnop",
          "botthisway",
          "funkee",
          "shlojam",
          "botorik",
          "swoop",
          "schmaltz",
          "bouncy"
        ]
      }

  """
  @spec get_patterns() :: {atom(), list()}
  def get_patterns() do
    Logger.debug("Calling Drumbot.get_patterns()")

    case get("/" <> @noop <> "/patterns", []) do
      {:ok, [_h | _t] = res} ->
        {:ok, Enum.map(res, fn %{"name" => value} -> value end)}

      _ ->
        {:error, "An error occurred"}
    end
  end

  @doc """
  Query Drumbot for a `pattern`'s data

  ## Examples

      iex> Exnoops.Drumbot.get_pattern("nipnop")
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
  """
  @spec get_pattern(String.t()) :: {atom(), keyword()}
  def get_pattern(pattern) when is_binary(pattern) do
    Logger.debug("Calling Drumbot.get_pattern()")

    case get("/" <> @noop <> "/patterns/" <> pattern, []) do
      {:ok, %{"name" => ^pattern} = res} ->
        {:ok, res}

      default ->
        default
    end
  end
end