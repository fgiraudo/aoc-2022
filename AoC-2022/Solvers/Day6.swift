//
//  Day2.swift
//  AoC-2022
//
//  Created by Fernando Giraudo on 01.12.22.
//

import Foundation

extension Solver {
    internal final class Day6: PuzzleSolver {
        internal func puzzle1(input: Array<String>) -> Any {
            let signal = input[0]
            var marker = [Character]()
            
            for index in 0 ..< signal.count {
                let char = Character(signal[index])
                
                if marker.contains(char) {
                    while marker[0] != char {
                        marker.removeFirst()
                    }
                    
                    marker.removeFirst()
                    marker.append(char)
                    
                    continue
                }
                
                marker.append(char)
                
                if marker.count == 4 {
                    return index + 1
                }
            }
            
            return 0
        }
        
        internal func puzzle2(input: Array<String>) -> Any {
            let signal = input[0]
            var marker = [Character]()
            
            for index in 0 ..< signal.count {
                let char = Character(signal[index])
                
                if marker.contains(char) {
                    while marker[0] != char {
                        marker.removeFirst()
                    }
                    
                    marker.removeFirst()
                    marker.append(char)
                    
                    continue
                }
                
                marker.append(char)
                
                if marker.count == 14 {
                    return index + 1
                }
            }
            
            return 0
        }
    }    
}
