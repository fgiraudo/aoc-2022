//
//  Day2.swift
//  AoC-2022
//
//  Created by Fernando Giraudo on 01.12.22.
//

import Foundation

extension Solver {
    internal final class Day10: PuzzleSolver {
        var history = [1]

        internal func puzzle1(input: Array<String>) -> Any {
            process(input)
            
            var strength = 0
            
            for cycle in [20, 60, 100, 140, 180, 220] {
                strength += cycle * history[cycle]
            }
            
            return strength
        }
        
        internal func puzzle2(input: Array<String>) -> Any {
            history.removeFirst()
            
            var crt = [[Character]](repeating: [Character](repeating: " ", count: 40), count: 6)
            var row = 0
            
            for index in 0 ..< history.count {
                if [40, 80, 120, 160, 200].contains(index) {
                    row += 1
                }
                
                let middle = history[index]
                
                if [middle - 1, middle, middle + 1].contains(index % 40) {
                    crt[row][index % 40] = "#"
                } else {
                    crt[row][index % 40] = "."
                }
            }
            
            for line in crt {
                print(String(line))
            }
            
            return "ZUPRFECL"
        }
        
        private func process(_ input: Array<String>) {
            var cycle = 1
            var register = 1
            
            for line in input {
                if line.isEmpty {
                    return
                }
                
                if line.split(separator: " ").first == "noop" {
                    cycle += 1
                    history.append(register)
                } else {
                    cycle += 2
                    history.append(register)
                    history.append(register)
                    register += Int(line.split(separator: " ").last!)!
                }
            }
        }
    }    
}
