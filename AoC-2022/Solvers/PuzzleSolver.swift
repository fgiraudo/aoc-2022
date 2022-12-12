//
//  PuzzleSolver.swift
//  AoC-2022
//
//  Created by Fernando Giraudo on 01.12.22.
//

import Foundation

internal protocol PuzzleSolver {
    func puzzle1(input: Array<String>) -> Any
    func puzzle2(input: Array<String>) -> Any
}

internal final class Solver {
    internal static func solver(for day: Int) -> PuzzleSolver? {
        switch day {
        case 1: return Day1()
        case 2: return Day2()
        case 3: return Day3()
        case 4: return Day4()
        case 5: return Day5()
        case 6: return Day6()
        case 7: return Day7()
        case 8: return Day8()
        case 9: return Day9()
        case 10: return Day10()
        case 11: return Day11()
        case 12: return Day12()
        case 13: return Day13()
        case 14: return Day14()
        case 15: return Day15()
        case 16: return Day16()
        case 17: return Day17()
        case 18: return Day18()
        case 19: return Day19()
        case 20: return Day20()
        case 21: return Day21()
        case 22: return Day22()
        case 23: return Day23()
        case 24: return Day24()
        case 25: return Day25()
        default: return nil
        }
    }
}
