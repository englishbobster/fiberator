defmodule FibTest do
  use ExUnit.Case
  import Fiberator.Fib

  test "test fib index 0" do
    assert fib_pure(0) == 0
  end

  test "test fib index 1" do
    assert fib_pure(1) == 1
  end

  test "test fib index 2" do
    assert fib_pure(2) == 1
  end

  test "test fib index 3" do
    assert fib_pure(3) == 2
  end

  test "can start and stop a fib agent" do
    {:ok, pid} = fib_cache_start(%{})
    assert Process.alive?(pid)
    fib_cache_stop(pid)
    assert not Process.alive?(pid)
  end

  test "fib agent map is empty for first use" do
    {:ok, pid} = fib_cache_start(%{})
    assert Map.size(get_fib_cache(pid)) == 0
    fib_cache_stop(pid)
    assert not Process.alive?(pid)
  end

  test "can cache a fib value in the agent and retrieve it correctly" do
    {:ok, pid} = fib_cache_start(%{})
    value = fib_cache(3, pid)
    cache = get_fib_cache(pid)
    assert Map.size(cache) == 1
    assert value == 2
    %{3 => value_from_cache} = cache
    assert value_from_cache == value
    fib_cache_stop(pid)
    assert not Process.alive?(pid)
  end

end
