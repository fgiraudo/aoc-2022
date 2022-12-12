//
//  Day2.swift
//  AoC-2022
//
//  Created by Fernando Giraudo on 01.12.22.
//

import Foundation

extension Solver {
    internal final class Day2: PuzzleSolver {
        let shapeScore = [
            "X": 1,
            "Y": 2,
            "Z": 3
        ]
        
        internal func puzzle1(input: Array<String>) -> Any {
            var totalScore = 0
            
            for var line in input {
                if line.isEmpty {
                    continue
                }
                
                line = line.trimmingCharacters(in: .whitespaces)
                let opponentShape = String(line.prefix(1))
                let myShape = String(line.suffix(1))
                
                totalScore += score(opponentShape: opponentShape, myShape: myShape) + (shapeScore[myShape] ?? -1)
            }
            
            return totalScore
        }
        
        private func score(opponentShape: String, myShape: String) -> Int {
            if opponentShape == "A" {
                switch myShape {
                case "X": return 3
                case "Y": return 6
                case "Z": return 0
                default:
                    assertionFailure("Wrong input")
                    return -1
                }
            }
            
            if opponentShape == "B" {
                switch myShape {
                case "X": return 0
                case "Y": return 3
                case "Z": return 6
                default:
                    assertionFailure("Wrong input")
                    return -1
                }
            }
            
            if opponentShape == "C" {
                switch myShape {
                case "X": return 6
                case "Y": return 0
                case "Z": return 3
                default:
                    assertionFailure("Wrong input")
                    return -1
                }
            }
            
            assertionFailure("Wrong input")
            return -1
        }
        
        internal func puzzle2(input: Array<String>) -> Any {
            var totalScore = 0
            
            for var line in input {
                if line.isEmpty {
                    continue
                }
                
                line = line.trimmingCharacters(in: .whitespaces)
                let opponentShape = String(line.prefix(1))
                let result = String(line.suffix(1))
                
                let myShape = myShape(opponentShape: opponentShape, result: result)
                
                totalScore += score(opponentShape: opponentShape, myShape: myShape) + (shapeScore[myShape] ?? -1)
            }
            
            return totalScore
        }
        
        private func myShape(opponentShape: String, result: String) -> String {
            if opponentShape == "A" {
                switch result {
                case "X": return "Z"
                case "Y": return "X"
                case "Z": return "Y"
                default:
                    assertionFailure("Wrong input")
                    return ""
                }
            }
            
            if opponentShape == "B" {
                switch result {
                case "X": return "X"
                case "Y": return "Y"
                case "Z": return "Z"
                default:
                    assertionFailure("Wrong input")
                    return ""
                }
            }
            
            if opponentShape == "C" {
                switch result {
                case "X": return "Y"
                case "Y": return "Z"
                case "Z": return "X"
                default:
                    assertionFailure("Wrong input")
                    return ""
                }
            }
            
            assertionFailure("Wrong input")
            return ""
        }
    }    
}
