defmodule Exnoops.Mashbot do
  @moduledoc """
  Module to interact with Github's Noop: Mashbot

  See the [official `noop` documentation](https://noopschallenge.com/challenges/mashbot) for API information including the accepted parameters.
  """

  require Logger
  import Exnoops.API
  import Exnoops.Vexbot, only: [format_vectors: 1]
  import Exnoops.Polybot, only: [format_polygons: 1]
  import Exnoops.Hexbot, only: [format_colors: 1]
  import Exnoops.Directbot, only: [format_directions: 1]

  @noop "mashbot"

  @doc """
  Query Mashbot for... well, a mash of responses

  + Parameters are sent with a keyword list into the function.
  + Parameters that accept multiple values should be put into the keyword list like `{:key, [value1, value2]}`. See example below.

  ## Examples

      iex> Exnoops.Mashbot.query()
      {:ok, %{
        "hexbot" => [
          {"#E9B104", nil}
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
    |> Task.async_stream(&mash_handler/1)
    |> Stream.map(fn {:ok, m} -> m end)
    |> Enum.into(%{})
  end

  defp mash_handler({"hexbot" = noop, colors}) do
    {noop, format_colors(colors)}
  end

  defp mash_handler({"directbot" = noop, directions}) do
    {noop, format_directions(directions)}
  end

  defp mash_handler({"polybot" = noop, polygons}) do
    {noop, format_polygons(polygons)}
  end

  defp mash_handler({"vexbot" = noop, vectors}) do
    {noop, format_vectors(vectors)}
  end
end
