//
//  main.swift
//  advent_of_code_2
//
//  Created by skg on 12/2/20. 🎂🎉🥳
//

import Foundation

// https://yld.moe/mJm
extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

class inputEntry {
    var startingNum: Int
    var endingNum: Int
    var character: Character
    var password: String
    
    init(s: Int, e: Int, c: Character, p: String) {
        self.startingNum = s
        self.endingNum = e
        self.character = c
        self.password = p
    }
}

func readFile(_ path: String) -> [inputEntry] {
    errno = 0
    if freopen(path, "r", stdin) == nil {
        perror(path)
        return []
    }
    var inputArray = [inputEntry]()
//    let entry = inputEntry(s: 1, e: 2, c: "df", p: "sdf")
    while let line = readLine() {
        // logic here for splitting the line
        let items = line.components(separatedBy: " ")
        let nums = items[0].components(separatedBy: "-")
        let letter = Character(String(items[1].dropLast()))
        let entry = inputEntry(s: Int(nums[0]) ?? 0, e: Int(nums[1]) ?? 0, c: letter, p: items[2])
        inputArray.append(entry)
    }
    return inputArray
}

// because there's no xor operator
func xor(a: Bool, b: Bool) -> Bool {
    return (a && !b) || (!a && b)
}

// part 1
func checkPassword(password: inputEntry) -> Bool {
    var count = 0
    for char in password.password {
        if char == password.character {
            count += 1
        }
    }
    if count >= password.startingNum && count <= password.endingNum {
        return true
    }
    return false
}

// part two
func checkPasswordHarder(password: inputEntry) -> Bool {
    if xor(a: password.password[password.startingNum - 1] == password.character, b: password.password[password.endingNum - 1] == password.character) {
        return true
    }
    return false
}

var puzzleInput = readFile("input_2")

var partOneCount = 0
var partTwoCount = 0
for input in puzzleInput {
    if checkPassword(password: input) {
        partOneCount += 1
    }
    if checkPasswordHarder(password: input) {
        partTwoCount += 1
    }
}

print("Part 1: \(partOneCount)")
print("Part 2: \(partTwoCount)")
