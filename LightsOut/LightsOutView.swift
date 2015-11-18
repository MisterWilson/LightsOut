//
//  LightsOutView.swift
//  LightsOut
//
//  Created by Blaine Wilson on 8/19/15.
//  Copyright (c) 2015 Blaine Wilson. All rights reserved.
//

import UIKit

let boardSize = 5

class LightsOutView: UIView {
    
    var game: LightsOutGame?
    var lightShowStarted = false
    var lightShowCount = 10
    
    func placeTouch(x: CGFloat, _ y: CGFloat) -> (row: Int, column: Int) {
        let bounds = self.bounds
        let viewWidth = bounds.width
        let viewHeight = bounds.height
        
        let squareWidth = viewWidth / CGFloat(5)
        let squareHeight = viewHeight / CGFloat(5)
        
        let column = x / squareWidth
        let row = y / squareHeight
        
        let columnAsInt = Int(floor(column))
        let rowAsInt = Int(floor(row))
        
        return (row: rowAsInt, column: columnAsInt)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInView(self)
            let coords = self.placeTouch(location.x, location.y)
            
            if let g = game {
                g.makeMove(row: coords.row, column: coords.column)
                
                self.setNeedsDisplay()
            }
        }
    }


    func randomCGFloat() -> CGFloat {
        return CGFloat(random() % 2)
    }
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        if let g = game {
            let bounds = self.bounds
            let viewWidth = bounds.width
            let viewHeight = bounds.height
            
            let squareWidth = viewWidth / CGFloat(boardSize)
            let squareHeight = viewHeight / CGFloat(boardSize)
            
            let litColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
            let gridColor = UIColor(white: 0, alpha: 1)
            let unlitColor = UIColor.darkGrayColor()
            
            
            for rowNum in 0..<boardSize {
                for colNum in 0..<boardSize {
                    let path = UIBezierPath(roundedRect: CGRectMake(CGFloat(colNum)*squareWidth, CGFloat(rowNum)*squareHeight, squareWidth, squareHeight), cornerRadius: CGFloat(10))
                    gridColor.set()
                    path.stroke()
                    
                    if lightShowStarted {
                        let randomColor = UIColor(red: randomCGFloat(), green: randomCGFloat(), blue: randomCGFloat(), alpha: 1)
                        randomColor.set()
                    } else {
                        if g.squareAt(row:rowNum, column:colNum) == true {
                            litColor.set()
                        } else {
                            unlitColor.set()
                        }
                    }
                    
                    path.fill()
                }
            }
        }
    }

    func startLightShow() {
        lightShowStarted = true
        lightShowCount = 10
        self.setNeedsDisplay()
        NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "changeColors", userInfo: nil, repeats: false)
    }
    
    func changeColors() {
        self.setNeedsDisplay()
        lightShowCount--
        if lightShowCount > 0 {
            NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "changeColors", userInfo: nil, repeats: false)
        }
    }
}