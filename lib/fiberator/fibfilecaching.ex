defmodule Fiberator.FibFileCache do

	@doc """
	Reads a file called fibcache.txt, which may contain any saved
	fibonacci calculations. Returns a map of the calculations.
	If the file doesnt exist, the file is created and an empty map is returned.
	"""
	def read_fib_file() do
		case File.open("fibcache.txt", [:read, :write]) do
			{:ok, file_pid} ->
				read(file_pid)
			{:error, reason} ->
				IO.puts("Failed to open file for reading: #{reason}")
		end
	end

	@doc """
	Appends the results of fibonacci calculations (n, value) to fibcache.txt.
	"""
	def add_fib_entry_to_file(n, value) do
		case File.open("fibcache.txt", [:append]) do
			{:ok, file_pid} ->
				IO.write(file_pid, "#{n} #{value}\n")
			{:error, reason} ->
				IO.puts("Failed to open file for writing: #{reason}")
		end
	end

	defp read(file_pid) do
		contents = IO.read(file_pid, :all)
		parse_contents(contents)
	end

	defp parse_contents("") do %{} end
	defp parse_contents(contents) do
		String.strip(contents) |>
		String.split("\n") |>
		Enum.map(&(String.split(&1))) |>
		Enum.map(fn lst -> Enum.map(lst, &(String.to_integer(&1))) end) |>
		Enum.map(&(List.to_tuple(&1))) |>
		Enum.into(%{})
	end

end
