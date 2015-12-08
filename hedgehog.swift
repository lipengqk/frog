//
//  hedgedog.swift
//  frog
//
//  Created by 李碰 on 15/8/22.
//  Copyright (c) 2015年 李碰. All rights reserved.
//

import SpriteKit

enum  hStatus:Int {
    case run = 1,runleft;
}


class Hedgehog : SKSpriteNode {
    
    let   reduceWaitingImage :CGFloat  = 12
    
    let hedgehogAtlas = SKTextureAtlas(named: "hedgehog.atlas")
    var hedgehogFrames = [SKTexture]()
    

    
    let hedgehogleftAtlas = SKTextureAtlas(named: "hedgehogleft.atlas")
    var hedgehogleftFrames = [SKTexture]()
    
   // var hedgehogs = [Hedgehog]()
    
    var hstatus = hStatus.run
    
    
    
    func onCreate(){
        
       let texture = hedgehogAtlas.textureNamed("hedgehog1")
        let size = texture.size()
        //super.init(texture:texture,color: UIColor.whiteColor(), size: CGSize(width: (size.width / reduceWaitingImage)  , height: (size.height / reduceWaitingImage)))
       // let hedgehog = Hedgehog()
        //let hedgehog = Hedgehog()
       // self.anchorPoint = CGPointMake(0, 0)
       // self.position = CGPointMake(x, y)
        self.size = CGSize(width: (size.width / reduceWaitingImage)  , height: (size.height / reduceWaitingImage))
        //super.init(texture: texture, color: UIColor.whiteColor(), size: CGSize(width: (size.width / reduceWaitingImage)  , height: (size.height / reduceWaitingImage)))
        var i:Int
        for i=1 ; i <= hedgehogAtlas.textureNames.count ; i++ {
            let tempName = String (format:"hedgehog%.1d",i )
            let hedgehogTexture = hedgehogAtlas.textureNamed(tempName)
           // if (hedgehogTexture == nil!) {
                hedgehogFrames.append(hedgehogTexture)
            //}
        }
        
        
        for i=1 ; i <= hedgehogleftAtlas.textureNames.count ; i++ {
            let tempName = String (format:"hedgehogleft%.1d",i )
            let hedgehogleftTexture = hedgehogleftAtlas.textureNamed(tempName)
           // if (hedgehogleftTexture == nil!) {
                hedgehogleftFrames.append(hedgehogleftTexture)
           // }
        }
        
        
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: (size.width / reduceWaitingImage)  , height: (size.height / reduceWaitingImage)) )
        self.physicsBody?.dynamic = true
        self.physicsBody?.allowsRotation = false// 角度
        //摩擦力
        self.physicsBody?.linearDamping = 0.0
        self.physicsBody?.friction = 0
        self.physicsBody?.restitution = 0.1 //反弹效果
        self.physicsBody?.categoryBitMask = BitMaskType.hedgehog
        
        self.physicsBody?.contactTestBitMask = BitMaskType.scene | BitMaskType.frog  //可以检测到跟谁碰撞
        self.physicsBody?.collisionBitMask =  BitMaskType.scene | BitMaskType.platform | BitMaskType.frog  //跟谁能产生作用
        
        //self.physicsBody?.velocity = CGVectorMake(200, 0)
        //self.addChild(self)
        //self.append(hedgehog)
        
        run()
    }


    
    func run(){
        self.removeAllActions()
        self.hstatus = .run
        self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(hedgehogFrames, timePerFrame: 0.2)))
        self.physicsBody?.velocity = CGVectorMake(200, 0)
        //self.move()
    }
    
    func runleft(){
        self.removeAllActions()
        self.hstatus = .runleft
        self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(hedgehogleftFrames, timePerFrame: 0.2)))
        self.physicsBody?.velocity = CGVectorMake(-200, 0)
        //self.physicsBody?.velocity = CGVectorMake(100, 200)
    }
    
  
}
