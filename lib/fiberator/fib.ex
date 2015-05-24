defmodule Fiberator.Fib do

	def fib_pure(0), do: 0
	def fib_pure(1), do: 1
	def fib_pure(n) when n > 1 do
		fib_pure(n-1) + fib_pure(n-2)
	end

	def fib_cache_start() do
		Agent.start_link(fn -> %{} end)
	end

	def fib_cache(n, agent) do
		value = Agent.get(agent, fn map -> Map.get(map,n) end)
		if value == nil do
			value = fib_pure(n)
			_ = Agent.update(agent, fn map -> Dict.put_new(map, n, value) end)
		end
		value
	end

	def get_fib_cache(agent) do
		Agent.get(agent, fn map -> map end)
	end

	def fib_cache_stop(agent) do
		Agent.stop(agent)
	end

end
