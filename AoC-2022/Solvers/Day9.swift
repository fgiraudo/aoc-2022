//
//  Day2.swift
//  AoC-2022
//
//  Created by Fernando Giraudo on 01.12.22.
//

import Foundation

extension Solver {
    internal final class Day9: PuzzleSolver {
        internal func puzzle1(input: Array<String>) -> Any {
            var visited = Set<Position>()
            var head = Position(x: 0, y: 0)
            var tail = Position(x: 0, y: 0)
            
            visited.insert(tail)
            
            for line in input {
                if line.isEmpty {
                    break
                }
                
                let direction = line.split(separator: " ").first
                let numberOfSteps = Int(line.split(separator: " ").last!)!
                
                for _ in 0 ..< numberOfSteps {
                    switch direction {
                    case "L": head.x -= 1
                    case "R": head.x += 1
                    case "U": head.y += 1
                    case "D": head.y -= 1
                    default:
                        assertionFailure("Should not happen")
                        return 0
                    }
                    
                    if !isTouching(head, tail) {
                        if shouldMoveDiagonally(head, tail) {
                            if head.x > tail.x {
                                tail.x += 1
                            } else {
                                tail.x -= 1
                            }
                            
                            if head.y > tail.y {
                                tail.y += 1
                            } else {
                                tail.y -= 1
                            }
                        }
                        
                        if head.x - tail.x < -1 {
                            tail.x -= 1
                        }
                        
                        if head.x - tail.x > 1 {
                            tail.x += 1
                        }
                        
                        if head.y - tail.y < -1 {
                            tail.y -= 1
                        }
                        
                        if head.y - tail.y > 1 {
                            tail.y += 1
                        }
                        
                        visited.insert(tail)
                    }
                }
            }
            
            return visited.count
        }
        
        internal func puzzle2(input: Array<String>) -> Any {
            var visited = Set<Position>()
            var knots = Array<Position>(repeating: Position(x: 0, y: 0), count: 10)
            
            visited.insert(knots.last!)
            
            for line in input {
                if line.isEmpty {
                    break
                }
                
                let direction = line.split(separator: " ").first
                let numberOfSteps = Int(line.split(separator: " ").last!)!
                
                for _ in 0 ..< numberOfSteps {
                    switch direction {
                    case "L": knots[0].x -= 1
                    case "R": knots[0].x += 1
                    case "U": knots[0].y += 1
                    case "D": knots[0].y -= 1
                    default:
                        assertionFailure("Should not happen")
                        return 0
                    }
                    
                    for index in 1 ..< 10 {
                        var head = knots[index - 1]
                        var tail = knots[index]
                        
                        if !isTouching(head, tail) {
                            if shouldMoveDiagonally(head, tail) {
                                if head.x > tail.x {
                                    tail.x += 1
                                } else {
                                    tail.x -= 1
                                }
                                
                                if head.y > tail.y {
                                    tail.y += 1
                                } else {
                                    tail.y -= 1
                                }
                            }
                            
                            if head.x - tail.x < -1 {
                                tail.x -= 1
                            }
                            
                            if head.x - tail.x > 1 {
                                tail.x += 1
                            }
                            
                            if head.y - tail.y < -1 {
                                tail.y -= 1
                            }
                            
                            if head.y - tail.y > 1 {
                                tail.y += 1
                            }
                            
                            knots[index] = tail
                            
                            if index == 9 {
                                visited.insert(tail)
                            }
                        }
                    }
                }
            }
            
            return visited.count
        }
        
        private func isTouching(_ head: Position, _ tail: Position) -> Bool {
            return abs(head.x - tail.x) < 2 && abs(head.y - tail.y) < 2
        }
        
        private func shouldMoveDiagonally(_ head: Position, _ tail: Position) -> Bool {
            return head.x != tail.x && head.y != tail.y
        }
    }
}

fileprivate struct Position: Hashable {
    var x: Int
    var y: Int
}
