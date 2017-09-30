//
//  GameScene.swift
//  Arkanoid
//
//  Created by Arkaim on 9/28/17.
//  Copyright © 2017 Arkaim. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicBodies {
    static let BallPh: UInt32 = 1
    static let PlatformPh: UInt32 = 2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball: SKSpriteNode?
    var paddle: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as? SKSpriteNode
        paddle = self.childNode(withName: "paddle") as? SKSpriteNode
        self.physicsWorld.contactDelegate = self
        
        ball?.physicsBody?.applyImpulse(CGVector(dx:150, dy:150))
        
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
        
        border.friction = 0
        
        
        self.physicsBody = border
    }
    
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLoc = touch.location(in: self)
            paddle?.position.x = touchLoc.x
        }
    }
    

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLoc = touch.location(in: self)
            paddle?.position.x = touchLoc.x
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyB.node
        let bodyB = contact.bodyA.node
        
        if (bodyA?.physicsBody?.categoryBitMask == PhysicBodies.BallPh && bodyB?.physicsBody?.categoryBitMask == PhysicBodies.PlatformPh) {
            bodyB?.removeFromParent()
        }
        
        if (bodyA?.physicsBody?.categoryBitMask == PhysicBodies.PlatformPh && bodyB?.physicsBody?.categoryBitMask == PhysicBodies.BallPh) {
            bodyA?.removeFromParent()
        }
  
    }
    
    
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
