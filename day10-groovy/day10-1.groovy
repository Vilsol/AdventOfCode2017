import java.nio.file.Files
import java.nio.file.Paths
import java.util.stream.Stream

String input = Files.readAllLines(Paths.get("input.txt")).get(0)
List<Integer> lengths = Stream.of(input.split(",")).mapToInt{x -> Integer.parseInt(x as String)}.collect()

int stackSize = 256
int[] stack = [0] * stackSize

for (int i = 0; i < stack.length; i++) {
    stack[i] = i
}

int skip = 0
int current = 0

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

println(stack[0] * stack[1])