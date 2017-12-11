module day1;

import std.range, std.stdio;
import std.regex: split, regex;
import std.math: abs;

void main()
{
    auto file = File("input.txt");
    auto range = file.byLineCopy();
    auto firstLine = range.takeExactly(1).front;
    auto s = split(firstLine, regex(",", "g"));

    auto x = 0.0;
    auto y = 0.0;

    auto furthest = 0.0;

    foreach(command; s){
        switch(command){
            case "n":
                y += 1;
                break;
            case "s":
                y -= 1;
                break;
            case "e":
                x += 1;
                break;
            case "w":
                x -= 1;
                break;
            case "nw":
                x -= 0.5;
                y += 0.5;
                break;
            case "ne":
                x += 0.5;
                y += 0.5;
                break;
            case "sw":
                x -= 0.5;
                y -= 0.5;
                break;
            case "se":
                x += 0.5;
                y -= 0.5;
                break;
            default:
                break;
        }

        auto current = abs(x) + abs(y);

        if(current > furthest){
            furthest = current;
        }
    }

    writeln(furthest);
}