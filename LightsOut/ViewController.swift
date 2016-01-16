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
    
    @IBAction func levelSliderChanged(sender: AnyObject) {
        levelSlider.continuous = false
        let levelFromSlider = self.levelSlider.value
        self.levelButton.setTitle(String(Int(levelFromSlider)), forState: UIControlState.Normal)
        let store = NSUserDefaults.standardUserDefaults()
        let value = Int(levelFromSlider)
        store.setInteger(value, forKey: "Level")
        resetLevel("AnyObject")
    }
    
    @IBAction func showHideSlider(sender: AnyObject) {
        showHideSlide()
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "showHideSlide", userInfo: nil, repeats: false)
    }
    
    @IBAction func newGameClick(_: AnyObject) {
        self.levelSlider.value -= 1
        self.levelSliderChanged(self)
        let levelFromSlider = self.levelSlider.value
        game.level = Int(levelFromSlider)
        game.newGame()
        lightsOutView.setNeedsDisplay()
    }
    
    @IBAction func undoRoundClick(sender: AnyObject) {
        game.undoRound()
        lightsOutView.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lightsOutView.game = game
        let store = NSUserDefaults.standardUserDefaults()
        let level = store.integerForKey("Level")
        print(level)
        self.levelSlider.value = Float(level)
        
        self.levelButton.setTitle(String(Int(level)), forState: UIControlState.Normal)
        self.resetLevel(self)
        
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
        self.resetLevel(self)
    }
    
    func resetLevel(_: AnyObject) {
        let levelFromSlider = self.levelSlider.value
        game.level = Int(levelFromSlider)
        game.newGame()
        lightsOutView.setNeedsDisplay()
    }
    
    func showHideSlide() {
        levelSlider.hidden = !levelSlider.hidden
    }

}

