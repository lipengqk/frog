//
//  GameViewController.swift
//  frog
//
//  Created by 李碰 on 15/8/13.
//  Copyright (c) 2015年 李碰. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
        
//        let path = UIBezierPath()
//        path.moveToPoint(CGPoint(x: 0,y: 0))
//        path.addLineToPoint(CGPoint(x:self.view.frame.size.width / 2 - (self.view.frame.size.height / 16 * 9 / 2 ),y:0 ))
//        path.addLineToPoint(CGPoint(x:0,y:self.view.frame.size.height))
//        path.moveToPoint(CGPoint(x:self.view.frame.size.width / 2 - (self.view.frame.size.height / 16 * 9 / 2 ),y:0 ))
//        path.addLineToPoint(CGPoint(x:self.view.frame.size.width / 2 - (self.view.frame.size.height / 16 * 9 / 2 ),y:self.view.frame.size.height ))
//        path.closePath()
//        UIColor.greenColor().setFill()
//        UIColor.redColor().setStroke()
//        path.lineWidth = 3.0
//        path.fill()
//        path.stroke()
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return UIInterfaceOrientationMask.AllButUpsideDown
        } else {
            return UIInterfaceOrientationMask.All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
