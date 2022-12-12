//
//  Puzzles.swift
//  AoC-2022
//
//  Created by Fernando Giraudo on 01.12.22.
//

import Combine
import Foundation

internal final class Puzzles: ObservableObject {
    @Published
    var result1: String?
    
    @Published
    var result2: String?
    
    @Published
    var selectedPuzzle: Int = 0
    
    internal init() {
        changeTo(day: 0)
    }
    
    internal func changeTo(day: Int) {
        selectedPuzzle = day
        
        var input = Array<String>()
        
        guard let path = Bundle.main.path(forResource: "day\(day + 1)", ofType: "txt") else {
            assertionFailure("Could not find input file for selected day")
            
            return
        }
        
        do {
            let data = try String(contentsOfFile: path, encoding: .utf8)
            input = data.components(separatedBy: .newlines)
        } catch {
            print(error)
        }
        
        guard let solver = Solver.solver(for: day + 1) else {
            assertionFailure("Solver not found for selected day")
            
            return
        }
        
        result1 = "\(solver.puzzle1(input: input))"
        result2 = "\(solver.puzzle2(input: input))"
    }
}
