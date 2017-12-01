local file = io.open("input.txt", "rb")
local content = file:read "*a"
file:close()

local sum = 0
local max = content:len()
local halfway = max / 2
for i = 1, max do
	local current = tonumber(content:sub(i, i))
	local target = i + halfway
	target = ((target - 1) % max) + 1
	if current == tonumber(content:sub(target, target)) then
		sum = sum + current
	end
end

print(sum)