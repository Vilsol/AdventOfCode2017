use std::io::prelude::*;
use std::io::BufReader;
use std::fs::File;

fn get_input() -> String {
    let file = File::open("input.txt").expect("input.txt not found");
    let buf = BufReader::new(file);

    buf.lines()
        .map(|l| l.expect("Line not parsed"))
        .nth(0).expect("Line not found")
}

fn main() {
    let line = get_input();
    let split: Vec<&str> = line.split('\t').collect();

    let mut seen: Vec<Vec<i32>> = Vec::new();
    let mut state: Vec<i32> = split.iter().map(|l| l.parse::<i32>().unwrap()).collect();

    let mut big_index: i32 = 0;
    let mut big_value: i32 = state[0];

    loop {
        if seen.contains(&state) {
            break;
        }

        big_index = 0;
        big_value = state[0];

        seen.push(state.clone());

        for i in 1..state.len() {
            if state[i] > big_value {
                big_index = i as i32;
                big_value = state[i];
            }
        }

        state[big_index as usize] = 0;

        for i in 1..(big_value + 1) {
            let pos = ((big_index + i) % (state.len() as i32)) as usize;
            state[pos] = state[pos] + 1;
        }
    }

    for i in 1..seen.len() {
        if seen[i] == state {
            print!("{:?}\n", seen.len() - i);
            break;
        }
    }
}