//
//  BackGround.swift
//  frog
//
//  Created by 李碰 on 15/8/17.
//  Copyright (c) 2015年 李碰. All rights reserved.
//

import SpriteKit
class BackGround:SKNode{

    var arrBG = [SKSpriteNode]()
    var arrFar = [SKSpriteNode]()
    
    override init() {
        super.init()
        let fartexture = SKTexture(imageNamed:  "background_f1")
        let farBg0 = SKSpriteNode(texture: fartexture)
        farBg0.anchorPoint = CGPointMake(0, 0)
        farBg0.position.x = 290
        
        let farBg1 = SKSpriteNode(texture: fartexture)
        farBg1.anchorPoint = CGPointMake(0, 0)
        farBg1.position.y = farBg0.frame.height
        farBg1.position.x = 290
        
        let farBg2 = SKSpriteNode(texture: fartexture)
        farBg2.anchorPoint = CGPointMake(0, 0)
        farBg2.position.y = farBg0.frame.height * 2
        farBg2.position.x = 290
        self.addChild(farBg0)
        self.addChild(farBg1)
        self.addChild(farBg2)
        
        arrFar.append(farBg0)
        arrFar.append(farBg1)
        arrFar.append(farBg2)
        //近处背景
//        var texture = SKTexture(imageNamed: "background_f1")
//        var bg0 = SKSpriteNode(texture: texture)
//        bg0.anchorPoint = CGPointMake(0, 0)
//        bg0.position.y = 70
//        
//        var bg1 = SKSpriteNode(texture: texture)
//        bg1.anchorPoint = CGPointMake(0, 0)
//        bg1.position.x = bg0.frame.width
//        bg1.position.y = 70
//        arrBG.append(bg0)
//        arrBG.append(bg1)

    }
    func move (speed:CGFloat){
    //近景
        for farBg in arrFar{
            farBg.position.y -= speed
            
        }
        if arrFar.isEmpty == false{
        if arrFar[0].position.y + arrFar[0].size.height < speed {
            arrFar[0].position.y = 0
            arrFar[1].position.y = arrFar[1].frame.size.height
            arrFar[2].position.y = arrFar[2].frame.size.height * 2
            
        }
        }
    //远景
//        for farBg in arrFar{
//            farBg.position.y -= speed/4
//            
//        }
//        if arrFar[0].position.y + arrFar[0].size.height < speed {
//            arrFar[0].position.y = 0
//            arrFar[1].position.y = arrFar[1].frame.size.height
//            arrFar[2].position.y = arrFar[2].frame.size.height * 2}
//        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
