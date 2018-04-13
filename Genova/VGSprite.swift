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
    private var isOnGround = true
    private var defSize = CGSize()

    
    /*
     * initializes the sprites
     * standingIm - the standing sprite template
     * positionXYSizeWH - an array with the position and size of the sprite
     *                    the first to elements are the position (x,y) and
     *                    the others are the size (w,h)
	*/
    init(positionXYSizeWH: [Int], idleLR: [VGSpriteSheet], facingRight: Bool) {
    	
        self.facingRight = facingRight
        
        for i in 0...(idleLR[1].getColumns()-1) {
            idleRight.append(idleLR[1].textureForColumn(column: i, row: 0)!)
        }
        for i in (0...(idleLR[0].getColumns()-1)).reversed() {
            idleLeft.append(idleLR[0].textureForColumn(column: i, row: 0)!)
        }
        
        super.init(texture: idleRight[0], color: UIColor.clear,
            size: CGSize(width: positionXYSizeWH[2], height:
                positionXYSizeWH[3]))
        self.position = CGPoint(x: positionXYSizeWH[0], y:
            positionXYSizeWH[1])
        self.defSize = self.size
        
        self.run(SKAction.repeatForever(SKAction.animate(with: idleRight,
            timePerFrame: 0.12)))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     * setSize() - sets the size of sprite
     */
    func setSize(size: CGSize) {
        self.size = size
    }
    
    /*
     * jump - animates the sprite
     */
    func jump() {
        let jumping = SKAction.moveBy(x: 0, y: frame.size.height, duration: 0.3)
        let falling = SKAction.moveTo(y: 48, duration: 0.3)
        let defPosition = self.position
        self.isOnGround = false
        
        if facingRight {
            self.run(SKAction.animate(with: jumpRight,
                timePerFrame: 0.07), withKey: "jump")
            self.position = CGPoint(x: self.position.x + 8, y: self.position.y + 5)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.run(jumping)
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9, execute: {
                self.run(falling)
            })
        } else {
            self.run(SKAction.animate(with: jumpLeft,
                timePerFrame: 0.07), withKey: "jump")
            self.position = CGPoint(x: self.position.x - 8, y: self.position.y + 5)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.run(jumping)
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9, execute: {
                self.run(falling)
            })
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.15, execute:
        {
            self.setSize(size: self.defSize)
            self.isOnGround = true
            self.stop()
            self.position = defPosition
        })
    }
    
    /*
     * walk - animates the sprite
     */
    func walk() {
        if self.facingRight {
			self.run(SKAction.repeatForever(SKAction.animate(with: walkRight,
            	timePerFrame: 0.05)), withKey: "walk")
        } else {
            self.run(SKAction.repeatForever(SKAction.animate(with: walkLeft,
                timePerFrame: 0.05)), withKey: "walk")
        }
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
    func stop(){
        self.removeAction(forKey: "walk")
        
        if self.isOnGround{
       	 	if facingRight {
        	    self.run(SKAction.repeatForever(SKAction.animate(with:
                    idleRight,timePerFrame: 0.12)))
       	 	} else {
            	self.run(SKAction.repeatForever(SKAction.animate(with: idleLeft,
                    timePerFrame: 0.12)))
        	}
        }
    }
    
    // Detects if anything has
    // collided to the srite
    func collisionDetector(size: CGSize, position: CGPoint) -> Bool {
        return false
    }
    
    /*
     * setWalk - sets the walking arrays
     */
    func setWalk(leftWalk: VGSpriteSheet, rightWalk: VGSpriteSheet, row: Int) {
        for i in (0...(leftWalk.getColumns()-1)).reversed() {
            walkLeft.append(leftWalk.textureForColumn(column: i, row: row)!)
        }
        for i in 0...(rightWalk.getColumns()-1) {
            walkRight.append(rightWalk.textureForColumn(column: i, row: row)!)
        }
    }
    
    /*
     * setAttack - sets the attack arrays
     */
    func setAttack(leftAttack: VGSpriteSheet, rightAttack: VGSpriteSheet, row: Int) {
        for i in 0...(rightAttack.getColumns()-1) {
            attackRight.append(rightAttack.textureForColumn(column: i, row: row)!)
        }
        for i in (0...(leftAttack.getColumns()-1)).reversed() {
            attackLeft.append(leftAttack.textureForColumn(column: i, row: row)!)
        }
    }
    
    /*
     * setIdle - sets the iddle arrays
     */
    func setIdle(leftIdle: VGSpriteSheet, rightIdle: VGSpriteSheet, row: Int){
        for i in 0...(rightIdle.getColumns()-1) {
            idleRight.append(rightIdle.textureForColumn(column: i, row: row)!)
        }
        for i in (0...(leftIdle.getColumns()-1)).reversed() {
            idleLeft.append(leftIdle.textureForColumn(column: i, row: row)!)
        }
    }
    
    /*
     * setReact - sets the reaction arrays
     */
    func setReact(leftReact:VGSpriteSheet, rightReact: VGSpriteSheet, row: Int) {
        for i in 0...(rightReact.getColumns()-1) {
            reactRight.append(rightReact.textureForColumn(column: i, row: row)!)
        }
        for i in (0...(leftReact.getColumns()-1)).reversed() {
            reactLeft.append(leftReact.textureForColumn(column: i, row: row)!)
        }
    }
    
    /*
     * setDead - sets the dead arrays
     */
    func setDead(leftDead: VGSpriteSheet, rightDead: VGSpriteSheet, row: Int) {
        for i in 0...(rightDead.getColumns()-1) {
            deadRight.append(rightDead.textureForColumn(column: i, row: row)!)
        }
        for i in (0...(leftDead.getColumns()-1)).reversed() {
            deadLeft.append(leftDead.textureForColumn(column: i, row: row)!)
        }
    }
    
    /*
     * setHit - sets the hit arrays
     */
    func setHit(leftHit: VGSpriteSheet, rightHit: VGSpriteSheet, row: Int){
        for i in 0...(rightHit.getColumns()-1) {
            hitRight.append(rightHit.textureForColumn(column: i, row: row)!)
        }
        for i in (0...(leftHit.getColumns()-1)).reversed() {
            hitLeft.append(leftHit.textureForColumn(column: i, row: row)!)
        }
    }
    
    /*
     * setJump - sets the jumping array
     */
    func setJump(leftJump: VGSpriteSheet, rightJump: VGSpriteSheet, row: Int) {
        for i in (0...(rightJump.getColumns()-1)).reversed() {
            jumpRight.append(rightJump.textureForColumn(column: i, row: row)!)
        }
        for i in 0...(leftJump.getColumns()-1) {
            jumpLeft.append(leftJump.textureForColumn(column: i, row: row)!)
        }
    }
}
