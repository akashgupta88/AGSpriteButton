//
//  SwiftScene.swift
//  AGSpriteButton
//
//  Created by Akash Gupta on 05/03/15.
//  Copyright (c) 2015 Akash Gupta. All rights reserved.
//

import Foundation
import UIKit

class SwiftScene: SKScene {
    
    let button = AGSpriteButton(color: UIColor.greenColor(), andSize: CGSize(width: 200, height: 60))
    
    override func didMoveToView(view: SKView) {
        
        button.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        
        button.addTarget(self, selector: #selector(SwiftScene.addSpaceship), withObject: nil, forControlEvent:AGButtonControlEvent.TouchUpInside)
        button.setLabelWithText("Spaceship", andFont: nil, withColor: UIColor.blackColor())
        
        addChild(button)
    }
    
    func addSpaceship () {
        
        let spaceship = SKSpriteNode(imageNamed: "Spaceship")
        
        spaceship.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        
        spaceship.physicsBody = SKPhysicsBody(circleOfRadius: spaceship.size.width / 2)
        
        addChild(spaceship)
        
    }
   
}
