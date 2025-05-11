defmodule Counter do
  @moduledoc """
  Counter Module is responsible for counting the characters inside the file.
  a path to the file should be provided.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Counter.count_from_file("c:/path_to_file.txt")
      %{"." => 11, "1" => 35, "I" => 4, "V" => 4, "O" => 1}

  """
  def count_from_file(path_to_file) do
    case File.read(path_to_file) do
      {:ok, contents} -> contents |> String.graphemes() |> Enum.frequencies()
      {:error, reason } -> IO.puts("Failed to count characters: #{inspect(reason)}")
    end
  end
end
