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

end
