//
//  ViewController.swift
//  LightsOut
//
//  Created by Blaine Wilson on 8/19/15.
//  Copyright (c) 2015 Blaine Wilson. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var game = LightsOutGame()
    var fadeOutTimer: NSTimer?
    var level = 1
    
    var wonSound: AVAudioPlayer?
    var newSound: AVAudioPlayer?
    var undoSound: AVAudioPlayer?
    var secretSound: AVAudioPlayer?
    
    @IBOutlet weak var levelButton: UIButton!
    
    @IBOutlet weak var levelSlider: UISlider!
    
    @IBOutlet weak var lightsOutView: LightsOutView!
    
    @IBAction func levelSliderChanged(_: AnyObject) {
        let levelFromSlider = self.levelSlider.value
        
        if Int(levelFromSlider) == level {
            return
        }
        
        self.levelButton.setTitle(String(Int(levelFromSlider)), forState: UIControlState.Normal)
        let store = NSUserDefaults.standardUserDefaults()
        let value = Int(levelFromSlider)
        store.setInteger(value, forKey: "Level")
        resetLevel()
        if let timer: NSTimer = fadeOutTimer {
            timer.invalidate()
            fadeOutTimer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "fadeOut", userInfo: nil, repeats: false)
        }
    }
    
    @IBAction func showHideSlider(_: AnyObject) {

        if levelSlider.hidden == false {
            fadeOut()
        } else {
            levelSlider.hidden = false // make slider visible
            secretSound?.play()
            fadeOutTimer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "fadeOut", userInfo: nil, repeats: false)
        }
    }
    
    @IBAction func newGameClick(_: AnyObject) {
        self.levelSlider.value -= 1
        self.levelSliderChanged(self)
        let levelFromSlider = self.levelSlider.value
        game.level = Int(levelFromSlider)
        game.newGame()
        lightsOutView.setNeedsDisplay()
        newSound?.play()
    }
    
    @IBAction func undoRoundClick(_: AnyObject) {
        game.undoRound()
        lightsOutView.setNeedsDisplay()
        undoSound?.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let newbundle = NSBundle.mainBundle()
        let newSoundPath = newbundle.pathForResource("LOZ_Get_Rupee", ofType: "wav")!
        let newSoundURL = NSURL(fileURLWithPath: newSoundPath)
    
        do {
            try newSound = AVAudioPlayer(contentsOfURL: newSoundURL)
        } catch {
            print("Sorry sucka")
        }
        
        let wonbundle = NSBundle.mainBundle()
        let wonSoundPath = wonbundle.pathForResource("LOZ_Get_Item", ofType: "wav")!
        let wonSoundURL = NSURL(fileURLWithPath: wonSoundPath)
        
        do {
            try wonSound = AVAudioPlayer(contentsOfURL: wonSoundURL)
        } catch {
            print("Sorry sucka")
        }
        let undobundle = NSBundle.mainBundle()
        let undoSoundPath = undobundle.pathForResource("LOZ_Hurt", ofType: "wav")!
        let undoSoundURL = NSURL(fileURLWithPath: undoSoundPath)
        do {
            try undoSound = AVAudioPlayer(contentsOfURL: undoSoundURL)
        } catch {
            print("Sorry sucka")
        }
        
        let secretbundle = NSBundle.mainBundle()
        let secretSoundPath = secretbundle.pathForResource("LOZ_Secret", ofType: "wav")!
        let secretSoundURL = NSURL(fileURLWithPath: secretSoundPath)
        
        do {
            try secretSound = AVAudioPlayer(contentsOfURL: secretSoundURL)
        } catch {
            print("Sorry sucka")
        }
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        lightsOutView.game = game
        let store = NSUserDefaults.standardUserDefaults()
        store.registerDefaults(["Level": 1])
        level = store.integerForKey("Level")
        self.levelSlider.value = Float(level)
      
        self.levelButton.setTitle(String(Int(levelSlider.value)), forState: UIControlState.Normal)
        self.resetLevel()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didWinGame", name: "didWinGame", object: nil  )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didWinGame() {
        self.levelSlider.value += 1
        self.levelSliderChanged(self)
        self.resetLevel()
        wonSound?.play()
    }
    
    func resetLevel() {
        let levelFromSlider = self.levelSlider.value
        game.level = Int(levelFromSlider)
        game.newGame()
        lightsOutView.setNeedsDisplay()
    }
    
    func fadeOut() {
        
        UIView.animateWithDuration(1.0, animations: {
            self.levelSlider.alpha = 0.0
            }, completion: {
                (_: Bool) in
                self.levelSlider.hidden = true
                self.levelSlider.alpha = 1.0
        })
    }

}

