//
//  LightsOutView.swift
//  LightsOut
//
//  Created by Blaine Wilson on 8/19/15.
//  Copyright (c) 2015 Blaine Wilson. All rights reserved.
//

import UIKit

class LightsOutView: UIView {
    
    var squares = [Bool](count:25, repeatedValue:false)
    
    func squareAt(row r: Int, column c: Int) -> Bool {
        return squares[r*5 + c]
    }
    
    func setSquareAt(row r: Int, column c: Int, value v: Bool) {
        squares[r*5 + c] = v
    }


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        let bounds = self.bounds
        let viewWidth = bounds.width
        let viewHeight = bounds.height
        
        let squareWidth = viewWidth / CGFloat(5)
        let squareHeight = viewHeight / CGFloat(5)
        
        let litColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        let gridColor = UIColor(white: 0, alpha: 1)
        let unlitColor = UIColor.darkGrayColor()
        
        
        for rowNum in 0..<5 {
            for colNum in 0..<5 {
                let path = UIBezierPath(roundedRect: CGRectMake(CGFloat(colNum)*squareWidth, CGFloat(rowNum)*squareHeight, squareWidth, squareHeight), cornerRadius: CGFloat(10))
                gridColor.set()
                path.stroke()
                if squareAt(row:rowNum, column:colNum) == true {
                 litColor.set()
                } else {
                 unlitColor.set()
                }
                
                path.fill()
            }
        }
    }
    
//    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
//        <#code#>
//    }
}

//        var path = UIBezierPath(ovalInRect: CGRectMake(0, 0, 50, 50))
////        var box = UIBezierPath(roundedRect: CGRectMake(100, 100, squareWidth, squareHeight), cornerRadius: 10)
////        path.stroke()
////        box.stroke()
//    }
