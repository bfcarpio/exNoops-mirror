defmodule Exnoops.BaseInMemory do
  @moduledoc false

  def get(endpoint, opts) do
    case {endpoint, opts} do
      {"/hexbot", []} -> {:ok, %{"colors" => [%{"value" => "#18453B"}]}}
    end
  end
end
