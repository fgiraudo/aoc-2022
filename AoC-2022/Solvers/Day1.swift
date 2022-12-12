//
//  Day1.swift
//  AoC-2022
//
//  Created by Fernando Giraudo on 01.12.22.
//

import Foundation

extension Solver {
    internal final class Day1: PuzzleSolver {
        internal func puzzle1(input: Array<String>) -> Any {
            var maxCalories = 0
            var currentElfCalories = 0
            
            for line in input {
                if line.isEmpty {
                    maxCalories = max(maxCalories, currentElfCalories)
                    currentElfCalories = 0
                    
                    continue
                }
                
                currentElfCalories += Int(line) ?? 0
            }
            
            return maxCalories
        }
        
        internal func puzzle2(input: Array<String>) -> Any {
            var elfCalories = Array<Int>()
            var currentCalories = 0
            
            for line in input {
                if line.isEmpty {
                    elfCalories.append(currentCalories)
                    currentCalories = 0
                    
                    continue
                }
                
                currentCalories += Int(line) ?? 0
            }
            
            elfCalories = elfCalories.sorted().reversed()
            
            return elfCalories[0...2].reduce(0, +)
        }
    }
}
