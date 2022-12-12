//
//  Day2.swift
//  AoC-2022
//
//  Created by Fernando Giraudo on 01.12.22.
//

import Foundation

extension Solver {
    internal final class Day4: PuzzleSolver {
        internal func puzzle1(input: Array<String>) -> Any {
            var result = 0
            
            for line in input {
                if line.isEmpty {
                    break
                }
                
                let pairs = line.split(separator: ",")
                
                let firstSet = set(for: String(pairs.first!))
                let secondSet = set(for: String(pairs.last!))
                
                if firstSet.isSubset(of: secondSet) || secondSet.isSubset(of: firstSet) {
                    result += 1
                }
            }
            
            return result
        }
        
        private func set(for sections: String) -> Set<Int> {
            let constraints = sections.split(separator: "-")
            var result = Set<Int>()
            
            for i in Int(constraints.first!)! ... Int(constraints.last!)! {
                result.insert(i)
            }
            
            return result
        }
            
        internal func puzzle2(input: Array<String>) -> Any {
            var result = 0
            
            for line in input {
                if line.isEmpty {
                    break
                }
                
                let pairs = line.split(separator: ",")
                
                let firstSet = set(for: String(pairs.first!))
                let secondSet = set(for: String(pairs.last!))
                
                if firstSet.intersection(secondSet).count > 0 {
                    result += 1
                }
            }
            
            return result
        }
    }    
}
