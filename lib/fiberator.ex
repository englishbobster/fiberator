defmodule Fiberator do
  import Fiberator.Fib
  import Fiberator.FibFileCache

  def main(argv) do
    {:ok, cache_pid} = prepare_cache()
    handle_input(cache_pid)
  end

  defp handle_input(cache_pid) do
    result = request_input(cache_pid) |> fib_cache(cache_pid)
    IO.write("The fiborator says: #{result}\n")
    handle_input(cache_pid)
  end

  defp request_input(cache_pid) do
    IO.gets("Enter integer to fiberate (q to quiterate): ")
    |> process_input(cache_pid)
  end

  defp prepare_cache() do
    read_fib_cache_from_file() |> fib_cache_start
  end

  defp process_input("q\n", cache_pid) do
    handle_shutdown(cache_pid)
    Process.exit(self, "quiterated!")
  end
  
  defp process_input(data, _) do
    if is_numeric(data) do
      String.strip(data) |> String.to_integer
    else
      IO.write("Unrecognized input, possibly not an integer.")
      0
    end
  end

  defp is_numeric(data) do
    String.match?(data, ~r{^[0-9]+$})
  end

  defp handle_shutdown(cache_pid) do
    get_fib_cache(cache_pid) |> write_fib_cache_to_file()
    fib_cache_stop(cache_pid)
  end

end
