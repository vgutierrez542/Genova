//
//  VGGround.swift
//  Genova
//
//  Created by Victor Gutierrez on 1/18/18.
//  Copyright © 2018 Victor Gutierrez. All rights reserved.
//

import Foundation
import SpriteKit

class VGGround: SKSpriteNode {
    
    let numberSegments = 100
    let colorOne = UIColor(red: 66/255, green: 120/255, blue: 100/250, alpha: 1)
    let colorTwo = UIColor(red: 50/255, green: 100/250, blue: 70/250, alpha: 1)
    
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor.brown, size: CGSize(width: size.width * 10, height: size.height))
        
        anchorPoint = CGPoint(x: 0, y: 0.5)
        
        for i in 0 ..< numberSegments {
            var segmentColor: UIColor!
            if i % 2 == 0 {
                segmentColor = colorOne
            } else {
                segmentColor = colorTwo
            }
            
            let segment = SKSpriteNode(color: segmentColor, size: CGSize(width: self.size.width/CGFloat(numberSegments), height: self.size.height))
            segment.anchorPoint = CGPoint(x: 0, y: 0.5)
            segment.position = CGPoint(x: CGFloat(i) * segment.size.width, y: 0)
            addChild(segment);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start(isLeft: Bool) {
        let moveLeft = SKAction.moveBy(x: -frame.size.width/20, y: 0, duration: 7.0)
        let moveRight = SKAction.moveBy(x: frame.size.width/20, y: 0, duration: 7.0)
        
        //uncomment next line to reset the ground when the end is reached
        //let resetPosition = SKAction.moveTo(x: 0, duration: 0)
        //var moveSequence = SKAction.sequence([moveLeft, resetPosition])
        
        //if the user chooses to "move" the sprite left
        //then the ground moves right
        if isLeft == false {
            //uncomment next line to use resetPosition
            //moveSequence = SKAction.sequence([moveRight, resetPosition])
            run(SKAction.repeatForever(moveRight), withKey: "moveGround")
        } else {
            run(SKAction.repeatForever(moveLeft), withKey: "moveGround")
        }
        
        //this moves the floor when the screen is pressed
        //run(moveSequence)
        
        //this runs the action forever
        //run(SKAction.repeatForever(moveSequence), withKey: "moveGround")
    }
    
    /*
     *
     */
    func jump(isLeft: Bool) {
        let moveLeft = SKAction.moveBy(x: -frame.size.width/90, y: 0, duration: 0.65)
        let moveRight = SKAction.moveBy(x: frame.size.width/90, y: 0, duration: 0.65)
        let key = "jumpGround"
        
        if isLeft == false {
            run(moveRight, withKey: key)
        } else {
            run(moveLeft, withKey: key)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2, execute: {
            self.stop(key: key)
            })
    }
    
    func stop(key: String){
        //stops the moving ground action
        removeAction(forKey: key)
        //sets the floor back before stoping the moveGround action
        //run(SKAction.moveTo(x: 0, duration: 0))
    }
    
}

