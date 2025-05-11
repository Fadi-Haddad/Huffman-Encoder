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
      {:ok, content} ->
        count_start_time = System.monotonic_time(:millisecond)

        frequencies =
          content
          |> String.graphemes()
          |> Enum.frequencies()

        count_end_time = System.monotonic_time(:millisecond)
        elapsed_time = count_end_time - count_start_time

        IO.puts("Done in #{elapsed_time} milliseconds")
        frequencies

      {:error, reason} ->
        IO.puts("Failed to count characters: #{inspect(reason)}")
    end
  end
end
