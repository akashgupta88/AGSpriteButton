//
//  AGSpriteButton.h
//  AGSpriteButton
//
//  Created by Akash Gupta on 18/06/14.
//  Copyright (c) 2014 Akash Gupta. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_OPTIONS(int, AGButtonControlEvent)
{
    AGButtonControlEventTouchDown = 1,
    AGButtonControlEventTouchUp,
    AGButtonControlEventTouchUpInside,
    AGButtonControlEventAllEvents
};


@interface AGSpriteButton : SKSpriteNode


@property (setter = setExclusiveTouch:, getter = isExclusiveTouch) BOOL exclusiveTouch;

@property (strong, nonatomic) SKLabelNode *label;


//CLASS METHODS FOR CREATING BUTTON

+(AGSpriteButton*)buttonWithImageNamed:(NSString*)image;

+(AGSpriteButton*)buttonWithColor:(SKColor*)color andSize:(CGSize)size;

+(AGSpriteButton*)buttonWithTexture:(SKTexture*)texture andSize:(CGSize)size;

+(AGSpriteButton *)buttonWithTexture:(SKTexture *)texture;

//TARGET HANDLER METHODS (Similar to UIButton)

-(void)addTarget:(id)target selector:(SEL)selector withObject:(id)object forControlEvent:(AGButtonControlEvent)controlEvent;

-(void)removeTarget:(id)target selector:(SEL)selector forControlEvent:(AGButtonControlEvent)controlEvent;

-(void)removeAllTargets;


//LABEL METHOD

-(void)setLabelWithText:(NSString*)text andFont:(UIFont*)font withColor:(UIColor*)fontColor;

//Explicit Transform method

-(void)transformForTouchDown;
-(void)transformForTouchUp;



@end
