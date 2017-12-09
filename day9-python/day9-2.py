with open("input.txt") as f:
	data = f.read()

garbage = False
ignore = False
objects = 0
depth = 1
for i in range(len(data)):
	if ignore:
		ignore = False
		continue

	c = data[i]

	if c == "!":
		ignore = True
	
	elif garbage:
		if c == ">":
			garbage = False
		else:
			objects += 1

	elif c == "<":
		garbage = True

print(objects)