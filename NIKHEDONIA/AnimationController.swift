//
//  AnimationController.swift
//  NIKHEDONIA
//
//  Created by Zachary Williams on 12/30/17.
//  Copyright © 2017 Zachary Williams. All rights reserved.
//

import Foundation
import SpriteKit

class AnimationController {
    
    static let AnimationSpeedMultiplier = 1.0
    
    // animate a label
    static func animate ( label : SKLabelNode ) {
        // set up vars
        let animationTime = 0.1 * AnimationSpeedMultiplier
        let wiggleAmount = CGFloat(0.06)
        // create "wiggle" animations
        let wiggle1 = SKAction.rotate(byAngle: wiggleAmount, duration: animationTime)
        let wiggle2 = SKAction.rotate(byAngle: -1.0 * (wiggleAmount * 2.0), duration: animationTime)
        let wiggle3 = SKAction.rotate(byAngle: wiggleAmount, duration: animationTime)
        // create "scale" animations
        let scaleDown = SKAction.scale(to: 0.8, duration: animationTime)
        let scaleUp = SKAction.scale(to: 1.0, duration: animationTime)
        // run wiggle and scale animations
        label.run(wiggle1, completion: { label.run(wiggle2, completion: { label.run(wiggle3) }) })
        label.run(scaleDown, completion: { label.run(scaleUp) })
    }
    
    // animate a button
    static func animate ( button : SKSpriteNode ) {
        // set up vars
        let animationTime = 0.13 * AnimationSpeedMultiplier
        // create animations
        let scaleDown = SKAction.scale(to: 0.8, duration: animationTime)
        let scaleUp = SKAction.scale(to: 1.0, duration: animationTime)
        // run animations
        button.run(scaleDown, completion: { button.run(scaleUp) })
    }
    
    // animate a tile
    static func animate ( tile : SKSpriteNode ) {
        // set up vars
        let animationTime = 0.13 * AnimationSpeedMultiplier
        // create animations
        let scaleDown = SKAction.scale(to: 0.8, duration: animationTime)
        let scaleUp = SKAction.scale(to: 1.0, duration: animationTime)
        // run animations
        tile.run(scaleDown, completion: { tile.run(scaleUp) })
    }
    
}
