//
//  Day2.swift
//  AoC-2022
//
//  Created by Fernando Giraudo on 01.12.22.
//

import Foundation

extension Solver {
    internal final class Day8: PuzzleSolver {
        var grid = [[Int]]()
        
        internal func puzzle1(input: Array<String>) -> Any {
            process(input)
            
            return numberOfVisibleTrees()
        }
        
        internal func puzzle2(input: Array<String>) -> Any {
            return highestScenicScore()
        }
        
        private func process(_ input: Array<String>) {
            for line in input {
                if line.isEmpty {
                    return
                }
                
                let intLine = line.map { Int(String($0))! }
                grid.append(intLine)
            }
        }
        
        private func numberOfVisibleTrees() -> Int {
            let transposed = grid.transposed()
            var count = 2 * grid.count + 2 * grid[0].count - 4
            
            for i in 1 ..< grid.count - 1 {
                for j in 1 ..< grid[i].count - 1 {
                    let treeHeight = grid[i][j]
                    
                    let left = Array<Int>(grid[i].prefix(upTo: j))
                    let right = Array<Int>(grid[i].suffix(from: j + 1))
                    let top = Array<Int>(transposed[j].prefix(upTo: i))
                    let bottom = Array<Int>(transposed[j].suffix(from: i + 1))
                    
                    if isVisible(treeHeight, left) ||
                        isVisible(treeHeight, right) ||
                        isVisible(treeHeight, top) ||
                        isVisible(treeHeight, bottom) {
                        count += 1
                    }
                }
            }
            
            return count
        }
        
        private func isVisible(_ treeHeight: Int, _ line: Array<Int>) -> Bool {
            return treeHeight > line.max()!
        }
        
        private func highestScenicScore() -> Int {
            let transposed = grid.transposed()
            var highestScore = 0
            
            for i in 1 ..< grid.count - 1 {
                for j in 1 ..< grid[i].count - 1 {
                    let treeHeight = grid[i][j]
                    
                    let left = Array<Int>(grid[i].prefix(upTo: j))
                    let right = Array<Int>(grid[i].suffix(from: j + 1))
                    let top = Array<Int>(transposed[j].prefix(upTo: i))
                    let bottom = Array<Int>(transposed[j].suffix(from: i + 1))
                    
                    let scenicScore = viewingDistance(treeHeight, left.reversed()) *
                    viewingDistance(treeHeight, right) *
                    viewingDistance(treeHeight, top.reversed()) *
                    viewingDistance(treeHeight, bottom)
                    
                    highestScore = max(highestScore, scenicScore)
                }
            }
            
            return highestScore
        }
        
        private func viewingDistance(_ treeHeight: Int, _ line: Array<Int>) -> Int {
            let index = line.firstIndex { $0 >= treeHeight } ?? line.count - 1
            
            return line.prefix(upTo: index + 1).count
        }
    }    
}

extension Collection where Self.Iterator.Element: RandomAccessCollection {
    // PRECONDITION: `self` must be rectangular, i.e. every row has equal size.
    func transposed() -> [[Self.Iterator.Element.Iterator.Element]] {
        guard let firstRow = self.first else { return [] }
        return firstRow.indices.map { index in
            self.map{ $0[index] }
        }
    }
}
