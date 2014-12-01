//
//  SwiftTest.swift
//  AGSpriteButton
//
//  Created by Akash Gupta on 01/12/14.
//  Copyright (c) 2014 Akash Gupta. All rights reserved.
//

import Foundation

//Example on setting button in Swift.

var button:AGSpriteButton = AGSpriteButton(color:UIColor.redColor(), size:CGSize(width:100, height:50))
button.position = CGPoint(x:10, y:10)

self.addChild(button)


