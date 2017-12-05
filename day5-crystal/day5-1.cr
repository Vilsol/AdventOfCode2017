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
	stack[pointer] += 1
	pointer = pointer + i
	jumps += 1
end

puts jumps