defmodule Exnoops.Hexbot do
  @moduledoc """
  Module to interact with Github's Noop: Hexbot
  """

  require Logger
  use Exnoops.API

  @noop "hexbot"

  @doc """
  Query Hexbot for color(s)

  See the [official `noop` documentation](https://noopschallenge.com/challenges/hexbot) for the most information on the bot

  Returns a tuple with `{:ok, response}` or `{:error, message}`

  ## Examples

      iex> Exnoops.Hexbot.get_color()
      {:ok, [%{"value" => "#18453B"}]}

  """
  @spec get_color(keyword()) :: {atom(), list()}
  def get_color(opts \\ []) do
    Logger.debug("Calling Hexbot.get_color(#{opts})")

    case get("/" <> @noop, opts) do
      {:ok, res} -> {:ok, Map.fetch!(res, "colors")}
      _ -> {:error, "An error occurred"}
    end
  end
end
