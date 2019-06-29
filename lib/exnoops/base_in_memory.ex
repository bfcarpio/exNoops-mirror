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
    end
  end
end
