
defmodule Huffman.Queue do
  @moduledoc """
  Documentation for `Huffman.Queue`.
  """

  @doc """

  ## Examples

      iex> Huffman.hello()
      :world

  """
  def build_queue(map) do
    map |> Enum.map(fn {k, v} -> {v, k} end) |> sort()

  end
  defp sort(queue) do
    Enum.sort_by(queue, fn {freq, _} -> freq end)
  end
end
