defmodule Fiberator do
  import Fiberator.Fib
  import Fiberator.FibFileCache

  def main(argv) do
    {:ok, cache_pid} = prepare_cache()
    result = request_input() |> fib_cache(cache_pid)
    IO.write("The fiborator says: #{result}\n")
    get_fib_cache(cache_pid) |> write_fib_cache_to_file()
    fib_cache_stop(cache_pid)
  end

  defp request_input() do
    IO.gets("Enter integer to fiberate (q to quiterate): ") |> process_input
  end

  defp prepare_cache() do
    read_fib_cache_from_file() |> fib_cache_start
  end

  defp process_input("q\n") do
     Process.exit(self, "quiterated!")
  end
  defp process_input(data) do
    String.strip(data) |> String.to_integer
  end
end
