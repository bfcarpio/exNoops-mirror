defmodule Exnoops.Directbot do
  @moduledoc """
  Module to interact with Github's Noop: Directbot

  See the [official `noop` documentation](https://noopschallenge.com/challenges/directbot) for API information including the accepted parameters
  """

  require Logger
  import Exnoops.API

  @noop "directbot"

  @doc """
  Query Directbot for direction(s)

  + Parameters are sent with a keyword list into the function
  + Returns a list of tuples:
    `{direction, distance, speed, coordinate tuple {{a_x, a_y}, {b_x, b_y}}}`

  ## Examples

      iex> Exnoops.Directbot.get_direction()
      {:ok, [{:up, 96, 97, nil}]}

      iex> Exnoops.Directbot.get_direction([count: 5])
      {:ok, [
        {:down, 73, 58, nil},
        {:right, 58, 69, nil},
        {:down, 42, 12, nil},
        {:right, 51, 84, nil},
        {:down, 35, 14, nil},
      ]}

      # Set max speed and distance
      iex> Exnoops.Directbot.get_direction([count: 5, speed: 5, distance: 10])
      {:ok, [
        {:left, 10, 2, nil},
        {:down, 10, 2, nil},
        {:right, 10, 2, nil},
        {:down, 10,1, nil},
        {:up, 10,4, nil}
      ]}

      iex> Exnoops.Directbot.get_direction([count: 1, connected: 1])
      {:ok, [{:up, 32, 6, {{84,609}, {91,609}}}]}
  """
  @spec get_direction(keyword()) :: {atom(), list()}
  def get_direction(opts \\ []) when is_list(opts) do
    Logger.debug("Calling Directbot.get_direction()")

    case get("/" <> @noop, opts) do
      {:ok, %{"directions" => directions}} ->
        {:ok, format_directions(directions)}

      error ->
        error
    end
  end

  def format_directions(directions) do
    Enum.map(directions, &line_to_tuple/1)
  end

  defp line_to_tuple(line_map) do
    line_map
    |> Map.update("coordinates", nil, fn
      %{"a" => %{"x" => a_x, "y" => a_y}, "b" => %{"x" => b_x, "y" => b_y}} ->
        {{a_x, a_y}, {b_x, b_y}}
    end)
    |> (fn %{
             "direction" => direction,
             "distance" => distance,
             "speed" => speed,
             "coordinates" => coordinates
           } ->
          {String.to_atom(direction), distance, speed, coordinates}
        end).()
  end
end
