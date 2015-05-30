defmodule Fiberator do
  import Fiberator.Fib
  import Fiberator.FibFileCache

  def main(argv) do
    {:ok, cache_pid} = prepare_cache()
    input = request_input()
    result = fib_cache(input, cache_pid)
    IO.write("The fiborator says: #{result}\n")
    write_fib_cache_to_file(get_fib_cache(cache_pid))
    fib_cache_stop(cache_pid)

  end

  defp request_input() do
    IO.gets("Enter integer to fiberate: ") |> process_input
  end

  defp prepare_cache() do
    read_fib_cache_from_file() |> fib_cache_start
  end

  defp process_input(data) do
    String.strip(data) |> String.to_integer
  end
end
