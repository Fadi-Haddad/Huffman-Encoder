defmodule Huffman do
  @moduledoc """
  Huffman is the public interface to the Huffman compression system.
  This module acts as a facade, exposing high-level functions.

  - Encoding files into Huffman-compressed bitstrings
  - Serializing those bitstrings into binary form
  - Writing the encoded data (including metadata) to disk

  Internally, it delegates to other modules like `Huffman.Encoder` and `Huffman.Binary`
  """

  @doc """
  Encodes the content of the given file using Huffman encoding.

  Returns a tuple `{bitstring, tree}` where:
  - `bitstring` is a string of `"0"` and `"1"` characters
  - `tree` is the Huffman tree used for encoding (needed for decoding)

  ## Examples

      iex> Huffman.encode("path/to/input.txt")
      "0000000100000000010101000100100000000000000010"

  """
  alias Huffman.{Binary, Encoder}

  def encode(path_to_file) do
    Encoder.encode(path_to_file)
  end

  @doc """
  Serializes a bitstring (string of `"0"` and `"1"` characters) into binary format.

  Returns a tuple `{binary, padding}`:
  - `binary`: the actual binary data
  - `padding`: zero-padding added to ensure byte alignment

  ## Examples

      iex> Huffman.serialize_bitstring("010101011010100110")
      {<<85, 169, 128>>, "000000"}

  """
  def serialize_bitstring(bitstring) do
    Binary.serialize_bitstring(bitstring)
  end

  @doc """
    Encodes a file and writes the compressed binary to disk.

    The output file will contain:
    - A 4-byte header size
    - A serialized header (with the Huffman tree and padding)
    - The compressed binary data
    ## Examples

        iex> Huffman.encode_file("input.txt", "output.huff")
        :ok

  """
  def encode_file(path_to_file, destination_file_name) do
    {bitstring, tree} = encode(path_to_file)
    {binary_data, padding} = serialize_bitstring(bitstring)
    header = %{tree: tree, padding: padding}
    header_binary = :erlang.term_to_binary(header)
    header_size = byte_size(header_binary)
    full_binary = <<header_size::32, header_binary::binary, binary_data::binary>>
    File.write!(destination_file_name, full_binary)
  end

end
