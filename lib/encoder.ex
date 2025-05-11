defmodule Huffman.Encoder do
  alias Huffman.{Counter, Queue}
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
            # |> Tree.build_leaves()
            # |> Tree.build_tree()

  end
end
