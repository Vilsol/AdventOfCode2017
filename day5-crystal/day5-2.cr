data = File.read("input.txt")

lines = data.split("\n")

stack = Array(Int32).new

lines.each do |e|
	stack << e.to_i
end

pointer = 0
jumps = 0

while pointer < stack.size
	i = stack[pointer]
	if i >= 3
		stack[pointer] -= 1
	else
		stack[pointer] += 1
	end
	pointer = pointer + i
	jumps += 1
end

puts jumps