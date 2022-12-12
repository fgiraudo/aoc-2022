//
//  Day2.swift
//  AoC-2022
//
//  Created by Fernando Giraudo on 01.12.22.
//

import Foundation

extension Solver {
    internal final class Day11: PuzzleSolver {
        var monkeysFromInput = [Monkey]()
        var supermodulo = 1
        
        internal func puzzle1(input: Array<String>) -> Any {
            monkeysFromInput = populateMonkeys(with: input)
            var monkeys = monkeysFromInput
            
            for _ in 0 ..< 20 {
                for monkeyIndex in 0 ..< monkeys.count {
                    let monkey = monkeys[monkeyIndex]
                    
                    for var item in monkey.startingItems {
                        item = monkey.operation(item) / 3
                        let sendToMonkey = monkey.test(item)
                        monkeys[sendToMonkey].startingItems.append(item)
                        monkeys[monkeyIndex].numberOfInspections += 1
                    }
                    
                    monkeys[monkeyIndex].startingItems.removeAll()
                }
            }
            
            let mostActive = monkeys.sorted { $0.numberOfInspections > $1.numberOfInspections }.prefix(upTo: 2)
            
            return mostActive[0].numberOfInspections * mostActive[1].numberOfInspections
        }
        
        internal func puzzle2(input: Array<String>) -> Any {
            var monkeys = monkeysFromInput
            
            for _ in 0 ..< 10000 {
                for monkeyIndex in 0 ..< monkeys.count {
                    let monkey = monkeys[monkeyIndex]
                    
                    for var item in monkey.startingItems {
                        item = monkey.operation(item) % supermodulo
                        let sendToMonkey = monkey.test(item)
                        monkeys[sendToMonkey].startingItems.append(item)
                        monkeys[monkeyIndex].numberOfInspections += 1
                    }
                    
                    monkeys[monkeyIndex].startingItems.removeAll()
                }
            }
            
            let mostActive = monkeys.sorted { $0.numberOfInspections > $1.numberOfInspections }.prefix(upTo: 2)
            
            return mostActive[0].numberOfInspections * mostActive[1].numberOfInspections
        }
        
        private func populateMonkeys(with input: Array<String>) -> [Monkey] {
            var monkeys = [Monkey]()
            
            var id: Int!
            var startingItems: [Int]!
            var operation: ((Int) -> Int)!
            var divisor: Int!
            var monkeyTrue: Int!
            var monkeyFalse: Int!
            
            for line in input {
                if line.isEmpty {
                    let divisorInput = divisor!
                    let monkeyTrueInput = monkeyTrue!
                    let monkeyFalseInput = monkeyFalse!
                    
                    func testFunc(worryLevel: Int) -> Int {
                        return worryLevel % divisorInput == 0 ? monkeyTrueInput : monkeyFalseInput
                    }
                    
                    let monkey = Monkey(
                        id: id,
                        startingItems: startingItems,
                        operation: operation,
                        test: testFunc
                    )
                    
                    monkeys.append(monkey)
                    
                    continue
                }
                
                let lineArray = line.replacing(",", with: "").split(separator: " ")
                
                if lineArray.first == "Monkey" {
                    id = Int(String(lineArray.last!.first!))!
                }
                
                if lineArray.first == "Starting" {
                    startingItems = lineArray.suffix(from: 2).map { Int($0)! }
                }
                
                if lineArray.contains("Operation:") {
                    let expression = "\(lineArray.suffix(3).joined())"
                    
                    func operationFunc(x: Int) -> Int {
                        let elements = ["old": x]
                        
                        return NSExpression(format: expression).expressionValue(with: elements, context: nil) as! Int
                    }
                    
                    operation = operationFunc
                }
                
                if lineArray.contains("Test:") {
                    divisor = Int(lineArray.last!)!
                    supermodulo *= divisor
                }
                
                if lineArray.contains("true:") {
                    monkeyTrue = Int(lineArray.last!)!
                }
                
                if lineArray.contains("false:") {
                    monkeyFalse = Int(lineArray.last!)!
                }
            }
            
            return monkeys
        }
    }    
}

struct Monkey {
    let id: Int
    var startingItems: [Int]
    let operation: (Int) -> Int
    let test: (Int) -> Int
    
    var numberOfInspections = 0
}
