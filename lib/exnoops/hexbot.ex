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

  + Parameters are sent with a keyword list into the function.
  + Parameters that accept multiple values should be put into the keyword list like `{:key, [value1, value2]}`. See example below.

  ## Examples

      iex> Exnoops.Hexbot.get_color()
      {:ok, ["#18453B"]}

      iex> Exnoops.Hexbot.get_color([count: 5, seed: ["FF7F50", "FFD700", "FF8C00"]])
      {:ok,
        [
          "#FFBB19",
          "#FF8A0E",
          "#FF8628",
          "#FF9E00",
          "#FF8433"
        ]
      }


  """
  @spec get_color(keyword()) :: {atom(), list()}
  def get_color(opts \\ []) when is_list(opts) do
    Logger.debug("Calling Hexbot.get_color()")

    case get("/" <> @noop, opts) do
      {:ok, %{"colors" => values}} ->
        {:ok, for(%{"value" => value} <- values, do: value)}

      error ->
        error
    end
  end
end
