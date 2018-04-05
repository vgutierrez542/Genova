//
//  VGSprite.swift
//  Genova
//
//  Created by Victor Gutierrez on 2/4/18.
//  Copyright © 2018 Victor Gutierrez. All rights reserved.
//
/*
 * VGSprite creates the sprite with the given
 * standing texture from VGSpriteSheet.
 * It also animates the sprite with an array
 * of textures that gets passed to.
*/

import Foundation
import SpriteKit

class VGSprite: SKSpriteNode {
    //private var standingIm: SKTexture
    private var walkRight = [SKTexture]()
    private var walkLeft = [SKTexture]()
    private var idleRight = [SKTexture]()
    private var idleLeft = [SKTexture]()
    private var attackRight = [SKTexture]()
    private var attackLeft = [SKTexture]()
    private var reactRight = [SKTexture]()
    private var reactLeft = [SKTexture]()
    private var hitRight = [SKTexture]()
    private var hitLeft = [SKTexture]()
    private var deadRight = [SKTexture]()
    private var deadLeft = [SKTexture]()
    private var jumpRight = [SKTexture]()
    private var jumpLeft = [SKTexture]()
    private var facingRight = true
    
    /*
     * initializes the sprites
     * standingIm - the standing sprite template
     * positionXYSizeWH - an array with the position and size of the sprite
     *                    the first to elements are the position (x,y) and
     *                    the others are the size (w,h)
	*/
    init(positionXYSizeWH: [Int], idleLR: [VGSpriteSheet], facingRight: Bool) {
    	
        self.facingRight = facingRight
        
        for i in 0...(idleLR[0].getRows()-1) {
            for j in 0...(idleLR[0].getColumns()-1){
                idleLeft.append(idleLR[0].textureForColumn(column: j, row: i)!)
                idleRight.append(idleLR[1].textureForColumn(column: j, row: i)!)
            }
           
        }
        
        super.init(texture: idleRight[0], color: UIColor.clear, size: CGSize(width: positionXYSizeWH[2], height: positionXYSizeWH[3]))
        self.position = CGPoint(x: positionXYSizeWH[0], y: positionXYSizeWH[1])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     * jump - animates the sprite
     */
    func jump() -> Bool {
        
        return false
    }
    func walk() -> Bool {
        if self.facingRight {
			self.run(SKAction.repeatForever(SKAction.animate(with: walkRight, timePerFrame: 0.05)))
        } else {
            self.run(SKAction.repeatForever(SKAction.animate(with: walkLeft, timePerFrame: 0.05)))
        }
        return true
    }
    
    // Turns the sprite to the left
    func turnLeft() {
        facingRight = false
    }
    
    // Turns the sprite to the right
    func turnRight() {
        facingRight = true
    }
    
    // Starts the animation
    // Always returns true
    func start(texture: SKTexture) -> Bool {
     
        return true;
    }
    
    // Stops the animation
    // Always returns false
    func stop() -> Bool {
        self.removeAllActions()
        if facingRight {
            self.run(SKAction.repeatForever(SKAction.animate(with: idleRight, timePerFrame: 0.05)))
        } else {
            self.run(SKAction.repeatForever(SKAction.animate(with: idleLeft, timePerFrame: 0.05)))
        }
        
        return false;
    }
    
    // Detects if anything has
    // collided to the srite
    func collisionDetector(size: CGSize, position: CGPoint) -> Bool {
        return false
    }
    
    /*
     * setWalk - sets the walking arrays
     */
    func setWalk(leftWalk: VGSpriteSheet, rightWalk: VGSpriteSheet) {
        for i in 0...(leftWalk.getRows()-1) {
            for j in 0...(leftWalk.getColumns()-1){
				walkLeft.append(leftWalk.textureForColumn(column: j, row: i)!)
                walkRight.append(rightWalk.textureForColumn(column: j, row: i)!)
            }
        }
    }
    
    /*
     * setAttack - sets the attack arrays
     */
    func setAttack(leftAttack: VGSpriteSheet, rightAtack: VGSpriteSheet) {
        for i in 0...(leftAttack.getRows()-1) {
            for j in 0...(leftAttack.getColumns()-1) {
                attackLeft.append(leftAttack.textureForColumn(column: j, row: i)!)
                attackRight.append(rightAtack.textureForColumn(column: j, row: i)!)
            }
        }
    }
    
    /*
     * setIdle - sets the iddle arrays
     */
    func setIdle(leftIdle: VGSpriteSheet, rightIdle: VGSpriteSheet){
        for i in 0...(leftIdle.getRows()-1) {
            for j in 0...(leftIdle.getColumns()-1){
                idleLeft.append(leftIdle.textureForColumn(column: j, row: i)!)
                idleRight.append(rightIdle.textureForColumn(column: j, row: i)!)
            }
        }
    }
    
    /*
     * setReact - sets the reaction arrays
     */
    func setReact(leftReact:VGSpriteSheet, rightReact: VGSpriteSheet) {
        for i in 0...(leftReact.getRows()-1) {
            for j in 0...(leftReact.getColumns()-1){
                reactLeft.append(leftReact.textureForColumn(column: j, row: i)!)
                reactRight.append(rightReact.textureForColumn(column: j, row: i)!)
            }
        }
    }
    
    /*
     * setDead - sets the dead arrays
     */
    func setDead(leftDead: VGSpriteSheet, rightDead: VGSpriteSheet) {
        for i in 0...(leftDead.getRows()-1) {
            for j in 0...(leftDead.getColumns()-1){
                deadLeft.append(leftDead.textureForColumn(column: j, row: i)!)
                deadRight.append(rightDead.textureForColumn(column: j, row: i)!)
            }
        }
    }
    
    /*
     * setHit - sets the hit arrays
     */
    func setHit(leftHit: VGSpriteSheet, rightHit: VGSpriteSheet){
        for i in 0...(leftHit.getRows()-1)  {
            for j in 0...(leftHit.getColumns()-1){
                hitLeft.append(leftHit.textureForColumn(column: j, row: i)!)
                hitRight.append(rightHit.textureForColumn(column: j, row: i)!)
            }
        }
    }
    
    /*
     * setJump - sets the jumping array
     */
    func setJump(leftJump: VGSpriteSheet, rightJump: VGSpriteSheet) {
        for i in 0...(leftJump.getRows()-1) {
            for j in 0...(leftJump.getColumns()-1){
                jumpLeft.append(leftJump.textureForColumn(column: j, row: i)!)
            	jumpRight.append(rightJump.textureForColumn(column: j, row: i)!)
            }
        }
    }
}
