//
//  LightsOutGame.swift
//  LightsOut
//
//  Created by Blaine Wilson on 10/13/15.
//  Copyright © 2015 Blaine Wilson. All rights reserved.
//

import UIKit

class LightsOutGame: NSObject {
    
    var moves: [(row:Int, column:Int)] = []
    
    var squares = [Bool](count:boardSize * boardSize, repeatedValue:false)
    
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
    
    func newGame() {
        // clear board
        for rowNum in 0..<boardSize {
            for colNum in 0..<boardSize {
                setSquareAt(row: rowNum, column: colNum, value: false)
            }
        }
        
        // choosing random squares to toggle
        var listOfSquares = [(Int, Int)]()
        for rowNum in 0..<boardSize {
            for colNum in 0..<boardSize {
                listOfSquares.append((rowNum, colNum))
            }
        }
        
        // set random light pattern
        for _ in 0..<6 {
            let randomElement = random() % listOfSquares.count
            let (row, col) = listOfSquares[randomElement]
            listOfSquares.removeAtIndex(randomElement)
            toggleCross(row: row, column: col)
        }
        
        //clears moves array
        moves.removeAll()
    }
    
    func undo() {
        if moves.count > 0 {
            let move = moves.removeLast()
            self.toggleCross(row: move.row, column: move.column)
        }
    }
}
