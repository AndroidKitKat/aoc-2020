//
//  main.swift
//  advent_of_code_5
//
//  Created by skg on 12/5/20.
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

/// Decodes what row the particular boarding pass corresponds to
/// - Parameter bPassFront: The front section of a boarding pass  (ex. FBFBBFF)
/// - Returns: What row the user should sit in (ex. 44)
func decodeRow(bPassFront: String) -> Int {
    var maxRow = 127
    var lowRow = 0
    for letter in bPassFront {
        switch letter {
            case "F":
                maxRow = Int(floor(Double((lowRow + maxRow) / 2)))
                break
            case "B":
                lowRow = Int(ceil(Double((lowRow + maxRow) / 2)))
            default:
                break
        }
    }
    return maxRow
}

/// Decodes what column the particular boarding pass corresponds to
/// - Parameter bPassBack: The back section of a boarding pass  (ex. RLR)
/// - Returns: What column the user should sit in (ex. 5)
func decodeCol(bPassBack: String) -> Int {
    var maxCol = 7
    var lowCol = 0
    for letter in bPassBack {
        switch letter {
        case "R":
            lowCol = Int(ceil(Double((lowCol + maxCol) / 2)))
            break
        case "L":
            maxCol = Int(floor(Double((lowCol + maxCol) / 2)))
            break
        default:
            break
        }
    }
    return maxCol
}

/// Splits a given boarding pass into the respective sections
/// - Parameter bPass: A singular boarding pass (ex. FBFBBFFRLR)
/// - Returns: The front section and the back section (ex. FBFBBFF, RLR)
func splitBoardingPass(bPass: String) -> (String, String) {
    return (String(bPass.prefix(7)), String(bPass.suffix((3))))
}

/// Finds the seat I am supposed to be sitting in
/// - Parameter boardIds: Array of all boarding pass IDs
/// - Returns: The seat I am supposed to be sitting in
func findMySeat(boardIds: [Int]) -> Int {
    // jank but works
    var sortedSeats = boardIds.sorted()
    let smallestID = sortedSeats[0]
    for i in 0..<boardIds.count {
        sortedSeats[i] = sortedSeats[i] - smallestID + 1 // breaks without this magic number
    }
    
    let seatCount = sortedSeats.count
    let actualTotal = sortedSeats.reduce(0, +)
    let expectedTotal = (seatCount + 1) + seatCount * (seatCount + 1) / 2
    
    return expectedTotal - actualTotal + smallestID - 1// need to account for subtraction
}

var puzzleInput = readFile(path: "input_5")

var seats = [Int]()

for boardingPass in puzzleInput {
    let (passFront, passBack) = splitBoardingPass(bPass: boardingPass)
    let row = decodeRow(bPassFront: passFront)
    let col = decodeCol(bPassBack: passBack)
    let seatId = (row * 8) + col
    seats.append(seatId)
}
print("Part 1: \(seats.max() ?? 0)")

print("Part 2: \(findMySeat(boardIds: seats))")


