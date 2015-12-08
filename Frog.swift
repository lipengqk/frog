//
//  Frog.swift
//  frog
//
//  Created by 李碰 on 15/8/13.
//  Copyright (c) 2015年 李碰. All rights reserved.
//

import SpriteKit

enum Status:Int{
    case waiting = 1,jump,run,charge,runleft;
}


class Frog : SKSpriteNode {
    
    var  reduceWaitingImage :CGFloat  = 2.5
    
    let waitingAtlas = SKTextureAtlas(named: "waiting.atlas")
    var  waitingFrames = [SKTexture]()
    
    let runAtlas = SKTextureAtlas(named: "run.atlas")
    var runFrames = [SKTexture]()
    
    let jumpAtlas = SKTextureAtlas(named: "jump.atlas")
    var jumpFrames = [SKTexture]()
    
    let chargeAtlas = SKTextureAtlas(named: "charge.atlas")
    var chargeFrames = [SKTexture]()
    
    let runleftAtlas = SKTextureAtlas(named: "runleft.atlas")
    var runleftFrames = [SKTexture]()
    
    
    var status = Status.waiting
    
    
    
    init(){
    
        let texture = waitingAtlas.textureNamed("waiting1")
        let size = texture.size()
        
        
        
        super.init(texture: texture, color: UIColor.whiteColor(), size: CGSize(width: (size.width / reduceWaitingImage)  , height: (size.height / reduceWaitingImage)))
        var i:Int
        for i=1 ; i <= waitingAtlas.textureNames.count ; i++ {
            let tempName = String (format:"waiting%.2d",i )
            let waitingTexture = waitingAtlas.textureNamed(tempName)
            //if (waitingTexture == nil!) {
                waitingFrames.append(waitingTexture)
            //}
        }
        
        
        for i=1 ; i <= runAtlas.textureNames.count ; i++ {
            let tempName = String (format:"run%.1d",i )
            let runTexture = runAtlas.textureNamed(tempName)
           //if (runTexture == nil!) {
                runFrames.append(runTexture)
            //}
        }
        
        
        for i=1 ; i <= jumpAtlas.textureNames.count ; i++ {
            let tempName = String (format:"jump%.1d",i )
            let jumpTexture = jumpAtlas.textureNamed(tempName)
           // if (jumpTexture == nil!) {
                jumpFrames.append(jumpTexture)
            //}
        }
        
        for i=1 ; i <= chargeAtlas.textureNames.count ; i++ {
            let tempName = String (format:"charge%.1d",i )
            let chargeTexture = chargeAtlas.textureNamed(tempName)
            //if (chargeTexture == nil!) {
                chargeFrames.append(chargeTexture)
            //}
        }
        for i=1 ; i <= runleftAtlas.textureNames.count ; i++ {
            let tempName = String (format:"runleft%.1d",i )
            let runleftTexture = runleftAtlas.textureNamed(tempName)
           // if (runleftTexture == nil!) {
                runleftFrames.append(runleftTexture)
            //}
        }
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: (size.width / reduceWaitingImage)  , height: (size.height / 3)) )
        self.physicsBody?.dynamic = true
        self.physicsBody?.allowsRotation = false// 角度
        //摩擦力
        self.physicsBody?.linearDamping = 0.7
        self.physicsBody?.restitution = 0 //反弹效果
        self.physicsBody?.categoryBitMask = BitMaskType.frog
        
        self.physicsBody?.contactTestBitMask = BitMaskType.scene | BitMaskType.platform  //可以检测到跟谁碰撞
        self.physicsBody?.collisionBitMask =  BitMaskType.scene | BitMaskType.platform   //跟谁能产生作用
        
        
       waiting()
    }

    func waiting(){
        self.removeAllActions()
        self.status = .waiting
        self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(waitingFrames, timePerFrame: 0.5)))
       // self.runAction(SKAction.repeatActionForever(SKAction.animateWithNormalTextures(waitingFrames, timePerFrame: 0.5)))
    }
    
    func run(){
        self.removeAllActions()
        self.status = .run
        self.runAction(SKAction.animateWithTextures(runFrames, timePerFrame: 0.2),completion:{()in
            self.waiting()
        })
        self.physicsBody?.velocity = CGVectorMake(120, 200)
    }
    
    func jump(i:Bool){
        self.removeAllActions()

        
        self.status = .jump
       self.runAction(SKAction.animateWithTextures(jumpFrames, timePerFrame: 0.25),completion:{()in
                      self.waiting()
                    })
        if i == true{
            self.physicsBody?.velocity = CGVectorMake(0, 580)}
        else if i == false {
            self.physicsBody?.velocity = CGVectorMake(0, 820)}
        
    }
    
    func charge(){
        self.removeAllActions()
        self.status = .charge
        self.runAction(SKAction.animateWithTextures(chargeFrames, timePerFrame: 0.5))
    }
    func runleft(){
        self.removeAllActions()
        self.status = .runleft
        self.runAction(SKAction.animateWithTextures(runleftFrames, timePerFrame: 0.2),completion:{()in
            self.waiting()
        })
        self.physicsBody?.velocity = CGVectorMake(-120, 200)
    }
    
    func move (speed:CGFloat)
    {
        
            self.position.y -= speed

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
