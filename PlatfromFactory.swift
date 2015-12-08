//
//  PlatfromFactory.swift
//  frog
//
//  Created by 李碰 on 15/8/16.
//  Copyright (c) 2015年 李碰. All rights reserved.
//

import SpriteKit
class PlatfromFactroy:SKNode {
    let textureLeft = SKTexture(imageNamed: "platform_l")
    let textureMid = SKTexture(imageNamed: "platform_m")
    let textureRight = SKTexture(imageNamed: "platform_r")
    
    var platforms = [Platfrom]()
    
    var sceneWidth : CGFloat =  0  //接收主场景的高
    var delegate:ProtocolMainScene?
    
//    func createPlatormRandom(){
//    
//        let midNum:UInt32 = arc4random()%2 + 1
//        
//        
//       // let gap:CGFloat = CGFloat(arc4random()%8+1)
//        let x : CGFloat = 30
//        let y : CGFloat =  700
//        
//        createPlatform(midNum,  x: x,y: y )
//    }
    
    
    
    func createPlatform(midNum:UInt32,x:CGFloat,y:CGFloat){
    let platfrom = Platfrom()
        let platfrom_left = SKSpriteNode(texture: textureLeft)
        platfrom_left.anchorPoint = CGPointMake(0,0)
        
        
        platfrom_left.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: (platfrom_left.size.width / 2    )  , height: (platfrom_left.size.height  / 2 )),      center : CGPointMake(platfrom_left.size.width / 4, platfrom_left.size.height / 4)
        )
        platfrom_left.physicsBody?.categoryBitMask = BitMaskType.platform
        platfrom_left.physicsBody?.dynamic = false
        platfrom_left.physicsBody?.allowsRotation = false
        //mocali
       // platfrom_left.physicsBody?.linearDamping = 1
        platfrom_left.physicsBody?.restitution = 0
        
        
        let platfrom_right = SKSpriteNode(texture: textureRight)
        platfrom_right.anchorPoint = CGPointMake(0,0)
        
        platfrom_right.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: (platfrom_right.size.width / 2   )  , height: (platfrom_right.size.height / 2 )),      center : CGPointMake(platfrom_right.size.width / 4, platfrom_right.size.height / 4)
        )
        platfrom_right.physicsBody?.categoryBitMask = BitMaskType.platform
        platfrom_right.physicsBody?.dynamic = false
        platfrom_right.physicsBody?.allowsRotation = false
        //mocali
        //platfrom_right.physicsBody?.linearDamping = 1
        platfrom_right.physicsBody?.restitution = 0
        
        var arrPlatfrom = [SKSpriteNode]()
        
        arrPlatfrom.append(platfrom_left)
        platfrom.position = CGPointMake(x, y)
        
        
        

        

        
        for  _ in 1...midNum{
        
            let platfrom_mid = SKSpriteNode(texture: textureMid)
            platfrom_mid.anchorPoint = CGPointMake(0, 0)
            
            
            platfrom_mid.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: (platfrom_mid.size.width  / 2 )  , height: (platfrom_mid.size.height  / 2 )),
                center : CGPointMake(platfrom_mid.size.width / 4, platfrom_mid.size.height / 4))
            platfrom_mid.physicsBody?.categoryBitMask = BitMaskType.platform
            platfrom_mid.physicsBody?.dynamic = false
            platfrom_mid.physicsBody?.allowsRotation = false
            //mocali
            //platfrom_mid.physicsBody?.linearDamping = 1
            platfrom_mid.physicsBody?.restitution = 0
            arrPlatfrom.append(platfrom_mid)
        }
        arrPlatfrom.append(platfrom_right)
        
        platfrom.onCreate(arrPlatfrom)

        
        
        self.addChild(platfrom)
    
        platforms.append(platfrom)
        
        delegate?.onGetData(y+platfrom.height - sceneWidth*0.9)//平台的高度＋y坐标－主场景的高度
    }
    func move (speed:CGFloat)
    {
        for p in platforms {
        
            p.position.y -= speed
        }
        if platforms.isEmpty == false{
        if platforms[0].position.y < 0 {
        platforms[0].removeFromParent()
            platforms.removeAtIndex(0)
            
        }
        }
    }
    func reSet(){
        self.removeAllChildren()
        platforms.removeAll(keepCapacity: false)
    }
}
