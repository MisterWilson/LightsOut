//
//  LightsOutGame.swift
//  LightsOut
//
//  Created by Blaine Wilson on 10/13/15.
//  Copyright © 2015 Blaine Wilson. All rights reserved.
//

import UIKit

class LightsOutGame: NSObject {
    var squares = [Bool](count:boardSize * boardSize, repeatedValue:false)
    var level = 1
    var originalLayout = [(Int, Int)]()

    
    func didWinGame() -> Bool {
        for i in squares {
            if i {
                return false
            } 
        }
        return true
    }
    
    func squareAt(row r: Int, column c: Int) -> Bool {
        return squares[r*boardSize + c]
    }
    
    func setSquareAt(row r: Int, column c: Int, value v: Bool) {
        squares[r*boardSize + c] = v
    }
    
    func toggleSquareAt(row r: Int, column c: Int) {
        setSquareAt(row: r, column: c, value: !squareAt(row: r, column: c))
    }
    
    func toggleCross(row r: Int, column c: Int){
        let currentValueOfSquare = squareAt(row: r, column: c)
        setSquareAt(row: r, column: c, value: !currentValueOfSquare)
        if r > 0 {
            toggleSquareAt(row: r-1, column: c)
        }
        if r < boardSize-1 {
            toggleSquareAt(row: r+1, column: c)
        }
        if c > 0 {
            toggleSquareAt(row: r, column: c-1)
        }
        if c < boardSize-1 {
            toggleSquareAt(row: r, column: c+1)
        }
    }
    
    func clearBoard () {
        for rowNum in 0..<boardSize {
            for colNum in 0..<boardSize {
                setSquareAt(row: rowNum, column: colNum, value: false)
            }
        }
    }
    
    func newGame() {
        var listOfSquares = [(Int, Int)]()
        
        clearBoard()
        
        // choosing random squares to toggle
        for rowNum in 0..<boardSize {
            for colNum in 0..<boardSize {
                listOfSquares.append((rowNum, colNum))
            }
        }
        
        originalLayout.removeAll()
        
        // toggling squares
        for _ in 0..<level {
            let randomElement = random() % listOfSquares.count
            let (row, col) = listOfSquares[randomElement]
            listOfSquares.removeAtIndex(randomElement)
            originalLayout.append((row, col))
            toggleCross(row: row, column: col)
        }
    }
    
    func undoRound() {
        
        clearBoard()
        
        for (r, c) in originalLayout {
            toggleCross(row: r, column: c)
        }
    }
    
    func makeMove(row r: Int, column c: Int) {
        toggleCross(row: r, column: c)
        
        if self.didWinGame() {
            NSNotificationCenter.defaultCenter().postNotificationName("didWinGame", object: nil)
        }
    }
}
