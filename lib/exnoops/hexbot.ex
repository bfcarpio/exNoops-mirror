defmodule Exnoops.Hexbot do
  @moduledoc """
  Module to interact with Github's Noop: Hexbot

  See the [official `noop` documentation](https://noopschallenge.com/challenges/hexbot) for API information including the accepted parameters.
  """

  require Logger
  import Exnoops.API

  @noop "hexbot"

  @doc """
  Query Hexbot for color(s)
  + Parameters that accept multiple values should be put into the keyword list like `{:key, [value1, value2]}`. See example below.

  ## Examples

      iex> Exnoops.Hexbot.get_color()
      {:ok, [{"#18453B", nil}]}

      iex> Exnoops.Hexbot.get_color([count: 5, seed: ["FF7F50", "FFD700", "FF8C00"]])
      {:ok,
        [
          {"#FFBB19", nil},
          {"#FF8A0E", nil},
          {"#FF8628", nil},
          {"#FF9E00", nil},
          {"#FF8433", nil}
        ]
      }

      iex> Exnoops.Hexbot.get_color([count: 5, width: 1000, height: 1000])
      {:ok,
        [
          {"#2E84C5", {755, 331}},
          {"#116BAA", {52, 998}},
          {"#C742B2", {617, 478}},
          {"#4C2BB9", {13, 183}},
          {"#0C98FB", {604, 507}}
        ]
      }


  """
  @spec get_color(keyword()) :: {atom(), list()}
  def get_color(opts \\ []) when is_list(opts) do
    Logger.debug("Calling Hexbot.get_color()")

    case get("/" <> @noop, opts) do
      {:ok, %{"colors" => colors}} ->
        {:ok, format_colors(colors)}

      error ->
        error
    end
  end

  def format_colors(colors) do
    colors
    |> Enum.map(fn
      %{"value" => value, "coordinates" => %{"x" => x, "y" => y}} -> {value, {x, y}}
      %{"value" => value} -> {value, nil}
    end)
  end
end
