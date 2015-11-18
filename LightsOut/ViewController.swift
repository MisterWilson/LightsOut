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
        
    @IBOutlet weak var winningText: UITextField!
    
    @IBOutlet weak var winningIcon: UITextField!

    @IBAction func newGameClick(sender: AnyObject) {
        game.newGame()
        lightsOutView.lightShowStarted = false
        lightsOutView.setNeedsDisplay()
        winningText.hidden = true
        winningIcon.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lightsOutView.game = game
        self.newGameClick(self)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didWinGame", name: "didWinGame", object: nil  )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didWinGame() {
        winningText.hidden = false
        winningIcon.hidden = false
        lightsOutView.startLightShow()
    }

}

