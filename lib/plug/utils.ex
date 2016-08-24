defmodule Utils do
  @moduledoc """
  Custom Logger Plug Utility functions
  """

  @spec response_size(%Plug.Conn{}) :: integer
  def response_size(%{request_path: request_path, status: 200, state: :file}) do
    {:ok, stat} = File.stat("./priv/static" <> request_path)
    stat.size
  end
  def response_size(%{resp_body: resp_body, status: 200, state: :set}) do
    resp_body
    |> List.to_string
    |> String.length
  end
  def response_size(_), do: 0

  @spec request_size(%Plug.Conn{}) :: integer
  def request_size(%{req_headers: req_headers}) do
    req_headers
    |> Enum.flat_map(fn({x, y}) -> [x, y] end)
    |> List.to_string
    |> String.length
  end
  def request_size(_), do: 0
end
