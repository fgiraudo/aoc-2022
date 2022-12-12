//
//  ContentView.swift
//  AoC-2022
//
//  Created by Fernando Giraudo on 01.12.22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject
    internal var model = Puzzles()
    
    var body: some View {
        VStack {
            Menu(puzzleTitles[model.selectedPuzzle]) {
                ForEach(Array(puzzleTitles.enumerated()), id: \.offset) { index, title in
                    Button("Day \(index + 1): \(title)") {
                        model.changeTo(day: index)
                    }
                }
            }
            
            Text("Puzzle 1: \(model.result1 ?? "")")
            Text("Puzzle 2: \(model.result2 ?? "")")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
