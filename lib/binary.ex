defmodule Huffman.Binary do
  @moduledoc """
  Documentation for `Huffman`.
  """

  @doc """
  Huffman.Binary is responsible for converting the bitstring we get from Huffman encoder to actual bits and then bytes.
  instead of 1s and 0s as characters.

  ## Examples

      iex> Huffman.hello()
      :world

  """
  def serialize_bitstring(bits) do
    {padded_binary, padding} = pad_bits_to_bytes(bits)
    IO.puts("padded=" <> padded_binary)
    bytes = padded_binary |> split_into_bytes() |> bits_to_bytes()
    binary = IO.iodata_to_binary(bytes)
    {binary, padding}
  end

  defp pad_bits_to_bytes(bits) do
    padding_length = rem(8 - rem(String.length(bits), 8), 8)
    padding = String.duplicate("0", padding_length)
    {bits <> padding, padding}
  end
  
  defp split_into_bytes(padded_binary) do
    bytes = String.graphemes(padded_binary)
            |> Enum.chunk_every(8)
            |> Enum.map(fn chunck -> Enum.join(chunck, "") end)
    bytes
  end
end
