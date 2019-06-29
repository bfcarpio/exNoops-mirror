defmodule Exnoops.Base do
  @moduledoc false

  @base_url "https://api.noopschallenge.com"

  @spec get(String.t(), keyword()) :: {atom(), term()}
  def get(endpoint, opts) do
    Mojito.request(:get, @base_url <> endpoint <> format_opts(opts))
    |> handle_response
  end

  # @spec post(String.t(), keyword()) :: {atom(), term()}
  # def post(endpoint, opts) do
  # end

  defp format_opts([]), do: ""

  defp format_opts(opts) do
    opts
    |> Enum.map(fn k, v -> "$#{k}=#{v}" end)
    |> Enum.join()
  end

  @spec handle_response({atom(), map()}) :: tuple()
  defp handle_response({:error, struct}), do: {:error, "There was an error", struct}

  defp handle_response({:ok, %Mojito.Response{status_code: 200, body: body}}),
    do: {:ok, JSON.decode!(body)}
end
