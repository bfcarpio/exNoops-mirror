defmodule Exnoops.Hexbot do
  @moduledoc """
  Module to itneract with Github's Noop: Hexbot
  """

  require Logger
  use Exnoops.API

  @noop "hexbot"

  def get_color(opts \\ []) do
    Logger.debug("Calling Hexbot.get_color(#{opts})")

    case get("/" <> @noop, opts) do
      {:ok, res} -> {:ok, Map.fetch!(res, "colors")}
      _ -> {:error, "An error occurred"}
    end
  end
end
