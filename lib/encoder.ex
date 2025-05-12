defmodule Huffman.Encoder do
  alias Huffman.{Counter, Queue, Tree}
  # import
  @moduledoc """
  Counter Module is responsible for counting the characters inside the file.
  a path to the file should be provided.
  """

  @doc """

  ## Examples

      iex> Counter.count_from_file("c:/path_to_file.txt")
      %{"." => 11, "1" => 35, "I" => 4, "V" => 4, "O" => 1}

  """
  def encode(path_to_file) do
    tree = Counter.count_from_file(path_to_file)
            |> Queue.build_queue()
            |> Tree.build_leaves()
            |> Tree.build_tree()
    tree
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
end
