//
//  main.swift
//  advent_of_code_4
//
//  Created by skg on 12/4/20.
//

import Foundation

/*
 byr (Birth Year)
 iyr (Issue Year)
 eyr (Expiration Year)
 hgt (Height)
 hcl (Hair Color)
 ecl (Eye Color)
 pid (Passport ID)
 cid (Country ID)
 */
class Passport {
    var data = Dictionary<String, String>()

    var byr, iyr, eyr, hgt, hcl, ecl, pid, cid: String
    
    init() {
        self.byr = ""
        self.iyr = ""
        self.eyr = ""
        self.hgt = ""
        self.hcl = ""
        self.ecl = ""
        self.pid = ""
        self.cid = ""
    }
    
    func setAttribute(atrib: String, value: String) {
        self.data[atrib] = value
    }
    
    func setEntries() {
        self.byr = self.data["byr"] ?? ""
        self.iyr = self.data["iyr"] ?? ""
        self.eyr = self.data["eyr"] ?? ""
        self.hgt = self.data["hgt"] ?? ""
        self.hcl = self.data["hcl"] ?? ""
        self.ecl = self.data["ecl"] ?? ""
        self.pid = self.data["pid"] ?? ""
        self.cid = self.data["cid"] ?? ""
    }
    
    func validatePassportPartOne() -> Bool{
        if self.byr == "" {
            return false
        } else if self.iyr == "" {
            return false
        } else if self.eyr == "" {
            return false
        } else if self.hgt == "" {
            return false
        } else if self.hcl == "" {
            return false
        } else if self.ecl == "" {
            return false
        } else if self.pid == "" {
            return false
        }
        return true
    }
    
    func validatePassportPartTwo() -> Bool{
        if self.byr == "" {
            return false
        } else if self.iyr == "" {
            return false
        } else if self.eyr == "" {
            return false
        } else if self.hgt == "" {
            return false
        } else if self.hcl == "" {
            return false
        } else if self.ecl == "" {
            return false
        } else if self.pid == "" {
            return false
        }
        return validByr() && validIyr() && validEyr() && validHgt() && validHcl() && validEcl() && validPid()
    }
    
    func validByr() -> Bool {
        let intByr = Int(self.byr) ?? 0
        return intByr >= 1920 && intByr <= 2002
    }
    
    func validIyr() -> Bool {
        let intIyr = Int(self.iyr) ?? 0
        return intIyr >= 2010 && intIyr <= 2020
    }
    
    func validEyr() -> Bool {
        let intEyr = Int(self.eyr) ?? 0
        return intEyr >= 2020 && intEyr <= 2030
    }
    
    func validHgt() -> Bool {
        let unit = self.hgt.suffix(2)
        let intHgt = Int(self.hgt.dropLast(2)) ?? 0
        if unit == "in" {
            return intHgt >= 59 && intHgt <= 76
        } else {
            return intHgt >= 150 && intHgt <= 193
        }
    }
    
    func validHcl() -> Bool {
        return self.hcl.range(of: #"^#[a-f0-9]{6}$"#, options: .regularExpression) != nil
    }
    
    func validEcl() -> Bool {
        return self.ecl.range(of: #"(amb|blu|brn|gry|grn|hzl|oth)"#, options: .regularExpression) != nil
    }
    
    func validPid() -> Bool {
        return self.pid.range(of: #"^\d{9}$"#, options: .regularExpression) != nil
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

func parseInput(input: [String]) -> [Passport] {
    var passports = [Passport]()
    var fullEntry = ""
    for line in input {
        if line == "" { // if we hit an empty line we have completed a line
            let derpEntry = fullEntry.components(separatedBy: " ")
            let parsedEntry = derpEntry.filter({ $0.count > 0 }).map({ $0.components(separatedBy: ":") })
            let newPassport = Passport()
            for attribute in parsedEntry {
                newPassport.setAttribute(atrib: attribute[0], value: attribute[1])
            }
            newPassport.setEntries()
            passports.append(newPassport)
            fullEntry = ""
        }
        fullEntry +=  " " + line
    }
    return passports
}

var puzzleInput = readFile(path: "input_4")

var parsedPassports = parseInput(input: puzzleInput)

var countOne: Int = 0
var countTwo: Int = 0
for passport in parsedPassports where passport.validatePassportPartOne() {
    countOne += 1
}
for passport in parsedPassports where passport.validatePassportPartTwo() {
    countTwo += 1
}
print("Part 1: \(countOne)")
print("Part 2: \(countTwo)")
