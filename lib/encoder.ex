defmodule Huffman.Encoder do
  alias Huffman.{Counter, Queue, Tree}
  # import
  @moduledoc """
  Encoder Module is responsible for encoding the file with Huffman encoding.
  a path to the file should be provided.
  """

  @doc """

  ## Examples

      iex> Counter.encode("c:/path_to_file.txt")
      "0000000100000000010101000100100000000000000010"

  """
  def encode(path_to_file) do
    tree =
      Counter.count_from_file(path_to_file)
      |> Queue.build_queue()
      |> Tree.build_leaves()
      |> Tree.build_tree()

    prefix_code = generate_codes(tree)
    strings = File.read!(path_to_file)
    bitstring = generate_bitstring(prefix_code, strings)
    {bitstring, tree}
  end

  def generate_codes(tree) do
    generate_codes(tree, "")
  end

  defp generate_codes(%Huffman.Leaf{char: char}, prefix) do
    %{char => prefix}
  end

  defp generate_codes(%Huffman.Node{left: left, right: right}, prefix) do
    left_codes = generate_codes(left, prefix <> "0")
    right_codes = generate_codes(right, prefix <> "1")

    Map.merge(left_codes, right_codes)
  end

  defp generate_bitstring(prefix_code, strings) do
    bitstring =
      strings
      |> String.graphemes()
      |> Enum.map(fn char -> Map.get(prefix_code, char) end)
      |> Enum.join("")

    bitstring
  end
end
