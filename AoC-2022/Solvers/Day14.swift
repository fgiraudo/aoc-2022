//
//  Day2.swift
//  AoC-2022
//
//  Created by Fernando Giraudo on 01.12.22.
//

import Foundation

extension Solver {
    internal final class Day14: PuzzleSolver {
        final let initialCoordinate = Coordinate(x: 500, y: 0)
        
        private var rocks = Set<Coordinate>()
        private var sands = Set<Coordinate>()
        private var deepestCoordinate: Coordinate!
        
        internal func puzzle1(input: Array<String>) -> Any {
            rocks = rocks(for: input)
            
            while fallSand(floor: false) != nil {
                continue
            }
            
            return sands.count
        }
        
        internal func puzzle2(input: Array<String>) -> Any {
            while fallSand(floor: true) != nil {
                continue
            }
            
            return sands.count + 1
        }
        
        private func log() {
            for y in 0 ... 9 {
                var line = ""
                for x in 494 ... 503 {
                    let coord = Coordinate(x: x, y: y)
                    
                    if rocks.contains(coord) {
                        line += "#"
                    } else if sands.contains(coord) {
                        line += "o"
                    } else {
                        line += "."
                    }
                }
                print(line)
            }
        }
        
        private func rocks(for input: Array<String>) -> Set<Coordinate> {
            deepestCoordinate = initialCoordinate
            var result = Set<Coordinate>()
            var previousCoordinate: Coordinate?
            
            for line in input {
                if line.isEmpty {
                    break
                }
                
                let lineArr = line.replacingOccurrences(of: " ", with: "").split(separator: "->")
                
                for entry in lineArr {
                    let coordinatesArr = entry.split(separator: ",")
                    let coordinate = Coordinate(x: Int(coordinatesArr.first!)!, y: Int(coordinatesArr.last!)!)
                    
                    if let previousCoordinate {
                        result = result.union(inBetweenCoordinates(from: previousCoordinate, to: coordinate))
                    }
                    
                    if coordinate.isDeeper(than: deepestCoordinate) {
                        deepestCoordinate = coordinate
                    }
                    
                    result.insert(coordinate)
                    previousCoordinate = coordinate
                }
                
                previousCoordinate = nil
            }
            
            return result
        }
        
        private func fallSand(floor: Bool) -> Coordinate? {
            var sandCoordinate = initialCoordinate
            
            while let nextCoordinate = nextSandCoordinates(from: sandCoordinate, floor: floor) {
                if !floor && Coordinate(x: nextCoordinate.x, y: nextCoordinate.y + 1).isDeeper(than: deepestCoordinate) {
                    return nil
                }
                
                sandCoordinate = nextCoordinate
            }
            
            
            
            if sandCoordinate != initialCoordinate {
                sands.insert(sandCoordinate)
                return sandCoordinate
            }
            
            return nil
        }
        
        private func nextSandCoordinates(from coordinates: Coordinate, floor: Bool) -> Coordinate? {
            let floorDepth = deepestCoordinate.y + 2
            
            let nextCoordinates = [
                Coordinate(x: coordinates.x, y: coordinates.y + 1),
                Coordinate(x: coordinates.x - 1, y: coordinates.y + 1),
                Coordinate(x: coordinates.x + 1, y: coordinates.y + 1)
            ]
            
            for coordinate in nextCoordinates {
                if !sands.contains(coordinate) && !rocks.contains(coordinate) &&
                    (floor ? coordinate.y < floorDepth : true) {
                    return coordinate
                }
            }
            
            return nil
        }
        
        private func inBetweenCoordinates(from: Coordinate, to: Coordinate) -> Set<Coordinate> {
            var result = Set<Coordinate>()
            
            if from.x > to.x {
                var coordinate = to
                
                for _ in 0 ..< from.x - to.x - 1 {
                    coordinate = Coordinate(x: coordinate.x + 1, y: coordinate.y)
                    result.insert(coordinate)
                }
            }
            
            if from.x < to.x {
                var coordinate = from
                
                for _ in 0 ..< to.x - from.x - 1 {
                    coordinate = Coordinate(x: coordinate.x + 1, y: coordinate.y)
                    result.insert(coordinate)
                }
            }
            
            if from.y > to.y {
                var coordinate = to
                
                for _ in 0 ..< from.y - to.y - 1 {
                    coordinate = Coordinate(x: coordinate.x, y: coordinate.y + 1)
                    result.insert(coordinate)
                }
            }
            
            if to.y > from.y {
                var coordinate = from
                
                for _ in 0 ..< to.y - from.y - 1 {
                    coordinate = Coordinate(x: coordinate.x, y: coordinate.y + 1)
                    result.insert(coordinate)
                }
            }
            
            return result
        }
    }
}

struct Coordinate: Equatable, Hashable {
    let x: Int
    let y: Int
    
    func isDeeper(than coordinate: Coordinate) -> Bool {
        return self.y > coordinate.y
    }
}
