import java.nio.file.Files
import java.nio.file.Paths

String input = Files.readAllLines(Paths.get("input.txt")).get(0)
char[] chars = input.toCharArray()
List<Integer> lengths = new ArrayList<>()

for (int i = 0; i < chars.length; i++) {
    lengths.add(chars[i] as int)
}

lengths.addAll([17, 31, 73, 47, 23])

int stackSize = 256
int[] stack = [0] * stackSize

for (int i = 0; i < stack.length; i++) {
    stack[i] = i
}

int skip = 0
int current = 0

for (int z = 0; z < 64; z++) {
    for (int i = 0; i < lengths.size(); i++) {
        int length = lengths[i]
        for (int j = 0; j < Math.floor(length / 2 as double); j++) {
            int firstPos = (current + j) % stackSize
            int secondPos = (((current + length) - 1) - j) % stackSize
            int temp = stack[secondPos]
            stack[secondPos] = stack[firstPos]
            stack[firstPos] = temp
        }

        current = (current + length + skip++) % stackSize
    }
}

List<Integer> dense = new ArrayList<>()

for (int i = 0; i < 16; i++) {
    int offset = i * 16
    int res = stack[offset]
    for (int j = offset + 1; j < offset + 16; j++) {
        res = res ^ stack[j]
    }
    dense.add(res)
}

String hexed = ""

for (int i = 0; i < dense.size(); i++) {
    hexed += String.format("%02x", dense[i])
}

println(hexed)