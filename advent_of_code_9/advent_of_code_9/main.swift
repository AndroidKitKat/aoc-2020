//
//  main.swift
//  advent_of_code_9
//
//  Created by skg on 12/9/20.
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

func searchWindow(dataWindow: [Int], desiredNum: Int) -> Bool {
    for x in dataWindow {
        for y in dataWindow {
            if x + y == desiredNum {
                return true
            }
        }
    }
    return false
}

func stopXMAS(preambleLen: Int, dataStream: [Int]) -> Int {
    var dataWindow = [Int](repeating: 0, count: preambleLen)
    for (i, dataNumber) in dataStream.enumerated() {
        // see if we need to do the compooting
        if i > preambleLen {
            if !searchWindow(dataWindow: dataWindow, desiredNum: dataNumber) {
                return dataNumber
            }
        }
        // put the data in the sliding window
        dataWindow[i % preambleLen] = dataNumber
    }
    return 0
}

func beatXMAS(dataStream: [Int], desiredNum: Int) -> Int {
    for (i, x) in dataStream.enumerated() {
        var beegWindow = [Int]()
        beegWindow.append(x)
        for (j, y) in dataStream.enumerated() where j > i {
            beegWindow.append(y)
            let beegSum = beegWindow.reduce(0, +)
            if beegSum > desiredNum {
                break
            }
            if beegSum == desiredNum {
                return beegWindow.min()! + beegWindow.max()!
            }
        }
    }
    return 0
}

let puzzleInput = readFile(path: "input_9")

let ansOne = stopXMAS(preambleLen: 25, dataStream: puzzleInput)
print("Part 1: \(ansOne)")
print("Part 2: \(beatXMAS(dataStream: puzzleInput, desiredNum: ansOne))")


