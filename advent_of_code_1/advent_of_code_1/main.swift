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


var puzzleInput = readFile("input_1")
var found = false
for x in puzzleInput {
    for y in puzzleInput {
        for z in puzzleInput {
            if x + y + z == 2020 {
                // okay
                print("The answer is: \(x * y * z)!")
                found = true
                break;
            }
        }
        if found {
            break
        }
    }
    if found {
        break
    }
}
