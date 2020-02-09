//
//  SKSpriteNode+Animations.swift
//  ZombieConga
//
//  Created by Kevin Kruusi on 2020-02-04.
//  Copyright © 2020 kevin. All rights reserved.
//

import Foundation
import SpriteKit

extension SKSpriteNode {
    
    func animation(sprites: [SKTexture], duration:TimeInterval, repeats:Bool) ->SKAction{
        let animationAction = SKAction.animate(with:sprites, timePerFrame: duration/Double(sprites.count))
        
       let reverse = animationAction.reversed()

       let sequence = SKAction.sequence([animationAction, reverse])
        
        if repeats{
            let repeataction = SKAction.repeatForever(sequence)
            return repeataction
        }
        return sequence
    }
    
    
    func rotate(destination: CGPoint) -> SKAction{
        let forwardvec = CGVector(dx: cos(self.zRotation), dy: sin(self.zRotation))
        let directionvec = CGPoint(x: destination.x - self.position.x, y: destination.y - self.position.y)
        let mag = sqrt((directionvec.x * directionvec.x) + (directionvec.y * directionvec.y))
        let direction = CGPoint(x:directionvec.x / mag, y: directionvec.y / mag)
        //let dot = (forwardvec.dx * direction.x) + (forwardvec.dy * direction.y)
        let angle = atan2(destination.y - self.position.y, destination.x - self.position.x)
        
        let rotate = SKAction.rotate(toAngle: angle, duration: 1, shortestUnitArc: true)
        
        return rotate
    }
    
    @objc func update(timeInterval: TimeInterval) {
        
    }
}
