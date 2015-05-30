defmodule FibFileCacheTest do
  use ExUnit.Case
  import Fiberator.FibFileCache

  test "fibcache.txt is created when read for first time" do
    tidy()
    assert not File.exists?("fibcache.txt")
    read_fib_cache_from_file()
    assert File.exists?("fibcache.txt")
    tidy()
  end

  test "fibcache.txt is created when written to for first time" do
    tidy()
    assert not File.exists?("fibcache.txt")
    add_fib_entry_to_file(1, 100)
    assert File.exists?("fibcache.txt")
    tidy()
  end

  test "entry can be made and read back into a map" do
    tidy()
    assert not File.exists?("fibcache.txt")
    add_fib_entry_to_file(1, 100)
    assert read_fib_cache_from_file() == %{1 =>100}
    tidy()
  end

  test "should write entire cache map to file" do
    tidy()
    test_map = %{1 => 100, 2 => 300}
    assert not File.exists?("fibcache.txt")
    write_fib_cache_to_file(test_map)
    assert read_fib_cache_from_file() == test_map
    tidy()
  end

  defp tidy() do
    #tidy up after test
    if (File.exists?("fibcache.txt")) do
      File.rm("fibcache.txt")
    end
    assert not File.exists?("fibcache.txt")
  end

end
