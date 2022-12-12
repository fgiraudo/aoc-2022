//
//  Day2.swift
//  AoC-2022
//
//  Created by Fernando Giraudo on 01.12.22.
//

import Foundation

extension Solver {
    internal final class Day3: PuzzleSolver {
        internal func puzzle1(input: Array<String>) -> Any {
            var result = 0
            
            for line in input {
                if line.isEmpty {
                    continue
                }
                
                let halfLength = line.count / 2
                
                let firstContainer = line.prefix(halfLength)
                let secondContainer = line.suffix(halfLength)
                
                let equalChar = equalCharIn([String(firstContainer), String(secondContainer)])
                
                result += priority(equalChar)
            }
            
            return result
        }
        
        private func equalCharIn(_ strings: [String]) -> Character {
            var mutatingStrings = strings
            var result = mutatingStrings.removeFirst().toSet
            
            while !mutatingStrings.isEmpty {
                result = result.intersection(mutatingStrings.removeFirst().toSet)
            }
            
            return result.first!
        }
        
        private func priority(_ char: Character) -> Int {
            let priority = Int(char.asciiValue!)
            
            if char.isUppercase {
                return priority - 38
            } else {
                return priority - 96
            }
        }
        
        internal func puzzle2(input: Array<String>) -> Any {
            var mutatingInput = input
            var total = 0
            
            while !mutatingInput.isEmpty {
                if mutatingInput.count < 3 {
                    break
                }
                
                let strings = Array(mutatingInput[0..<3])
                mutatingInput = Array(mutatingInput.dropFirst(3))
                
                total += priority(equalCharIn(strings))
            }
            
            return total
        }
    }    
}

extension StringProtocol {
    var asciiValues: [UInt8] { compactMap(\.asciiValue) }
    
    var toSet: Set<Character> {
        var result = Set<Character>()
        
        for char in self {
            result.insert(char)
        }
        
        return result
    }
}
