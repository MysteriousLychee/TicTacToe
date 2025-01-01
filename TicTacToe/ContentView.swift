//
//  ContentView.swift
//  TicTacToe
//
//  Created by Jules Steele on 12/25/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var ticTacToe = TicTacToeModel()
    
    var body: some View {
        VStack {
            Text("TIC TAC TOE")
                .font(.system(size: 45, weight: .heavy))
            
            Button(action: {
                ticTacToe.toggleBot()
            }, label: {
                Text("Use Bot?")
                    .frame(width: 160, height: 60)
                    .background(Color.blue)
                    .clipShape(Capsule())
                    .foregroundStyle(Color.white)
                    .font(.system(size: 30))
            })
            
            Text("Using Bot: " + (ticTacToe.useBot ? "Yes" : "No"))
            
            .padding(.bottom)
            
            let col = Array(repeating: GridItem(.flexible()), count: 3)
            
            LazyVGrid(columns: col, content: {
                ForEach(0..<9) { i in
                    Button(action: {
                        ticTacToe.buttonTap(i: i)
                    }, label: {
                        Text(ticTacToe.buttonLabel(i: i))
                            .frame(width: 100, height: 100)
                            .background(Color.blue)
                            .foregroundStyle(Color.white)
                            .font(.system(size: 45, weight: .heavy))
                    })
                }
            })
            
            .padding(.bottom)
            
            Button(action: {
                ticTacToe.reset()
            }, label: {
                Text("Play Again")
                    .frame(width: 250, height: 60)
                    .background(Color.blue)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 35, weight: .heavy))
                    .clipShape(Capsule())
            })
            
            if ticTacToe.checkWinner() {
                Text("Winner: \(ticTacToe.activePlayer)")
                    .font(.system(size: 20, weight: .heavy))
            }
            
            ForEach(0..<9) { row in
                
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
