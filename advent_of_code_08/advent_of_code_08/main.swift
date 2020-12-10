//
//  main.swift
//  advent_of_code_8
//
//  Created by skg on 12/8/20.
//

import Foundation

final class Console {
//    var visited: Set<Int>
    var operations: Array<(String, Int)>
    
    init(operations: [String]) {
//        self.visited = []
        self.operations = []
        for opPair in operations {
            let opComponents = opPair.components(separatedBy: " ")
            let parsedOperation = (opComponents[0], Int(opComponents[1]) ?? 0)
            self.operations.append(parsedOperation)
        }
    }
    
    
    
    func compute(operations: Array<(String, Int)>) -> Int {
        var visited = Set<Int>()
        var accumulator: Int = 0
        var currentInstruction: Int = 0
        while !visited.contains(currentInstruction) {
            visited.insert(currentInstruction)
            if currentInstruction >= operations.count {
                print("Part 2: \(accumulator)")
                return accumulator
            }
            switch operations[currentInstruction].0 {
            case "acc":
                accumulator += operations[currentInstruction].1
                currentInstruction += 1
                break
            case "jmp":
                currentInstruction += operations[currentInstruction].1
                break
            default:
                currentInstruction += 1
                break
            }
        }
        return accumulator
    }
    
    // allowing my debugger to
    func bruteCompute(operations: Array<(String, Int)>) {
        for (i, operation) in operations.enumerated() {
            var operationsCopy = operations
            switch operation.0 {
            case "nop":
                operationsCopy[i].0 = "jmp"
                _ = self.compute(operations: operationsCopy)
                break
            case "jmp":
                operationsCopy[i].0 = "nop"
                _ = self.compute(operations: operationsCopy)
                break
            default:
                break
            }
        }
    }
}

func readFile(path: String) -> [String] {
    errno = 0
    if (freopen(path, "r", stdin) == nil) {
        perror(path)
        return []
    }
    
    var inputArray = [String]()
    
    while let line = readLine() {
        inputArray.append(line)
    }
    return inputArray
}

let puzzleInput = readFile(path: "input_8")
let demoConsole = Console(operations: puzzleInput)
print("Part 1: \(demoConsole.compute(operations: demoConsole.operations))")
demoConsole.bruteCompute(operations: demoConsole.operations)

