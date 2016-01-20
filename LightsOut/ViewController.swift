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
    
    @IBOutlet weak var levelButton: UIButton!
    
    @IBOutlet weak var levelSlider: UISlider!
    
    @IBOutlet weak var lightsOutView: LightsOutView!
    
    @IBAction func levelSliderChanged(_: AnyObject) {
//        levelSlider.continuous = false
        let levelFromSlider = self.levelSlider.value
        self.levelButton.setTitle(String(Int(levelFromSlider)), forState: UIControlState.Normal)
        let store = NSUserDefaults.standardUserDefaults()
        let value = Int(levelFromSlider)
        store.setInteger(value, forKey: "Level")
        resetLevel()
    }
    
    @IBAction func showHideSlider(_: AnyObject) {

        if levelSlider.hidden == false {
            fadeOut()
        } else {
            levelSlider.hidden = !levelSlider.hidden
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "fadeOut", userInfo: nil, repeats: false)
        }
    }
    
    func fadeOut() {
        UIView.animateWithDuration(1.0, animations: {
            self.levelSlider.alpha = self.levelSlider.hidden ? 1.0 : 0.0
            }, completion: {
                (_: Bool) in
                self.levelSlider.hidden = !self.levelSlider.hidden
                self.levelSlider.alpha = 1.0
        })
    }
    
    @IBAction func newGameClick(_: AnyObject) {
        self.levelSlider.value -= 1
        self.levelSliderChanged(self)
        let levelFromSlider = self.levelSlider.value
        game.level = Int(levelFromSlider)
        game.newGame()
        lightsOutView.setNeedsDisplay()
    }
    
    @IBAction func undoRoundClick(_: AnyObject) {
        game.undoRound()
        lightsOutView.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lightsOutView.game = game
        let store = NSUserDefaults.standardUserDefaults()
        let level = store.integerForKey("Level")
        if level == 0 {
            self.levelSlider.value = 1.0
        } else {
            self.levelSlider.value = Float(level)
        }
        
        self.levelButton.setTitle(String(Int(levelSlider.value)), forState: UIControlState.Normal)
        self.resetLevel()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didWinGame", name: "didWinGame", object: nil  )
        
//        self.setNeedsStatusBarAppearanceUpdate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func didWinGame() {
        self.levelSlider.value += 1
        self.levelSliderChanged(self)
        self.resetLevel()
    }
    
    func resetLevel() {
        let levelFromSlider = self.levelSlider.value
        game.level = Int(levelFromSlider)
        game.newGame()
        lightsOutView.setNeedsDisplay()
    }
}

