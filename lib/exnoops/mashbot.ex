defmodule Exnoops.Mashbot do
  @moduledoc """
  Module to interact with Github's Noop: Hexbot

  See the [official `noop` documentation](https://noopschallenge.com/challenges/mashbot) for API information including the accepted parameters.
  """

  require Logger
  import Exnoops.API

  @noop "mashbot"

  @doc """
  Query Mashbot for... well, a mash of responses

  + Parameters are sent with a keyword list into the function.
  + Parameters that accept multiple values should be put into the keyword list like `{:key, [value1, value2]}`. See example below.

  ## Examples

      iex> Exnoops.Mashbot.query()
      {:ok, %{
        "hexbot" => [
          "#E9B104"
        ],
        "directbot" => [
          { :right, 58, 7, nil }
        ],
        "polybot" => [
          [
            {823, 349},
            {812, 405},
            {775, 406},
            {748, 407},
            {724, 427},
            {673, 484},
            {656, 454},
            {648, 407},
            {546, 419},
            {604, 370},
            {529, 337},
            {533, 322},
            {552, 276},
            {581, 255},
            {614, 240},
            {653, 222},
            {692, 186},
            {732, 176},
            {788, 209},
            {768, 253},
            {824, 286},
            {820, 291}
          ]
        ],
        "vexbot" => [
          {
            {65, 197},
            {640, 879},
            57
          }
        ]
      }}
  """
  @spec query(keyword()) :: {atom(), map()}
  def query(opts \\ []) when is_list(opts) do
    Logger.debug("Calling Mashbot.query()")

    case get("/" <> @noop, opts) do
      {:ok, res_map} ->
        {:ok, mash_map_handler(res_map)}

      error ->
        error
    end
  end

  defp mash_map_handler(res_map) when is_map(res_map) do
    res_map
    |> Enum.map(&Task.async(fn -> mash_handler(&1) end))
    |> Enum.map(&Task.await(&1))
    |> Enum.into(%{})
  end

  defp mash_handler({"hexbot" = noop, data}) do
    {noop, for(%{"value" => value} <- data, do: value)}
  end

  defp mash_handler({"directbot" = noop, data}) do
    Enum.map(data, fn line_map ->
      %{
        "direction" => direction,
        "distance" => distance,
        "speed" => speed
      } = line_map

      coordinates =
        Map.get(line_map, "coordinates")
        |> (fn
              %{"a" => %{"x" => a_x, "y" => a_y}, "b" => %{"x" => b_x, "y" => b_y}} ->
                {{a_x, a_y}, {b_x, b_y}}

              nil ->
                nil
            end).()

      {String.to_atom(direction), distance, speed, coordinates}
    end)
    |> (fn new_data -> {noop, new_data} end).()
  end

  defp mash_handler({"polybot" = noop, polygons}) do
    Enum.map(polygons, fn polygon ->
      for(%{"x" => x, "y" => y} <- polygon, do: {x, y})
    end)
    |> (fn new_data -> {noop, new_data} end).()
  end

  defp mash_handler({"vexbot" = noop, vectors}) do
    for(
      %{
        "a" => %{"x" => a_x, "y" => a_y},
        "b" => %{"x" => b_x, "y" => b_y},
        "speed" => speed
      } <- vectors,
      do: {{a_x, a_y}, {b_x, b_y}, speed}
    )
    |> (fn new_data -> {noop, new_data} end).()
  end
end
