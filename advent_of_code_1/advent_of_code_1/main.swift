//
//  main.swift
//  advent_of_code_1
//
//  Created by skg on 12/1/20.
//
// Shoutout to #macdev on freenode for helping me with getting stuff copied
//

import Foundation

// read input file for puzzle
func readFile(_ path: String) -> [Int] {
    errno = 0
    if freopen(path, "r", stdin) == nil {
        perror(path)
        return []
    }
    var inputArray = [Int]()

    while let line = readLine() {
        inputArray.append(Int(line) ?? 0)
    }
    return inputArray
}

func findPairOne(numbers: [Int], target: Int) -> Int {
    for x in numbers {
        for y in numbers {
            if x + y == target {
                return x * y
            }
        }
    }
    return 0
}

func findPairTwo(numbers: [Int], target: Int) -> Int {
    for x in numbers {
        for y in numbers {
            for z in numbers {
                if x + y + z == target {
                    return x * y * z
                }
            }
        }
    }
    return 0
}
var puzzleInput = readFile("input_1")

print("Part one: \(findPairOne(numbers: puzzleInput, target: 2020))")
print("Part two: \(findPairTwo(numbers: puzzleInput, target: 2020))")
