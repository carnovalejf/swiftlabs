//
//  GameScene.swift
//  ZombieConga
//
//  Created by Kevin Kruusi on 2018-02-04.
//  Copyright © 2018 kevin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    let player = Zombie()
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        let background = SKSpriteNode(imageNamed: "background1")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2 )
        addChild(background)
        addChild(player)
        player.zPosition = 1
        player.position = CGPoint(x: 400, y: 400)
    }
    
    override func update(_ currentTime: TimeInterval) {
        player.update(timeInterval: currentTime)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(children.contains(player)){
        for touch in touches{
            let touchLoc = touch.location(in: self)
            let directionx = touchLoc.x - player.position.x
            let directiony = touchLoc.y - player.position.y
            let mag = sqrt((directionx * directionx) + (directiony * directiony))
            
            let moveact = SKAction.move(to:touchLoc, duration: Double(mag) / 200)
            let rotateact = player.rotate(destination: touchLoc)
            let sequence = SKAction.group([rotateact,moveact])
            player.run(sequence)
            
            if((touchLoc.x < (player.position.x + 50)) && (touchLoc.x > (player.position.x - 50))){
                if((touchLoc.y < (player.position.y + 50)) && (touchLoc.y > (player.position.y - 50))){
                    let act = SKAction.removeFromParent();
                    splat(x:player.position.x, y: player.position.y)
                    player.run(act)
                    
                }
            }
        }
    }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(children.contains(player)){
        let projectile = SKSpriteNode(imageNamed: "cat")
        addChild(projectile)
        projectile.zPosition = 1
        projectile.position = CGPoint(x:player.position.x, y:player.position.y)
        
        let forwardvec = CGVector(dx: cos(player.zRotation), dy: sin(player.zRotation))
        let projectilelaunch = SKAction.moveBy(x:forwardvec.dx * 500, y:forwardvec.dy * 500, duration: 1)
        let death = SKAction.removeFromParent()
        let sequence = SKAction.sequence([projectilelaunch, death])
        projectile.run(sequence)
        for touch in touches{
            let touchLoc = touch.location(in: self)
        }
        }
        
    }
    
    func splat(x: CGFloat, y: CGFloat){
        let splat = SKSpriteNode(imageNamed: "spla1")
        addChild(splat)
        splat.zPosition = 1
        splat.position = CGPoint(x: x, y: y)
        let splode = SKAction.animate(with: [SKTexture(imageNamed: "spla1"),
                 SKTexture(imageNamed: "spla2"),
                 SKTexture(imageNamed: "spla3"),
                 SKTexture(imageNamed: "spla4"),
                 SKTexture(imageNamed: "spla5"),
                 SKTexture(imageNamed: "spla6"),
                 SKTexture(imageNamed: "spla7"),
                 SKTexture(imageNamed: "spla8"),
                 SKTexture(imageNamed: "spla9")],
                                      timePerFrame: 0.2/Double(9))
        
        splat.run(splode)
    }
}







