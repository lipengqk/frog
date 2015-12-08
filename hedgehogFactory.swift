


import SpriteKit

//enum  hStatus:Int {
//    case run = 1,runleft;
//}


class HedgehogFactory : SKNode {
    
    let   reduceWaitingImage :CGFloat  = 12

    var hedgehogs = [Hedgehog]()
    

    
    
    
    func createHedgehog(x:CGFloat,y:CGFloat){
        

        let hedgehog = Hedgehog()

        hedgehog.position = CGPointMake(x, y)

        hedgehog.onCreate()
        self.addChild(hedgehog)
        
        hedgehogs.append(hedgehog)
        

    }
    

    func move (speed:CGFloat)
    {
        for p in hedgehogs {
            
            p.position.y -= speed
        }
        if   (hedgehogs.isEmpty == false) {
            if hedgehogs[0].position.y < 0 + hedgehogs[0].size.height  {
            hedgehogs[0].removeFromParent()
            hedgehogs.removeAtIndex(0)
            
            }
        }
        
    }
    
    
    func moveRight (speed:CGFloat){
        self.position.x += speed
    }
    func moveleft (speed:CGFloat){
        self.position.x -= speed
    }
    func reSet(){
    self.removeAllChildren()
      hedgehogs.removeAll(keepCapacity: false)
    }
}
