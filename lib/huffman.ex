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

  def encode_file(path_to_file, destination_file_name) do
    {bitstring, tree} = Encoder.encode(path_to_file)
    {binary_data, padding} = Binary.serialize_bitstring(bitstring)
    header = %{tree: tree, padding: padding}
    header_binary = :erlang.term_to_binary(header)
    header_size = byte_size(header_binary)
    full_binary = <<header_size::32, header_binary::binary, binary_data::binary>>
    File.write!(destination_file_name, full_binary)
  end

end
