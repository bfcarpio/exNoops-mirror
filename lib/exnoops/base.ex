defmodule Exnoops.Base do
  @moduledoc false

  require Logger

  @base_url "https://api.noopschallenge.com"

  @spec get(String.t(), keyword()) :: {atom(), term()}
  def get(endpoint, opts) do
    path = @base_url <> endpoint <> format_opts(opts)
    Logger.debug("Performing GET request on #{path}")

    Mojito.request(:get, path)
    |> handle_response
  end

  @spec post(String.t(), keyword()) :: {atom(), term()}
  def post(endpoint, body) do
    path = @base_url <> endpoint
    Logger.debug("Performing POST request on #{path}")

    Mojito.request(:post, path, _headers = [], JSON.encode!(body), _mint_opts = [])
    |> handle_response
  end

  @spec format_opts(list()) :: String.t()
  defp format_opts([]), do: ""

  defp format_opts(opts) do
    opts
    |> Enum.map(fn
      {k, [_h | _t] = list} -> "#{k}=" <> Enum.join(list, ",")
      {k, v} -> "#{k}=#{v}"
    end)
    |> Enum.join("&")
    |> (fn str -> "?" <> str end).()
  end

  @spec handle_response({atom(), map()}) :: tuple()
  defp handle_response({:ok, %Mojito.Response{status_code: 200, body: body}}),
    do: {:ok, JSON.decode!(body)}

  defp handle_response({:ok, %Mojito.Response{status_code: 404}}), do: {:error, 404}

  defp handle_response({:ok, %Mojito.Response{status_code: _status_code, body: body}}),
    do: {:error, JSON.decode!(body)}

  defp handle_response({:error, struct}), do: {:error, struct}
end
