defmodule Exnoops.Chartbot do
  @moduledoc """
  Module to interact with Github's Noop => Chartbot

  See the [official `noop` documentation](https://noopschallenge.com/challenges/chartbot) for API information including the accepted parameters.
  """
  require Logger
  import Exnoops.API

  @noop "chartbot"

  @doc """
  Query Chartbot for chart(s)

  + Parameters are sent with a keyword list into the function.

  ## Examples

      iex> Exnoops.Chartbot.get_chart()
      {:ok, %{
        "title" => "Performance By Region",
        "datasets" => [
          {"El Monte, California", 901},
          {"South Bend, Indiana", 352},
          {"Lawrence, Indiana", 913}
        ],
        "type" => "pie"
      }}

      iex> Exnoops.Chartbot.get_chart(type: "pie")
      {:ok, %{
        "title" => "Median Mood",
        "datasets" => [
          {"enthralled", 1345},
          {"supported", 528},
          {"not", 748},
          {"irritated", 1625},
          {"astonished", 418}
        ],
        "type" => "pie"
      }}

      iex> Exnoops.Chartbot.get_chart(type: "time")
      {:ok, %{
        "title" => "Weekly Most Desirable Occupations Report",
        "interval" => "week",
        "periods" => [
          "2019-04-28",
          "2019-05-05",
          "2019-05-12",
          "2019-05-19",
          "2019-05-26",
          "2019-06-02",
          "2019-06-09",
          "2019-06-16",
          "2019-06-23",
          "2019-06-30"
        ],
        "datasets" => [
          %{
            "name" => "radiologic technician",
            "data" => [
              {"2019-04-28", 331},
              {"2019-05-05", 332},
              {"2019-05-12", 356},
              {"2019-05-19", 381},
              {"2019-05-26", 373},
              {"2019-06-02", 361},
              {"2019-06-09", 373},
              {"2019-06-16", 368},
              {"2019-06-23", 371},
              {"2019-06-30", 361}
            ]
          },
          %{
            "name" => "choreographer",
            "data" => [
              {"2019-04-28", 355},
              {"2019-05-05", 413},
              {"2019-05-12", 464},
              {"2019-05-19", 498},
              {"2019-05-26", 495},
              {"2019-06-02", 534},
              {"2019-06-09", 539},
              {"2019-06-16", 516},
              {"2019-06-23", 477},
              {"2019-06-30", 429}
            ]
          },
          %{
            "name" => "paperhanger",
            "data" => [
              {"2019-04-28", 193},
              {"2019-05-05", 170},
              {"2019-05-12", 152},
              {"2019-05-19", 151},
              {"2019-05-26", 145},
              {"2019-06-02", 144},
              {"2019-06-09", 145},
              {"2019-06-16", 148},
              {"2019-06-23", 150},
              {"2019-06-30", 141}
            ]
          },
          %{
            "name" => "printing press operator",
            "data" => [
              {"2019-04-28", 199},
              {"2019-05-05", 224},
              {"2019-05-12", 228},
              {"2019-05-19", 246},
              {"2019-05-26", 262},
              {"2019-06-02", 286},
              {"2019-06-09", 311},
              {"2019-06-16", 344},
              {"2019-06-23", 346},
              {"2019-06-30", 363}
            ]
          }
        ],
        "type" => "time"
      }}
  """
  @spec get_chart(keyword()) :: {atom(), map()}
  def get_chart(opts \\ []) when is_list(opts) do
    Logger.debug("Calling Chartbot.get_chart()")

    case get("/" <> @noop, opts) do
      {:ok, %{"type" => "time"} = time_res} -> {:ok, reformat_time(time_res)}
      {:ok, %{"type" => "pie"} = pie_res} -> {:ok, reformat_pie(pie_res)}
      error -> error
    end
  end

  defp reformat_time(time_res) when is_map(time_res) do
    %{
      "title" => _,
      "interval" => _,
      "periods" => _,
      "datasets" => datasets,
      "type" => "time"
    } = time_res

    %{
      time_res
      | # TODO: Cleanup / Optimize
        "datasets" =>
          Enum.map(datasets, fn %{"name" => _, "data" => data} = dataset ->
            %{
              dataset
              | "data" =>
                  for(%{"period" => period, "value" => value} <- data, do: {period, value})
            }
          end)
    }
  end

  defp reformat_pie(pie_res) when is_map(pie_res) do
    %{
      "title" => _,
      "datasets" => datasets,
      "type" => "pie"
    } = pie_res

    %{
      pie_res
      | "datasets" => for(%{"name" => name, "value" => value} <- datasets, do: {name, value})
    }
  end
end
