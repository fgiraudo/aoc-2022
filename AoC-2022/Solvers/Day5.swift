//
//  Day2.swift
//  AoC-2022
//
//  Created by Fernando Giraudo on 01.12.22.
//

import Foundation

extension Solver {
    internal final class Day5: PuzzleSolver {
        internal func puzzle1(input: Array<String>) -> Any {
            var stacks = stacks(input)
            let instructions = instructions(input)
            
            for instruction in instructions {
                stacks = execute9000(instruction, on: stacks)
            }
            
            return topRow(for: stacks)
        }
        
        internal func puzzle2(input: Array<String>) -> Any {
            var stacks = stacks(input)
            let instructions = instructions(input)
            
            for instruction in instructions {
                stacks = execute9001(instruction, on: stacks)
            }
            
            return topRow(for: stacks)
        }
        
        private func stacks(_ input: Array<String>) -> [Stack] {
            var result = [Stack](repeating: Stack(), count: 9)
            
            for line in input {
                if line.first == " " {
                    break
                }
                
                for columnIndex in 0 ..< 9 {
                    if line[columnIndex * 4] == " " {
                        continue
                    }
                    
                    result[columnIndex].push(Character(line[columnIndex * 4 + 1]))
                }
            }
            
            for index in 0 ..< result.count {
                result[index].reverse()
            }
            
            return result
        }
        
        private func instructions(_ input: Array<String>) -> [[Int]] {
            var result = [[Int]]()
            
            for line in input {
                if line.first != "m" {
                    continue
                }
                
                var instruction = line
                
                if let range = instruction.range(of: "move ") {
                    instruction.removeSubrange(range)
                }
                
                if let range = instruction.range(of: "from ") {
                    instruction.removeSubrange(range)
                }
                
                if let range = instruction.range(of: "to ") {
                    instruction.removeSubrange(range)
                }
                
                var intInstruction = [Int]()
                
                for char in instruction.split(separator: " ") {
                    let int = Int(char)!
                    intInstruction.append(int)
                }
                
                result.append(intInstruction)
            }
            
            return result
        }
        
        private func execute9000(_ instruction: Array<Int>, on stack: [Stack]) -> [Stack] {
            var result = stack
            
            let numberOfBoxes = instruction[0]
            let from = instruction[1]
            let to = instruction[2]
            
            for _ in 0 ..< numberOfBoxes {
                let box = result[from - 1].pop()!
                result[to - 1].push(box)
            }
            
            return result
        }
        
        private func execute9001(_ instruction: Array<Int>, on stack: [Stack]) -> [Stack] {
            var result = stack
            
            let numberOfBoxes = instruction[0]
            let from = instruction[1]
            let to = instruction[2]
            
            let boxes = result[from - 1].pop(numberOfBoxes)!
            result[to - 1].push(boxes)
            
            return result
        }
        
        private func topRow(for stacks: [Stack]) -> String {
            var answer = ""
            
            for stack in stacks {
                answer.append(stack.peek()!)
            }
            
            return answer
        }
    }    
}

extension String {
    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

struct Stack {
    fileprivate var array: [Character] = []
    
    mutating func push(_ element: Character) {
        array.append(element)
    }
    
    mutating func push(_ elements: [Character]) {
        array.append(contentsOf: elements)
    }
    
    mutating func pop() -> Character? {
        return array.popLast()
    }
    
    mutating func pop(_ count: Int) -> [Character]? {
        var result = [Character]()
        for _ in 0 ..< count {
            result.append(array.popLast()!)
        }
        return result.reversed()
    }
    
    mutating func reverse() {
        array.reverse()
    }
    
    func peek() -> Character? {
        return array.last
    }
}
