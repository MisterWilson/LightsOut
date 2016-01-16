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
    var listOfSquares = [(Int, Int)]()
    var moveList = [(Int, Int)]()
    
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
        moveList.append(r, c)
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
    
    func clearlistOfSquares () {
        for rowNum in 0..<boardSize {
            for colNum in 0..<boardSize {
                setSquareAt(row: rowNum, column: colNum, value: false)
            }
        }
        
    }
    
    func newGame() {
        clearlistOfSquares()
        
        // choosing random squares to toggle
        for rowNum in 0..<boardSize {
            for colNum in 0..<boardSize {
                listOfSquares.append((rowNum, colNum))
            }
        }
        
        // toggling squares
        for _ in 0..<level {
            let randomElement = random() % listOfSquares.count
            let (row, col) = listOfSquares[randomElement]
            listOfSquares.removeAtIndex(randomElement)
            toggleCross(row: row, column: col)
        }
        moveList.removeAll()

    }
    
    func undoRound() {
        var listCount = 0
        
        for _ in moveList {
            let (r, c) = moveList[listCount]
            toggleCross(row: r, column: c)
            
            if listCount < moveList.count {
                listCount += 1
            }
        }
        moveList.removeAll()
        listCount = 0
    }
    
    func makeMove(row r: Int, column c: Int) {
        toggleCross(row: r, column: c)
        
        if self.didWinGame() {
            NSNotificationCenter.defaultCenter().postNotificationName("didWinGame", object: nil)
        }
    }
}
