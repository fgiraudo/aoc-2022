//
//  Day2.swift
//  AoC-2022
//
//  Created by Fernando Giraudo on 01.12.22.
//

import Foundation
import SwiftGraph

extension Solver {
    internal final class Day7: PuzzleSolver {
        var dirSizes = [String: Int]()
        
        internal func puzzle1(input: Array<String>) -> Any {
            populateSizes(with: input)
            
            return dirSizes.values.filter { $0 < 100000 }.reduce(0, +)
        }
        
        internal func puzzle2(input: Array<String>) -> Any {
            let usedSpace = dirSizes["./"]!
            let freeSpace = 70000000 - usedSpace
            let requiredSpace = 30000000 - freeSpace
            
            let sortedDictionary = dirSizes.sorted { $0.value < $1.value }
            
            return sortedDictionary.first { $0.value > requiredSpace }!.value
        }
        
        private func populateSizes(with input: Array<String>) {
            var currentDirectory = ""
            
            for line in input {
                if line.isEmpty {
                    while currentDirectory != "" {
                        let size = dirSizes[currentDirectory]!
                        let index = currentDirectory.lastIndex(of: ".")!
                        
                        currentDirectory = String(currentDirectory.prefix(upTo: index))
                        
                        if dirSizes.keys.contains(currentDirectory) {
                            dirSizes[currentDirectory]! += size
                        } else {
                            dirSizes[currentDirectory] = size
                        }
                    }
                    
                    return
                }
                
                if line.contains("$ cd ..") {
                    let size = dirSizes[currentDirectory]!
                    let index = currentDirectory.lastIndex(of: ".")!
                    
                    currentDirectory = String(currentDirectory.prefix(upTo: index))
                    
                    if dirSizes.keys.contains(currentDirectory) {
                        dirSizes[currentDirectory]! += size
                    } else {
                        dirSizes[currentDirectory] = size
                    }
                    
                    continue
                }
                
                if line.contains("$ cd") {
                    let directory = line.substring(fromIndex: 5)
                    currentDirectory += ".\(directory)"
                }
                
                if line.first!.isNumber {
                    let size = Int(line.split(separator: " ").first!)!
                    if dirSizes.keys.contains(currentDirectory) {
                        dirSizes[currentDirectory]! += size
                    } else {
                        dirSizes[currentDirectory] = size
                    }
                }
            }
        }
    }    
}
