//
//  main.swift
//  advent_of_code_7
//
//  Created by skg on 12/7/20.
//

import Foundation


// i love the internet
// https://exceptionshub.com/swift-extract-regex-matches.html
extension String {
  func regex (pattern: String) -> [String] {
    do {
        let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
      let nsstr = self as NSString
      let all = NSRange(location: 0, length: nsstr.length)
      var matches : [String] = [String]()
        regex.enumerateMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: all) {
        (result : NSTextCheckingResult?, _, _) in
        if let r = result {
            let result = nsstr.substring(with: r.range) as String
          matches.append(result)
        }
      }
      return matches
    } catch {
      return [String]()
    }
  }
}

final class Bag {
    var color: String
    var contents: Dictionary<String, Int>
    
    init(color: String, contents: Dictionary<String, Int>) {
        self.color = color
        self.contents = contents
    }
}

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

func parseInput(puzzleInput: [String]) {
    // There are two types of strings
    
    // light red bags contain 1 bright white bag, 2 muted yellow bags.
    // ---------              --------------      --------------
    //   color                        # of other color(s)
    
    // However, there can be a line with a bag that has no contents
    // faded blue bags contain no other bags.
    // ----------              --
    //   color             No contents
    
    // every bag is described with 2 words followed by the word "bag(s)"
    // bags that contain no other bags just have the word "no"
//    let bagColorRegex = NSRegularExpression("^[a-z]* [a-z]*")
//    let bagContentsRegex = NSRegularExpression("[0-9]+ [a-z]* [a-z]*")
    
    var luggageRack = [Bag]()
    
    for rule in puzzleInput {
        let bagColor = rule.regex(pattern: "^[a-z]* [a-z]*")
        let bagContentsArray = rule.regex(pattern: "[0-9]+ [a-z]* [a-z]*")
        var bagContentsDict: Dictionary<String, Int> = [:]
        for bag in bagContentsArray {
            let bagComponents = bag.components(separatedBy: " ")
            let bagContentsCount = bagComponents[0]
            let bagContentsDescriptor = bagComponents[1] + " " + bagComponents[2]
            bagContentsDict[bagContentsDescriptor] = Int(bagContentsCount)
        }
        let newBag = Bag(color: bagColor[0], contents: bagContentsDict)
        luggageRack.append(newBag)
    }
    for bag in luggageRack {
        print("""
Color: \(bag.color)
Contents: \(bag.contents)

""")
    }
}

let puzzleInput = readFile(path: "demo_input_7")
parseInput(puzzleInput: puzzleInput)

//print(puzzleInput)
