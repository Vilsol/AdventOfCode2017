defmodule Day7 do
	def get_parent(map, child) do
		unless Map.has_key?(map, child) do
			child
		else
			get_parent(map, Map.get(map, child))
		end
	end
end

data = File.read! "input.txt"
lines = String.split(data, ~r{\n}, trim: true)

parents = Enum.reduce(lines, Map.new(), fn(line, parents) ->
	if String.contains?(line, "->") do
		captured = Regex.named_captures(~r{(?<parent>\S+).+->\s?(?<children>.+?)\s?$}, line)
		parent = Map.get(captured, "parent")
		children = Map.get(captured, "children")
		parents = Enum.reduce(String.split(children, ", ", trim: true), parents, fn(child, parents) ->
			Map.put_new(parents, child, parent)
		end)
	end

	parents
end)

current = List.first(Map.keys(parents))
IO.puts(Day7.get_parent(parents, current))