defmodule Huffman do
  @moduledoc """
  Documentation for `Huffman`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Huffman.hello()
      :world

  """
  alias Huffman.{Binary, Encoder}

  def encode(path_to_file) do
    Encoder.encode(path_to_file)
  end

  def serialize_bitstring(bitstring) do
    Binary.serialize_bitstring(bitstring)
  end

end
