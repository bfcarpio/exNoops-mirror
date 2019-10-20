defmodule Exnoops.Vexbot do
  @moduledoc """
  Module to interact with Github's Noop: Vexbot

  See the [official `noop` documentation](https://noopschallenge.com/challenges/vexbot) for API information including accepted paramters.
  """

  require Logger
  import Exnoops.API

  @noop "vexbot"

  @doc """
  Query Vexbot for vector(s)

  + Parameters are sent with a keyword list into the function.

  ## Examples

      iex> Exnoops.Vexbot.get_vector()
      # [{a_x, a_y}, {b_x, b_y}, speed]
      {:ok, [{{743, 147}, {60, 601}, 71}]}

      iex> Exnoops.Vexbot.get_vector(count: 2)
      {:ok, [{{743, 147}, {60, 601}, 71}, {{12, 34}, {56, 78}, 90}]}

  """
  @spec get_vector(keyword()) :: {atom(), list()}
  def get_vector(opts \\ []) when is_list(opts) do
    Logger.debug("Calling Hexbot.get_color()")

    case get("/" <> @noop, opts) do
      {:ok, %{"vectors" => vectors}} ->
        {:ok, format_vectors(vectors)}

      error ->
        error
    end
  end

  def format_vectors(vectors) do
    for(
      %{
        "a" => %{"x" => a_x, "y" => a_y},
        "b" => %{"x" => b_x, "y" => b_y},
        "speed" => speed
      } <- vectors,
      do: {{a_x, a_y}, {b_x, b_y}, speed}
    )
  end
end
