//
//  Day2.swift
//  AoC-2022
//
//  Created by Fernando Giraudo on 01.12.22.
//

import Foundation

extension Solver {
    internal final class Day13: PuzzleSolver {
        var receivedPackets: [Packets]!
        var allPackets = [Any]()
        
        internal func puzzle1(input: Array<String>) -> Any {
            receivedPackets = process(input)
            var sum = 0
            
            for packets in receivedPackets {
                var isCorrectOrder = compare(packets.left, packets.right)
                
                if isCorrectOrder ?? false {
                    sum += packets.index
                }
            }
            
            return sum
        }
        
        private func compare(_ left: Any, _ right: Any) -> Bool? {
            if let a = left as? Int, let b = right as? Int {
                return a == b ? nil : a < b
            } else if let a = left as? Int {
                return compare([a], right)
            } else if let b = right as? Int {
                return compare(left, [b])
            } else {
                let a = left as! [Any]
                let b = right as! [Any]
                let n = min(a.count, b.count)
                
                for i in 0 ..< n {
                    let c = compare(a[i], b[i])
                    if c != nil {
                        return c
                    }
                }
                
                return a.count == b.count ? nil : a.count < b.count
            }
        }
        
        internal func puzzle2(input: Array<String>) -> Any {
            allPackets = allPackets.sorted { compare($0, $1)! }
            
            let first = allPackets.firstIndex { $0 as? [[Int]] == [[2]] }
            let second = allPackets.firstIndex { $0 as? [[Int]] == [[6]] }
            
            return (first! + 1) * (second! + 1)
        }
        
        private func process(_ input: Array<String>) -> [Packets] {
            var result = [Packets]()
            var left = [Any]()
            var right = [Any]()
            var index = 1
            var processingLeft = true
            
            for line in input {
                if line.isEmpty {
                    result.append(Packets(
                        left: left,
                        right: right,
                        index: index
                    ))
                    
                    index += 1
                    
                    continue
                }
                
                var currentArray = Array<Any>()
                var currentStack = Array<[Any]>()
                var currentNumber: Int?
                
                for index in 1 ..< line.count - 1 {
                    let char = line[index]
                    
                    if let charInt = Int(char) {
                        if currentNumber == nil {
                            currentNumber = charInt
                        } else {
                            currentNumber = currentNumber! * 10 + charInt
                        }
                        
                        if let _ = Int(line[index + 1]) {
                            continue
                        }
                        
                        if currentStack.isEmpty {
                            currentArray.append(currentNumber!)
                        } else {
                            var last = currentStack.last!
                            last.append(currentNumber!)
                            currentStack[currentStack.count - 1] = last
                        }
                        
                        currentNumber = nil
                    }
                    
                    if char == "[" {
                        currentStack.append([Any]())
                    }
                    
                    if char == "]" {
                        let array = currentStack.popLast()!
                        
                        if currentStack.isEmpty {
                            currentArray.append(array)
                        } else {
                            var last = currentStack.last!
                            last.append(array)
                            currentStack[currentStack.count - 1] = last
                        }
                    }
                }
                
                if processingLeft {
                    left = currentArray
                    processingLeft = false
                } else {
                    right = currentArray
                    processingLeft = true
                }
                
                allPackets.append(currentArray)
            }
            
            allPackets.append([[2]])
            allPackets.append([[6]])
            
            return result
        }
    }
}

struct Packets {
    let left: [Any]
    let right: [Any]
    let index: Int
}
