defmodule Fiberator do
  import Fiberator.Fib

  def main(argv) do
     fib_pure(String.to_integer(List.first(argv))) |> IO.write
  end

end
