local file = io.open("input.txt", "rb")
local content = file:read "*a"
file:close()

local sum = 0
local max = content:len()
for i = 1, max do
	local current = tonumber(content:sub(i, i))
	if i == max then
		if current == tonumber(content:sub(1, 1)) then
			sum = sum + current
		end
	else
		if current == tonumber(content:sub(i + 1, i + 1)) then
			sum = sum + current
		end
	end
end

print(sum)