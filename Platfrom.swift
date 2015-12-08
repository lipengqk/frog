//
//  Platfrom.swift
//  frog
//
//  Created by 李碰 on 15/8/16.
//  Copyright (c) 2015年 李碰. All rights reserved.
//

import SpriteKit
class Platfrom:SKNode {
    var width:CGFloat = 0
    var height:CGFloat = 1
    func onCreate(arrSprite: [SKSpriteNode]){
        for platfrom in arrSprite{
            platfrom.position.x = self.width
            self.addChild(platfrom)
            self.width += platfrom.size.width / 2
            platfrom.size = CGSize(width: (platfrom.size.width / 2 )  , height: (platfrom.size.height / 2 ))
            
            
            
//            self.physicsBody = SKPhysicsBody(rectangleOfSize: platfrom.size,center: CGPointMake(platfrom.position.x, 0.9))
//            self.physicsBody?.categoryBitMask = BitMaskType.platform
//            self.physicsBody?.dynamic = false
//            self.physicsBody?.allowsRotation = false
//            //mocali
//            self.physicsBody?.restitution = 0
        }
    

    }
}
