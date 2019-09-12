defmodule Exnoops.Polybot do
  @moduledoc """
  Module to interact with Github's Noop: Polybot

  See the [official `noop` documentation](https://noopschallenge.com/challenges/polybot) for API information including the accepted parameters.
  """

  require Logger
  import Exnoops.API

  @noop "polybot"

  @doc """
  Query Polybot for polygon(s)

  + Parameters are sent with a keyword list into the function.

  ## Examples

      iex> Exnoops.Polybot.get_polygon()
      # List of {x, y} points
      {:ok, [[{157, 998}, {145, 1000}, {122, 1000}, {106, 989}, {151, 972}]]}
  """
  @spec get_polygon(keyword()) :: {atom(), list(list())}
  def get_polygon(opts \\ []) when is_list(opts) do
    Logger.debug("Calling Hexbot.get_color()")

    case get("/" <> @noop, opts) do
      {:ok, %{"polygons" => polygons}} ->
        {:ok,
         for(
           polygon <- polygons,
           do: for(%{"x" => x, "y" => y} <- polygon, do: {x, y})
         )}

      error ->
        error
    end
  end
end
