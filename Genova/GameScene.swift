//
//  GameScene.swift
//  Genova
//
//  Created by Victor Gutierrez on 1/17/18.
//  Copyright © 2018 Victor Gutierrez. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var movingGround: VGGround!
    private var skeleton: VGSprite!
    
    override func didMove(to view: SKView) {
        /********INITIALZNG AND ANIMATING THE GROUND*****************/
        movingGround = VGGround(size: CGSize(width: view.frame.width, height: 30))
        movingGround.position = CGPoint(x: 0, y: 0)
        addChild(movingGround)
        /************************************************************/
        
        /*********INITIALIZING AND ANIMATNG A SKELETON SPRITE********/
        createMainChar()
        /************************************************************/
    }
    
    /*
     * creatingMainChar() - creates, adds and sets the main character
     * in this case it is the skeleton
     */
    func createMainChar(){
        var skelSheetR: VGSpriteSheet!
        var skelSheetL: VGSpriteSheet!
        
        skelSheetL = VGSpriteSheet(frame: SKTexture(imageNamed: "SkeletonIdleLeft"), rows: 1, columns: 11)
        skelSheetR = VGSpriteSheet(frame: SKTexture(imageNamed: "SkeletonIdle"), rows: 1, columns: 11)
        skeleton = VGSprite(positionXYSizeWH: [Int((view?.frame.width)!)/2, 48, 35, 70],
                            idleLR: [skelSheetL, skelSheetR], facingRight: true)
        
        // size -> 286*33
        skelSheetL = VGSpriteSheet(frame: SKTexture(imageNamed: "SkeletonWalkLeft"), rows: 1, columns: 13)
        skelSheetR = VGSpriteSheet(frame: SKTexture(imageNamed: "SkeletonWalk"), rows: 1, columns: 13)
        skeleton.setWalk(leftWalk: skelSheetL, rightWalk: skelSheetR, row: 0)
        
        // size -> 774*37
        // width: (defSize.width * 1.955)
        // height: (defSize.height * 1.12)
        skelSheetL = VGSpriteSheet(frame: SKTexture(imageNamed: "SkeletonAttackLeft"), rows: 1, columns: 18)
        skelSheetR = VGSpriteSheet(frame: SKTexture(imageNamed: "SkeletonAttack"), rows: 1, columns: 18)
        skeleton.setAttack(leftAttack: skelSheetL, rightAttack: skelSheetR, row: 0)
        skeleton.setJump(leftJump: skelSheetL, rightJump: skelSheetR, row: 0)
        
        addChild(skeleton)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // This two llines get the location of the touch
        let touch = touches.first!
        let location = touch.location(in: self)
        
        // Checks which location of the sprite is pressed
        // The ground and the sprite move in oppisite directions
        if location.x > (view?.frame.width)!/2 {
            
            // animate the skeleton sprite
            skeleton.turnRight()
            
            // jump if the user press on the upper part of the screen
            // else walk
            if location.y > (view?.frame.height)!/2 {
                skeleton.setSize(size: CGSize(width: 60.0, height: 80.0))
                self.isUserInteractionEnabled = false
                skeleton.jump()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.movingGround.jump(isLeft: true)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.12, execute: {
                    self.isUserInteractionEnabled = true
                })
            } else {
                // move the ground to the left
                movingGround.start(isLeft:true)
                skeleton.walk()
            }
            
        } else {
            
            // animate the skeleton sprite
            skeleton.turnLeft()
            
            // jump if the user press on the upper part of the screen
            // else walk
            if location.y > (view?.frame.height)!/2 {
                skeleton.setSize(size: CGSize(width: 60.0, height: 80.0))
                self.isUserInteractionEnabled = false
                skeleton.jump()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.movingGround.jump(isLeft: false)
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.12, execute: {
                    self.isUserInteractionEnabled = true
                })
            } else {
                // move the ground right
                movingGround.start(isLeft: false)
                skeleton.walk()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      	// stop the animation of the ground
        movingGround.stop(key:"moveGround")
        // stop the skeleton animation
        skeleton.stop()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        }
}
