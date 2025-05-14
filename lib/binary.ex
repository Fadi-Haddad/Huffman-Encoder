defmodule Huffman.Binary do
  @moduledoc """
  The `Huffman.Binary` module is responsible for serializing a bitstring—represented
  as a string of `"0"` and `"1"` characters—into an actual binary suitable for storage
  or transmission.

  This process includes:
  - Padding the bitstring to ensure it aligns to full bytes (8 bits).
  - Grouping the padded bits into 8-bit chunks.
  - Converting each chunk into its corresponding byte.
  - Returning the final binary along with the padding added, so it can be removed during deserialization.
  """

  @doc """
  Serializes a string of bits (`"0"`s and `"1"`s) into binary format.

  It adds padding if the bitstring length is not a multiple of 8, then converts the bit chunks to bytes.

  ## Examples

      iex> Huffman.Binary.serialize_bitstring("010101011010100110")
      {<<85, 169, 128>>, "000000"}

  ## Returns

  - A tuple `{binary, padding}`:
    - `binary`: the binary representation of the input bits
    - `padding`: the padding string of `"0"`s added to make the length divisible by 8
  """
  def serialize_bitstring(bitstring) do
    {padded_binary, padding} = pad_bits_to_bytes(bitstring)
    bytes = padded_binary |> split_into_bytes() |> serialize_chunks_to_bytes()
    binary = IO.iodata_to_binary(bytes)
    {binary, padding}
  end

  defp pad_bits_to_bytes(bitstring) do
    padding_length = rem(8 - rem(String.length(bitstring), 8), 8)
    padding = String.duplicate("0", padding_length)
    {bitstring <> padding, padding}
  end

  defp split_into_bytes(padded_binary) do
    bytes =
      String.graphemes(padded_binary)
      |> Enum.chunk_every(8)
      |> Enum.map(fn chunck -> Enum.join(chunck, "") end)

    bytes
  end

  defp serialize_chunks_to_bytes(chunks_list) do
    chunks_list |> Enum.map(fn chunck -> <<String.to_integer(chunck, 2)::8>> end)
  end
end
