//
//  ViewController.swift
//  LightsOut
//
//  Created by Blaine Wilson on 8/19/15.
//  Copyright (c) 2015 Blaine Wilson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game = LightsOutGame()

    @IBOutlet weak var lightsOutView: LightsOutView!
    
    @IBOutlet weak var undoButton: UIButton!

    @IBAction func newGame(sender: AnyObject) {
        game.newGame()
        lightsOutView.setNeedsDisplay()
    }
    
    @IBAction func undo(sender: AnyObject) {
        game.undo()
        lightsOutView.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lightsOutView.game = game
        game.newGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func toggleCross(row: Int , col: Int) {
        game.toggleCross(row: row, column: col)
    }

}

