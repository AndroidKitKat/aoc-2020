//
//  main.swift
//  advent_of_code_3
//
//  Created by skg on 12/3/20.
//

import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

func readFile(path: String) -> [String] {
    if freopen(path, "r", stdin) == nil {
        perror(path)
        return []
    }
    var inputArray = [String]()
    while let line = readLine() {
        // logic here for splitting the line
        inputArray.append(line)
        }
    return inputArray
}

/// Traverse landscape attempts to run the toboggan down the hill and count how many trees it collides with.
/// - Parameters:
///   - landscape: The puzzle input landscape.
///   - rightMove: Number of spaces right the tobaggan will need to go. Typicall 3.
///   - downMove: Number of spaces down the tobaggan will need to go. Typically 1.
/// - Returns: Numbers of trees hit. Will return 0 upon needing to widen the puzzle
func traverseLandscape(landscape: [String], rightMove: Int, downMove: Int) -> Int {
    var treeCount = 0
    var rightCount = 0
    var downCount = 0
    while downCount < landscape.count {
        if landscape[downCount][rightCount % landscape[downCount].count] == "#" {
            treeCount += 1
        }
        downCount += downMove
        rightCount += rightMove
    }
    return treeCount
}

var puzzleInput = readFile(path: "input_3")

print("Part 1: \(traverseLandscape(landscape: puzzleInput, rightMove: 3, downMove: 1))")
print("""
Part 2: \(
    traverseLandscape(landscape: puzzleInput, rightMove: 1, downMove: 1) *
    traverseLandscape(landscape: puzzleInput, rightMove: 3, downMove: 1) *
    traverseLandscape(landscape: puzzleInput, rightMove: 5, downMove: 1) *
    traverseLandscape(landscape: puzzleInput, rightMove: 7, downMove: 1) *
    traverseLandscape(landscape: puzzleInput, rightMove: 1, downMove: 2)
)
""")
