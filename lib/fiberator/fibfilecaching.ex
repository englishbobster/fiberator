defmodule Fiberator.FibFileCache do

	@doc """
	Reads a file called fibcache.txt, which may contain any saved
	fibonacci calculations. Returns a map of the calculations.
	If the file doesnt exist, the file is created and an empty map is returned.
	"""
	def read_fib_cache_from_file() do
		case File.open("fibcache.txt", [:read, :write], fn file_pid ->
																										read(file_pid) end) do
			{:ok, result} ->
				result
			{:error, reason} ->
				IO.puts("Failed to read file because: #{reason}")
		end
	end

	@doc """
	Appends the result of one fibonacci calculation (n, value) to fibcache.txt.
	"""
	def add_fib_entry_to_file(n, value) do
		case File.open("fibcache.txt", [:append], fn file_pid ->
			 																write_entry(file_pid, n, value) end) do
			{:ok, result} ->
				:ok
			{:error, reason} ->
				IO.puts("Failed to write to file because: #{reason}")
		end
	end

	@doc """
	Writes the entire fib cache to the file fibcache.txt.
	"""
	def write_fib_cache_to_file(cache) do
		if File.exists?("fibcache.txt") do
			File.rm!("fibcache.txt")
		end
			Enum.map(cache, fn {k,v} -> add_fib_entry_to_file(k, v) end)
	end

	defp write_entry(file_pid, n, value) do
		IO.write(file_pid, "#{n} #{value}\n")
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
