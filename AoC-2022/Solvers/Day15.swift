//
//  Day2.swift
//  AoC-2022
//
//  Created by Fernando Giraudo on 01.12.22.
//

import Foundation

extension Solver {
    internal final class Day15: PuzzleSolver {
        fileprivate var signals: [Signal]!
        
        private var minX: Int?
        private var maxX: Int?
        private var noBeaconCoordinates = Set<Coordinate>()
        
        internal func puzzle1(input: Array<String>) -> Any {
            signals = signals(for: input)
            
            var rangeSet = Set<Int>()
            
            for signal in signals {
                if let range = signal.noBeaconRange(for: 2000000) {
                    rangeSet = rangeSet.union(Set(range.0 ... range.1))
                }
            }
            
            return rangeSet.count - 1
        }
        
        internal func puzzle2(input: Array<String>) -> Any {
            for y in 0 ... 4000000 {
                var ranges = [(0, 4000000)]
                for signal in signals {
                    if let noBeaconRange = signal.noBeaconRange(for: y) {
                        var rangesToRemove = [Int]()
                        
                        for i in 0 ..< ranges.count {
                            let range = ranges[i]
                            
                            if noBeaconRange.1 <= range.0 || noBeaconRange.0 >= range.1 {
                                continue
                            }
                            
                            if noBeaconRange.0 <= range.0 {
                                if noBeaconRange.1 >= range.1 {
                                    rangesToRemove.append(i)
                                    continue
                                } else {
                                    ranges[i] = (noBeaconRange.1 + 1, range.1)
                                    continue
                                }
                            } else {
                                if noBeaconRange.1 >= range.1 {
                                    ranges[i] = (range.0, noBeaconRange.0 - 1)
                                    continue
                                } else {
                                    ranges[i] = (range.0, noBeaconRange.0)
                                    ranges.append((noBeaconRange.1 + 1, range.1))
                                }
                            }
                        }
                        
                        for i in rangesToRemove.sorted(by: { $0 > $1 }) {
                            ranges.remove(at: i)
                        }
                        
                        rangesToRemove.removeAll()
                    }
                    
                    if ranges.isEmpty {
                        break
                    }
                }
                
                if ranges.isEmpty == false {
                    return ranges[0].0 * 4000000 + y
                }
            }
            
            return 0
        }
        
        private func signals(for input: Array<String>) -> [Signal] {
            var result = [Signal]()
            
            for line in input {
                if line.isEmpty {
                    break
                }
                
                let lineArr = line.split(separator: " ")
                let sensor = Coordinate(x: lineArr[2].digits, y: lineArr[3].digits)
                let beacon = Coordinate(x: lineArr[8].digits, y: lineArr[9].digits)
                let distance = manhattanDistance(from: sensor, to: beacon)
                
                minX = min(minX ?? sensor.x - distance, sensor.x - distance)
                maxX = max(maxX ?? sensor.x + distance, sensor.x + distance)
       
                result.append(Signal(
                    sensor: sensor,
                    beacon: beacon,
                    manhattanDistance: distance)
                )
            }
            
            return result
        }
        
        private func manhattanDistance(from: Coordinate, to: Coordinate) -> Int {
            return abs(from.x - to.x) + abs(from.y - to.y)
        }
        
        private func couldNotContainBeacon(coordinate: Coordinate) -> Bool {
            for signal in signals {
                if manhattanDistance(from: coordinate, to: signal.sensor) <= signal.manhattanDistance || coordinate == signal.beacon {
                    return true
                }
            }
            
            return false
        }
    }
}

fileprivate struct Signal {
    let sensor: Coordinate
    let beacon: Coordinate
    let manhattanDistance: Int
    
    func noBeaconRange(for line: Int) -> (Int, Int)? {
        if abs(line - sensor.y) > manhattanDistance {
            return nil
        }
        
        return (sensor.x - manhattanDistance + abs(line - sensor.y), sensor.x +  manhattanDistance - abs(line - sensor.y))
        
    }
}

extension Substring {
    var digits: Int {
        let digits = Int(components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined())!
        return self.contains("-") ? -digits : digits
    }
}
