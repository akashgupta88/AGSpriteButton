//
//  MyScene.m
//  AGSpriteButton
//
//  Created by Akash Gupta on 18/06/14.
//  Copyright (c) 2014 Akash Gupta. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];
        
        /*
         Adding AGSpriteButton
         
         */
        
        AGSpriteButton *button = [AGSpriteButton buttonWithColor:[UIColor redColor] andSize:CGSizeMake(300, 100)];
        [button setLabelWithText:@"Add New Spaceship" andFont:nil withColor:nil];
        button.position = CGPointMake(self.size.width / 2, self.size.height / 3);
        [self addChild:button];
        
        SKSpriteNode *someSprite = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(50, 50)];
        someSprite.position = CGPointMake(self.size.width/2, 100);
        [self addChild:someSprite];

        
        //Perform target for event
        [button addTarget:self selector:@selector(addSpaceshipAtPoint:) withObject:[NSValue valueWithCGPoint:CGPointMake(self.size.width / 2, self.size.height / 2)] forControlEvent:AGButtonControlEventTouchUpInside];
        
        //Perform action on event
        SKAction *rotate = [SKAction rotateByAngle:M_PI_4 duration:0.5];
        [button performAction:rotate onObject:someSprite withEvent:AGButtonControlEventTouchDown];
        
        //Perfrom block on event
        [button performBlock:^{
            [self addSpaceshipAtPoint:[NSValue valueWithCGPoint:CGPointMake(100, 100)]];
        } onEvent:AGButtonControlEventTouchUp];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        [self addSpaceshipAtPoint:[NSValue valueWithCGPoint:location]];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}


-(void)addSpaceshipAtPoint:(NSValue*)pointValue
{
    CGPoint point = [pointValue CGPointValue];
    
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    
    sprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:sprite.size.width / 2];
    
    sprite.position = point;
    
    SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
    
    [sprite runAction:[SKAction repeatActionForever:action]];
    
    [self addChild:sprite];

}
@end
