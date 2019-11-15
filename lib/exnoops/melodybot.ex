defmodule Exnoops.Melodybot do
  @moduledoc """
  Module to interact with Github's Noop: Melodybot

  See the [official `noop` documentation](https://noopschallenge.com/challenges/melodybot) for API information including the accepted parameters.
  """

  require Logger
  import Exnoops.API

  @noop "melodybot"

  @doc """
  Query Melodybot for a melody

  ## Examples

      iex> Exnoops.Melodybot.get_melody()
      {:ok, %{
        "generator" => "chaos",
        "stepCount" => 32,
        "key" => %{
          "name" => "A Major", "root" => "A", "relativeMajorRoot" => "A", "type" => "major"
        },
        "notes" => [
          %{
            "start" => 0,
            "duration" => 2,
            "value" => 64,
            "name" => "E4",
            "noteName" => "E",
            "octave" => 4,
            "frequency" => 329.6275569128699
          },
          %{
            "start" => 2,
            "duration" => 1,
            "value" => 59,
            "name" => "B3",
            "noteName" => "B",
            "octave" => 3,
            "frequency" => 246.94165062806206
          },
          %{
            "start" => 17,
            "duration" => 4,
            "value" => 74,
            "name" => "D5",
            "noteName" => "D",
            "octave" => 5,
            "frequency" => 587.3295358348151
          },
          %{
            "start" => 25,
            "duration" => 4,
            "value" => 62,
            "name" => "D4",
            "noteName" => "D",
            "octave" => 4,
            "frequency" => 293.6647679174076
          },
          %{
            "start" => 29,
            "duration" => 2,
            "value" => 57,
            "name" => "A3",
            "noteName" => "A",
            "octave" => 3,
            "frequency" => 220
          },
          %{
            "start" => 31,
            "duration" => 1,
            "value" => 57,
            "name" => "A3",
            "noteName" => "A",
            "octave" => 3,
            "frequency" => 220
          }
        ]
      }}
  """
  @spec get_melody(keyword()) :: {atom(), map()}
  def get_melody(opts \\ []) when is_list(opts) do
    Logger.debug("Calling Melodybot.get_melody()")

    case get("/" <> @noop <> "/random", opts) do
      {:ok, _} = res ->
        res

      error ->
        error
    end
  end

  @doc """
  Get a list of generators

  ## Examples

      iex> Exnoops.Melodybot.get_generators()
      {:ok, [
        %{ "name" => "chaos", "description" => "Chaotic Neutral Melody Generator" },
        %{ "name" => "arpeggio", "description" => "Generate Arpeggios" },
        %{ "name" => "walk", "description" => "Random Walk" }
      ]}
  """
  @spec get_generators :: {atom(), list()}
  def get_generators do
    Logger.debug("Calling Melodybot.get_generators()")

    case get("/" <> @noop <> "/generators", []) do
      {:ok, _} = res ->
        res

      error ->
        error
    end
  end
end
