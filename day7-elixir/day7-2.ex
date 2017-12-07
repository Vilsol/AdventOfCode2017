defmodule Day7 do
	def get_parent(map, child) do
		unless Map.has_key?(map, child) do
			child
		else
			get_parent(map, Map.get(map, child))
		end
	end

	def calculate_values(reverse_parents, values, parent, full_values) do
		if Map.has_key?(reverse_parents, parent) do
			full_value = Enum.reduce(Map.get(reverse_parents, parent), {0, full_values}, fn(child, data) ->
				result = calculate_values(reverse_parents, values, child, elem(data, 1))
				{elem(data, 0) + elem(result, 0), elem(result, 1)}
			end)

			full_values = Map.put_new(elem(full_value, 1), parent, Map.get(values, parent) + elem(full_value, 0))

			{Map.get(values, parent) + elem(full_value, 0), full_values}
		else
			full_values = Map.put_new(full_values, parent, Map.get(values, parent))

			{Map.get(values, parent), full_values}
		end
	end

	def find_incorrect(reverse_parents, parent, full_values) do
		if Map.has_key?(reverse_parents, parent) do
			child_value_counts = Enum.reduce(Map.get(reverse_parents, parent), Map.new(), fn(child, child_value_counts) ->
				Map.update(child_value_counts, Map.get(full_values, child), 1, fn(val) -> val + 1 end)
			end)

			is_invalid = Enum.member?(Map.values(child_value_counts), 1)

			if is_invalid do
				invalid_value = elem(Enum.find(child_value_counts, fn(x) -> elem(x, 1) == 1 end), 0)
				invalid_child = Enum.find(Map.get(reverse_parents, parent), fn(child) -> Map.get(full_values, child) == invalid_value end)

				find_incorrect(reverse_parents, invalid_child, full_values)
			else
				parent
			end
		end
	end

	def get_correct_value(reverse_parents, parents, element, full_values, values) do
		parent = Map.get(parents, element)
		children = Map.get(reverse_parents, parent)
		filtered = Enum.filter(children, fn(x) -> x != element end)
		target_value = Map.get(full_values, List.first(filtered))
		Map.get(values, element) + (target_value - Map.get(full_values, element))
	end
end

data = File.read! "input.txt"
lines = String.split(data, ~r{\n}, trim: true)

reverse_parents = Enum.reduce(lines, Map.new(), fn(line, reverse_parents) ->
	if String.contains?(line, "->") do
		captured = Regex.named_captures(~r{(?<parent>\S+).+->\s?(?<children>.+?)\s?$}, line)
		parent = Map.get(captured, "parent")
		children = Map.get(captured, "children")
		reverse_parents = Map.put_new(reverse_parents, parent, String.split(children, ", ", trim: true))
	end

	reverse_parents
end)

values = Enum.reduce(lines, Map.new(), fn(line, values) ->
	captured = Regex.named_captures(~r{(?<element>\S+)\s?\((?<value>[0-9]+)\)}, line)
	element = Map.get(captured, "element")
	value = Map.get(captured, "value")
	Map.put_new(values, element, elem(Integer.parse(value), 0))
end)

parents = Enum.reduce(Map.keys(reverse_parents), Map.new(), fn(parent, parents) ->
	Enum.reduce(Map.get(reverse_parents, parent), parents, fn(child, parents) ->
		Map.put_new(parents, child, parent)
	end)
end)

current = List.first(Map.keys(parents))
root = Day7.get_parent(parents, current)

full_values = elem(Day7.calculate_values(reverse_parents, values, root, Map.new()), 1)

incorrect = Day7.find_incorrect(reverse_parents, root, full_values)

correct_value = Day7.get_correct_value(reverse_parents, parents, incorrect, full_values, values)

IO.puts(correct_value)