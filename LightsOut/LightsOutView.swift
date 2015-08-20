//
//  LightsOutView.swift
//  LightsOut
//
//  Created by Blaine Wilson on 8/19/15.
//  Copyright (c) 2015 Blaine Wilson. All rights reserved.
//

import UIKit

class LightsOutView: UIView {


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
        
        for row in 0..<5 {
            for column in 0..<5 {
                var path = UIBezierPath(ovalInRect: CGRectMake(CGFloat(column)*squareWidth, CGFloat(row)*squareHeight, squareWidth, squareHeight))
                gridColor.set()
                path.stroke()
                litColor.set()
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
