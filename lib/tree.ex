defmodule Huffman.Tree do
  @moduledoc """
  Documentation for `Huffman`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Huffman.hello()
      :world

  """
  def build_leaves(queue) do
    Enum.map(queue, fn {freq, char} -> %Huffman.Leaf{char: char, freq: freq} end)
  end

  def build_tree([node]), do: node

  def build_tree(nodes) do
    [n1, n2 | rest] = nodes
    merged = %Huffman.Node{freq: n1.freq + n2.freq, left: n1, right: n2}
    build_tree([merged | rest])
  end
end
