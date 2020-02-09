//
//  Zombie.swift
//  ZombieConga
//
//  Created by Kevin Kruusi on 2020-02-04.
//  Copyright © 2020 kevin. All rights reserved.
//

import Foundation
import SpriteKit

class Zombie: SKSpriteNode {
    
    static let zombieImageNames: [String] = ["zombie1", "zombie2", "zombie3", "zombie4"]
    static let idleAnimationKey = "Idle"
    var target = CGPoint();
    
    init(){
        let texture = SKTexture(imageNamed: "zombie1")
        super.init(texture: texture, color: .clear, size: texture.size())
        
        let idle = animation(sprites: [SKTexture(imageNamed: "zombie1"),
                                           SKTexture(imageNamed: "zombie2"),
                                           SKTexture(imageNamed: "zombie3"),
                                           SKTexture(imageNamed: "zombie4")],
                             duration: 0.5,
                                  repeats: true)
        
        
        self.run(idle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(timeInterval: TimeInterval) {
        if(self.position != target){
            //move(timeinterval: timeInterval)
        }
        
    }
    
    /*func move(timeinterval: TimeInterval){
        let forwardvec = CGVector(dx: target.x - self.position.x, dy: target.y - self.position.y)
        let fory = CGFloat(forwardvec.dy * forwardvec.dy)
        let forx = CGFloat(forwardvec.dx * forwardvec.dx)
        let mag:CGFloat = sqrt( forx + fory)
        let movevec = CGVector(dx: (forwardvec.dx / mag) * 200.0, dy: (forwardvec.dy/mag) * 200.0)
        let moveact = SKAction.move(by:movevec, duration: timeinterval)
        self.run(moveact)
    }*/
}

