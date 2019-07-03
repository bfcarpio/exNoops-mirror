defmodule Exnoops.BaseInMemory do
  @moduledoc false

  def get(endpoint, opts) do
    case {endpoint, opts} do
      {"/hexbot", []} ->
        {:ok, %{"colors" => [%{"value" => "#18453B"}]}}

      {"/hexbot", [count: 5, seed: ["FF7F50", "FFD700", "FF8C00"]]} ->
        {:ok,
         %{
           "colors" => [
             %{"value" => "#FFBB19"},
             %{"value" => "#FF8A0E"},
             %{"value" => "#FF8628"},
             %{"value" => "#FF9E00"},
             %{"value" => "#FF8433"}
           ]
         }}

      {"/drumbot/patterns", []} ->
        {:ok,
         [
           %{"name" => "oontza"},
           %{"name" => "bossanoopa"},
           %{"name" => "nipnop"},
           %{"name" => "botthisway"},
           %{"name" => "funkee"},
           %{"name" => "shlojam"},
           %{"name" => "botorik"},
           %{"name" => "swoop"},
           %{"name" => "schmaltz"},
           %{"name" => "bouncy"}
         ]}

      {"/drumbot/patterns/nipnop", []} ->
        {:ok,
         %{
           "name" => "nipnop",
           "beatsPerMinute" => 92,
           "stepCount" => 16,
           "tracks" => [
             %{
               "instrument" => "snare",
               "steps" => [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0]
             },
             %{
               "instrument" => "clap",
               "steps" => [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1]
             },
             %{
               "instrument" => "cowbell",
               "steps" => [0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0]
             },
             %{
               "instrument" => "kick",
               "steps" => [1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0]
             }
           ]
         }}

      {"/drumbot/patterns/oontza", []} ->
        {:ok,
         %{
           "beatsPerMinute" => 110,
           "name" => "oontza",
           "stepCount" => 16,
           "tracks" => [
             %{
               "instrument" => "hihat",
               "steps" => [0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1]
             },
             %{
               "instrument" => "snare",
               "steps" => [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0]
             },
             %{
               "instrument" => "kick",
               "steps" => [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]
             }
           ]
         }}

      {"/drumbot/patterns/botorik", []} ->
        {:ok,
         %{
           "beatsPerMinute" => 120,
           "name" => "botorik",
           "stepCount" => 16,
           "tracks" => [
             %{
               "instrument" => "hihat",
               "steps" => [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]
             },
             %{
               "instrument" => "snare",
               "steps" => [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0]
             },
             %{
               "instrument" => "kick",
               "steps" => [1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0]
             },
             %{
               "instrument" => "cowbell",
               "steps" => [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]
             }
           ]
         }}

      {"/drumbot/patterns/NotAPattern", []} ->
        {:error, 404}

      {"/wordbot", []} ->
        {:ok, %{"words" => ["pepperoni"]}}

      {"/wordbot", [count: 7]} ->
        {:ok,
         %{
           "words" => [
             "extracorporeal",
             "behooves",
             "superregionals",
             "stepmother",
             "heckle",
             "clanks",
             "hippest"
           ]
         }}

      {"/wordbot", [count: 4, set: "dinosaurs"]} ->
        {:ok,
         %{
           "words" => [
             "Xixiposaurus",
             "Ischyrosaurus",
             "Crocodylomorph",
             "Tatankaceratops"
           ]
         }}
    end
  end
end
