//
//  Day2.swift
//  AoC-2022
//
//  Created by Fernando Giraudo on 01.12.22.
//

import Foundation
import SwiftGraph

extension Solver {
    internal final class Day12: PuzzleSolver {
        var grid = [[Character]]()
        fileprivate var initialPosition: Position!
        fileprivate var goal: Position!
        
        fileprivate var graph = UnweightedGraph<Position>()
        
        internal func puzzle1(input: Array<String>) -> Any {
            process(input)
            
            var explored = [Position]()
            var queue = [Position]()
            
            queue.append(initialPosition)
            _ = graph.addVertex(initialPosition)
            
            while queue.isEmpty == false {
                let exploring = queue.removeFirst()
                explored.append(exploring)
                
                if exploring == goal {
                    break
                } else {
                    let targets = targets(for: exploring, explored: explored, reversed: false)
                    
                    for target in targets {
                        if queue.contains(target) == false {
                            queue.append(target)
                        }
                        
                        _ = graph.addVertex(target)
                        graph.addEdge(from: exploring, to: target)
                    }
                }
            }
            
            return graph.bfs(from: initialPosition, to: goal).count
        }
        
        internal func puzzle2(input: Array<String>) -> Any {
            graph = UnweightedGraph()
            
            var explored = [Position]()
            var queue = [Position]()
            var start = goal!
            
            queue.append(start)
            _ = graph.addVertex(start)
            
            while queue.isEmpty == false {
                let exploring = queue.removeFirst()
                explored.append(exploring)
                
                let targets = targets(for: exploring, explored: explored, reversed: true)
                
                for target in targets {
                    if queue.contains(target) == false {
                        queue.append(target)
                    }
                    
                    _ = graph.addVertex(target)
                    graph.addEdge(from: exploring, to: target)
                }
            }
            
            let bfs = graph.bfs(from: start) { position in
                return grid[position.y][position.x] == "a"
            }
            
            for edge in bfs {
                let origin = edge.u
                let destination = edge.v
                
                let originPosition = graph.vertices[origin]
                let destinationPosition = graph.vertices[destination]
                
                print("Destination: \(destinationPosition) - \(grid[destinationPosition.y][destinationPosition.x])")
            }
            
            return bfs.count
        }
        
        private func process(_ input: Array<String>) {
            var lineIndex = 0
            
            for line in input {
                if line.isEmpty {
                    return
                }
                
                var lineArray = Array(line)
                
                if lineArray.contains("S") {
                    initialPosition = Position(x: lineArray.firstIndex(of: "S")!, y: lineIndex)
                    lineArray = lineArray.replacing("S", with: "a")
                }
                
                if lineArray.contains("E") {
                    goal = Position(x: lineArray.firstIndex(of: "E")!, y: lineIndex)
                    lineArray = lineArray.replacing("E", with: "z")
                }
                
                grid.append(lineArray)
                
                lineIndex += 1
            }
        }
        
        private func targets(for exploring: Position, explored: [Position], reversed: Bool) -> [Position] {
            var result = [Position]()
            
            let maxY = grid.count - 1
            let maxX = grid[0].count - 1
            
            let candidates = [
                Position(x: exploring.x - 1, y: exploring.y),
                Position(x: exploring.x, y: exploring.y - 1),
                Position(x: exploring.x + 1, y: exploring.y),
                Position(x: exploring.x, y: exploring.y + 1)
            ]
            
            for candidate in candidates {
                if reversed && exploring == Position(x: 90, y: 34) {
                    print("Here")
                }
                
                if (0 ... maxY).contains(candidate.y) &&
                    (0 ... maxX).contains(candidate.x) &&
                    explored.contains(candidate) == false {
                    let candidateAscii = Int(grid[candidate.y][candidate.x].asciiValue!)
                    let exploringAscii = Int(grid[exploring.y][exploring.x].asciiValue!)
                    
                    if reversed ? (exploringAscii - candidateAscii < 2) : (candidateAscii - exploringAscii < 2) {
                        result.append(candidate)
                    }
                }
            }
            
            return result
        }
    }
}

fileprivate struct Position: Codable, Equatable {
    let x: Int
    let y: Int
}
