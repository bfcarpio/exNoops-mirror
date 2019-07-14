defmodule Exnoops.API.Http do
  @moduledoc false
  @behaviour Exnoops.API.Behaviour

  @impl Exnoops.API.Behaviour
  def http_get(url) when is_binary(url) do
    Mojito.get(url)
  end

  @impl Exnoops.API.Behaviour
  def http_post(url, body) when is_binary(url) and is_binary(body) do
    Mojito.post(url, _header = [], body, _opts = [])
  end
end
