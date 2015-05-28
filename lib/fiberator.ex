defmodule Fiberator do
  import Fiberator.Fib
  import Fiberator.FibFileCache

  def main(argv) do
    {:ok, cache_pid} = prepare_cache()
    input = request_input()
    result = fib_cache(input, cache_pid)
    IO.write("The fiborator says: #{result}\n")
  end

  defp request_input() do
    IO.gets("Enter integer to fiberate: ") |> process_input
  end

  defp prepare_cache() do
    read_fib_file() |> fib_cache_start
  end

  defp process_input(data) do
    String.strip(data) |> String.to_integer 
  end
end
