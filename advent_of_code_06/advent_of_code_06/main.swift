//
//  main.swift
//  advent_of_code_6
//
//  Created by skg on 12/6/20.
//

import Foundation

func readFile(path: String) -> [String] {
    errno = 0
    if freopen(path, "r", stdin) == nil {
        perror(path)
        return []
    }
    
    var inputArray = [String]()
    
    while let line = readLine() {
        inputArray.append(line)
    }
    
    return inputArray
}

/// Splits the entire input into being seperate groups
/// - Parameter input: The puzzle input (ex. ["abc", "", "a" , "b", "c"])
/// - Returns: An array of an arrays containing the groups (ex. [["abc"], ["a","b","c"]])
func splitGroups(input: [String]) -> [[String]] {
    var groupedInput = [String]()
    var splitInput = [[String]]()
    
    for entry in input {
        if entry == "" {
            splitInput.append(groupedInput)
            groupedInput = [String]()
            continue
        }
        groupedInput.append(entry)
    }
    return splitInput
}

/// Counts all the unique "yes" votes
/// - Parameter group: A group of votes
/// - Returns: The number of all unique yes votes
func countAllYesVotes(group: [String]) -> Int {
    var groupSet: Set<Character> = []
    
    // turn the given array to a single sting
    let groupString = group.joined()
    
    for letter in groupString {
        groupSet.insert(letter)
    }
    
    return groupSet.count
}

/// Counts all the votes that everyone in the group agrees on
/// - Parameter group: A group of votes
/// - Returns: The number of votes everyone agrees on
func countGroupYesVotes(group: [String]) -> Int {
    var groupDict: Dictionary<Character, Int> = [:]
    
    for person in group {
        for vote in person {
            groupDict[vote, default: 0] += 1
        }
    }
    
    var count = 0
    for (_, v) in groupDict where v == group.count {
        count += 1
    }
    return count
}

let puzzleInput = splitGroups(input: readFile(path: "input_6"))

print("Part 1: \(puzzleInput.reduce(0, { $0 + countAllYesVotes(group: $1) }))")
print("Part 2: \(puzzleInput.reduce(0, { $0 + countGroupYesVotes(group: $1)}))")
