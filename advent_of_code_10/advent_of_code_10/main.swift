//
//  main.swift
//  advent_of_code_10
//
//  Created by skg on 12/10/20.
//

import Foundation

func readFile(path: String) -> [Int] {
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

func findJoltDiff(jDiff: Int, joltAdapters: [Int]) -> Int {
    // sort and make 0 and the max+3 the first and last elements of the array
    var sortedAdapters = joltAdapters.sorted()
    sortedAdapters.insert(0, at: 0)
    sortedAdapters.append(sortedAdapters.max()! + 3)
    var joltDiffs = [Int]()
    var currJoltDiff: Int = 0
    for i in 0..<sortedAdapters.count {
        joltDiffs.append(sortedAdapters[i] - currJoltDiff)
        currJoltDiff = sortedAdapters[i]
    }
    return joltDiffs.filter( { $0 == jDiff } ).count
}

func findAdapterCombos(joltAdapters: [Int]) -> Int {
    var sortedAdapters = joltAdapters.sorted()
//    sortedAdapters.insert(0, at: 0)
    sortedAdapters.append(sortedAdapters.max()! + 3)
    var adapterCombos: Dictionary<Int, Int> = [0:1]
    
    for adapter in sortedAdapters {
        var runningTotal: Int = 0
        for i in 1...3 {
            runningTotal += adapterCombos[adapter - i, default: 0]
        }
        adapterCombos[adapter] = runningTotal
    }
    return adapterCombos[sortedAdapters.max()!]!
}

let puzzleInput = readFile(path: "input_10")

print("Part 1: \(findJoltDiff(jDiff: 1, joltAdapters: puzzleInput) * findJoltDiff(jDiff: 3, joltAdapters: puzzleInput))")
print("Part 2: \(findAdapterCombos(joltAdapters: puzzleInput))")
