//
//  GameLogic.swift
//  TicTacToe
//
//  Created by Jules Steele on 12/25/24.
//

import Foundation

enum Player {
    case X
    case O
}

class TicTacToeModel: ObservableObject {
    
    @Published var board: [Player?] = Array(repeating: nil, count: 9)
    @Published var activePlayer: Player = .X
    @Published var winner: Player? = nil
    @Published var useBot: Bool = false
    
    func buttonTap(i: Int) {
        
        guard board[i] == nil && winner == nil else {
            return
        }
        
        // Use bot
        if useBot && activePlayer == .X {
            
            // Place player click
            board[i] = activePlayer
            
            // Set active player to Os
            activePlayer = .O
            
            // Bot move logic --- Picks random spot then enumerates to first available if not open
            var botMove: Int = Int.random(in: 0..<9)
            
            if board[botMove] != nil {
                for j in 0..<9 {
                    if board[j] == nil {
                        botMove = j
                        break
                    }
                }
            }
            
            // Place bot move
            board[botMove] = activePlayer
        } else {
            // Otherwise place active player's mark
            board[i] = activePlayer
        }
        
        if checkWinner() {
            winner = activePlayer
            print("Winner: \(activePlayer)")
            return
        } else {
            activePlayer = (activePlayer == .X) ? .O : .X
        }
    }
    
    func buttonLabel(i: Int) -> String {
        if let player = board[i] {
            return player == .X ? "X" : "O"
        }
        return ""
    }
    
    func reset() {
        board = Array(repeating: nil, count: 9)
        activePlayer = .X
        winner = nil
    }
    
    func checkWinner() -> Bool {
        
        for i in stride(from: 0, to: 9, by: 3) {
            if board[i] == activePlayer && board[i+1] == activePlayer && board[i+2] == activePlayer {
                return true
            }
        }
        
        for i in 0..<3 {
            if board[i] == activePlayer && board[i+3] == activePlayer && board[i+6] == activePlayer {
                return true
            }
        }
        
        if board[0] == activePlayer && board[4] == activePlayer && board[8] == activePlayer {
            return true
        }
        if board[2] == activePlayer && board[4] == activePlayer && board[6] == activePlayer {
            return true
        }
        
        return false
    }
    
    func toggleBot() {
        useBot = !useBot
    }
}
