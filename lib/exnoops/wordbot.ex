defmodule Exnoops.Wordbot do
  @moduledoc """
  Module to interact with Github's Noop: Wordbot

  See the [official `noop` documentation](https://noopschallenge.com/challenges/wordbot) for API information including the accepted parameters
  """

  require Logger
  import Exnoops.API

  @noop "wordbot"

  @doc """
  Query Wordbot for word(s)

  + Parameters are sent with a keyword list into the function

  ## Examples

      iex> Exnoops.Wordbot.get_word()
      {:ok, ["pepperoni"]}

      iex> Exnoops.Wordbot.get_word([count: 7])
      {:ok,
        [
          "extracorporeal",
          "behooves",
          "superregionals",
          "stepmother",
          "heckle",
          "clanks",
          "hippest"
        ]
      }

      iex> Exnoops.Wordbot.get_word([count: 4, set: "dinosaurs"])
      {:ok,
        [
          "Xixiposaurus",
          "Ischyrosaurus",
          "Crocodylomorph",
          "Tatankaceratops"
        ]
      }
  """
  @spec get_word(keyword()) :: {atom(), list()}
  def get_word(opts \\ []) when is_list(opts) do
    Logger.debug("Calling Wordbot.get_word()")

    case get("/" <> @noop, opts) do
      {:ok, %{"words" => value}} -> {:ok, value}
      error -> error
    end
  end

  @doc """
  Query Wordbot for word sets

  ## Examples

      iex> Exnoops.Wordbot.get_word_sets()
      {:ok,
        [
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
        ]}
  """
  @spec get_word_sets() :: {atom(), list()}
  def get_word_sets() do
    Logger.debug("Calling Wordbot.get_word_sets()")

    case get("/" <> @noop <> "/sets", []) do
      {:ok, %{"words" => value}} -> {:ok, value}
      error -> error
    end
  end
end
