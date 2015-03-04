//
//  AGSpriteButton.h
//  AGSpriteButton
//
//  Created by Akash Gupta on 18/06/14.
//  Copyright (c) 2014 Akash Gupta. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_OPTIONS(NSInteger, AGButtonControlEvent)
{
    AGButtonControlEventTouchDown = 1,  //When button is held down.
    AGButtonControlEventTouchUp,        //When button is released.
    AGButtonControlEventTouchUpInside,  //When button is tapped.
    AGButtonControlEventAllEvents       //Convenience event for deletion of selector, block or action.
};


@interface AGSpriteButton : SKSpriteNode


@property (setter = setExclusiveTouch:, getter = isExclusiveTouch) BOOL exclusiveTouch;

@property (strong, nonatomic) SKLabelNode *label;


//CLASS METHODS FOR CREATING BUTTON

+(AGSpriteButton*)buttonWithImageNamed:(NSString*)image;

+(AGSpriteButton*)buttonWithColor:(SKColor*)color andSize:(CGSize)size;

+(AGSpriteButton*)buttonWithTexture:(SKTexture*)texture andSize:(CGSize)size;

+(AGSpriteButton *)buttonWithTexture:(SKTexture *)texture;


//LABEL METHOD

-(void)setLabelWithText:(NSString*)text andFont:(UIFont*)font withColor:(SKColor*)fontColor;


//TARGET HANDLER METHODS (Similar to UIButton)

-(void)addTarget:(id)target selector:(SEL)selector withObject:(id)object forControlEvent:(AGButtonControlEvent)controlEvent;

-(void)removeTarget:(id)target selector:(SEL)selector forControlEvent:(AGButtonControlEvent)controlEvent;

-(void)removeAllTargets;


//EXECUTE BLOCKS ON EVENTS

-(void)performBlock:(void (^)())block onEvent:(AGButtonControlEvent)event;


//EXECUTE ACTIONS ON EVENTS

-(void)performAction:(SKAction*)action onNode:(SKNode*)object withEvent:(AGButtonControlEvent)event;


//Set animation actions for touchDown and touchUp

-(void)setTouchDownAction:(SKAction*)action;

-(void)setTouchUpAction:(SKAction*)action;


//Explicit Transform method. Call these methods to transform the button using code.

-(void)transformForTouchDown;

-(void)transformForTouchUp;

@end
