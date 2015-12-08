//
//  GameScene.swift
//  frog
//
//  Created by 李碰 on 15/8/13.
//  Copyright (c) 2015年 李碰. All rights reserved.
//

import SpriteKit


class GameScene: SKScene ,ProtocolMainScene,SKPhysicsContactDelegate{
    lazy var frog = Frog()
    lazy var platfromFactroy = PlatfromFactroy()
    lazy var bg = BackGround()
    lazy var hedgehog = HedgehogFactory()
    
    let myLabel = SKLabelNode(fontNamed:"Chalkduster")
    let scoreLab = SKLabelNode(fontNamed:"Chalkduster")
    let scoretext = NSLocalizedString("score", comment: "score翻译")
    let gameovertext = NSLocalizedString("Game Over", comment: "Game Over翻译")
    var moveSpeed:CGFloat = 0.8
//    var y:CGFloat = 0
    var score:Int = 0
    var lastDis:CGFloat = 15
    var start = false
    var isLose = false
   // var t = CGSize(width:0,height:0)
   //碰撞检测函数
//    override func drawLayer(layer: CALayer!, inContext ctx: CGContext!) {
//        let path = UIBezierPath()
//        path.moveToPoint(CGPoint(x: 0,y: 0))
//        path.addLineToPoint(CGPoint(x:self.frame.size.width / 2 - (self.frame.size.height / 16 * 9 / 2 ),y:0 ))
//        path.addLineToPoint(CGPoint(x:0,y:self.frame.size.height))
//        path.moveToPoint(CGPoint(x:self.frame.size.width / 2 - (self.frame.size.height / 16 * 9 / 2 ),y:0 ))
//        path.addLineToPoint(CGPoint(x:self.frame.size.width / 2 - (self.frame.size.height / 16 * 9 / 2 ),y:self.frame.size.height ))
//        path.closePath()
//        UIColor.greenColor().setFill()
//        UIColor.redColor().setStroke()
//        path.lineWidth = 3.0
//        path.fill()
//        path.stroke()
//    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (BitMaskType.scene | BitMaskType.frog){
            frog.waiting()
            if frog.position.y <= frog.size.height {
                //println("youxijieshu"）
                gameover()
                
                }
        }
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (BitMaskType.platform | BitMaskType.frog){
            
           // if frog.status != Status.charge {
                frog.waiting()
           // }
        }
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (BitMaskType.scene | BitMaskType.hedgehog){
            for p in hedgehog.hedgehogs {  if p.position.x < (self.frame.size.width / 2 - (self.frame.size.height / 16 * 9 / 2 ) + p.size.width ) {
                p.run()
            } else if p.position.x > (self.frame.size.width / 2 + (self.frame.size.height / 16 * 9 / 2 ) - p.size.width ) {  p.runleft() }
            }
            
        }
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (BitMaskType.frog | BitMaskType.hedgehog) {

        print("youxijieshu")
            gameover()
        }
        
    }
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
      
        let backleft = SKShapeNode(rect: CGRect(x: 0 , y: 0, width: self.frame.size.width / 2 - (self.frame.size.height / 16 * 9 / 2 ), height: self.frame.size.height))
        backleft.zPosition = 100
        backleft.lineWidth = 0
        backleft.fillColor = UIColor.blackColor()
        self.addChild(backleft)
        
        let backright = SKShapeNode(rect: CGRect(x: self.frame.size.width / 2 + (self.frame.size.height / 16 * 9 / 2 ) , y: 0, width: self.frame.size.width / 2 - (self.frame.size.height / 16 * 9 / 2 ), height: self.frame.size.height))
        backright.zPosition = 100
        backright.lineWidth = 0
        backright.fillColor = UIColor.blackColor()
        self.addChild(backright)
        
        scoreLab.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        scoreLab.position = CGPoint(x: self.frame.size.width*0.4, y: self.frame.size.height - scoreLab.fontSize)
        scoreLab.text = "\(scoretext): 0 "
        scoreLab.zPosition = 100
        self.addChild(scoreLab)
        
        
        
        
        
        myLabel.text = "";
        myLabel.fontSize = 65;
        myLabel.zPosition = 100
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(myLabel)
        
        
        
        let  wellColor = SKColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1)
        self.backgroundColor = wellColor
        
        self.addChild(bg)
        bg.zPosition = 20
        

        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVectorMake(0, -5)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: self.frame.size.width / 2 - (self.frame.size.height / 16 * 9 / 2 ) , y: 0, width: self.frame.size.height / 16 * 9  , height: self.frame.size.height ))
        self.physicsBody?.categoryBitMask = BitMaskType.scene
        self.physicsBody?.dynamic = false
        
        
        frog.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.size.height * 0.55)
        frog.zPosition = 40
        self.addChild(frog)
        

        self.addChild(platfromFactroy)
        platfromFactroy.createPlatform(1,x: self.frame.size.width * 0.38,y: self.frame.size.height * 0.83)
       platfromFactroy.createPlatform(1,x: self.frame.size.width * 0.45,y: self.frame.size.height * 0.65)

        platfromFactroy.createPlatform(2,x: self.frame.size.width * 0.25,y: self.frame.size.height * 0.47)


        platfromFactroy.delegate = self
        platfromFactroy.zPosition = 30
        platfromFactroy.sceneWidth = self.frame.size.height
        
        self.addChild(hedgehog)
        hedgehog.zPosition = 40
        hedgehog.createHedgehog(self.frame.size.width * 0.5,y: self.frame.size.height * 0.9)
        
        
        let longpressGesutre = UILongPressGestureRecognizer(target: self, action: "handleLongpressGesture:")
        //长按时间为1秒
        longpressGesutre.minimumPressDuration = 0.5
        //允许15秒运动
        longpressGesutre.allowableMovement = 15
        
        //所需触摸1次
        longpressGesutre.numberOfTouchesRequired = 1
        self.view!.addGestureRecognizer(longpressGesutre)
        
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipeGesture:")
        self.view!.addGestureRecognizer(swipeGesture)
        //左划
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipeGesture:")
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.Left //不设置是右
        self.view!.addGestureRecognizer(swipeLeftGesture)
        
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipeGesture:")
        swipeUpGesture.direction = UISwipeGestureRecognizerDirection.Up //设置up
        self.view!.addGestureRecognizer(swipeUpGesture)
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleTapGesture:")
        //设置手势点击数,双击：点2下
        tapGesture.numberOfTapsRequired = 1
        self.view!.addGestureRecognizer(tapGesture)
        

        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if isLose {
//            reSet()
//            
//        }
        /* Called when a touch begins */
        
//        for touch in (touches as! Set<UITouch>) {
//            let location = touch.locationInNode(self)
//            
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
//        }
        
//        if frog.status == Status.waiting {
//        
//            frog.jump()
//     }
//            else if frog.status == Status.jump {
//        frog.run()
//        }
    }
   
    func handleLongpressGesture(sender : UILongPressGestureRecognizer){
        
        if isLose {
            reSet()
            
        }else if sender.state == UIGestureRecognizerState.Began{
            if frog.status == Status.waiting{         //手势开始
            frog.charge()}
        }else if sender.state == UIGestureRecognizerState.Ended{    //手势结束
        frog.jump(false)
//            platfromFactroy.move(moveSpeed*2)
        }
        
    }
    
    
    func handleTapGesture(sender: UITapGestureRecognizer){
        if isLose {
            reSet()
            
        }else  if frog.status == Status.waiting {
        
                    frog.jump(true)
 //                   platfromFactroy.move(moveSpeed)
             }
    }
    
    func handleSwipeGesture(sender: UISwipeGestureRecognizer){
        //划动的方向
        let direction = sender.direction
        //判断是上下左右
        switch (direction){
        case UISwipeGestureRecognizerDirection.Left:
            if frog.status == Status.waiting{frog.runleft()} else if frog.status == Status.jump{frog.runleft()}
            break
        case UISwipeGestureRecognizerDirection.Right:
            if frog.status == Status.waiting { frog.run()}else if frog.status == Status.jump{frog.run()}
            break
        case UISwipeGestureRecognizerDirection.Up:
            if frog.status == Status.waiting { frog.jump(true)}
            break

            
        default:
            break
        }

    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if isLose {
            
        }else{
        
        bg.move((moveSpeed)/2)
        lastDis -= (moveSpeed )/2
        if lastDis <= 0{
            print("xinpingt")
            score++
            platfromFactroy.createPlatform(arc4random()%2 + 1,x: (self.frame.size.width * 0.29 ) * CGFloat((Float32(arc4random()%5) * 0.25 + 0.8)),y: self.frame.size.height * 0.99)
            hedgehog.createHedgehog(self.frame.size.width * 0.5,y: self.frame.size.height * 0.97)
            scoreLab.text = "\(scoretext): \(score)"
        //platfromFactroy.createPlatormRandom()
        }
         
        platfromFactroy.move(moveSpeed )
        frog.move(moveSpeed )
  
        hedgehog.move(moveSpeed  - 0.5)
        
        
        //不同速度情况下，撞击选择
        if frog.physicsBody?.velocity.dy > 0 {
            frog.physicsBody?.collisionBitMask =  BitMaskType.scene
            frog.physicsBody?.contactTestBitMask = BitMaskType.scene
        }
        if frog.physicsBody?.velocity.dy <= 0 {
            frog.physicsBody?.collisionBitMask =  BitMaskType.scene | BitMaskType.platform
            frog.physicsBody?.contactTestBitMask = BitMaskType.scene | BitMaskType.platform
        }
        //不同位置情况下，撞击选择
        if frog.position.y > self.frame.size.height*0.73 {
            //frog.physicsBody?.collisionBitMask =  BitMaskType.platform
            moveSpeed = 10

        }
//        if frog.position.y == self.frame.size.height * 0.6 {
//                y = y + 1.0
//        }
        if frog.position.y < self.frame.size.height * 0.45{
            moveSpeed = 0.8
            }
        
        }
    }
    
    func onGetData(dist: CGFloat) {
        
        self.lastDis = dist
    }
    func reSet(){
        platfromFactroy.createPlatform(1,x: self.frame.size.width * 0.38,y: self.frame.size.height * 0.82)
        
        platfromFactroy.createPlatform(1,x: self.frame.size.width * 0.45,y: self.frame.size.height * 0.64)
        
        platfromFactroy.createPlatform(2,x: self.frame.size.width * 0.25,y: self.frame.size.height * 0.46)
        
        
        myLabel.text = ""
        
        frog.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        frog.zPosition = 40
        frog.waiting()
        isLose = false
        self.addChild(frog)
        frog.physicsBody?.velocity = CGVectorMake(0, 0)
        score = 0
        
    }
    func gameover(){
    isLose = true
    frog.removeFromParent()
    hedgehog.reSet()
    myLabel.text = "\(gameovertext)"
    platfromFactroy.reSet()
    
    }
    


    
}


protocol ProtocolMainScene {
    
    func onGetData (dist:CGFloat)
}
