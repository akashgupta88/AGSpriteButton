//
//  AGSpriteButton.m
//  AGSpriteButton
//
//  Created by Akash Gupta on 18/06/14.
//  Copyright (c) 2014 Akash Gupta. All rights reserved.
//

#import "AGSpriteButton.h"

@implementation AGSpriteButton
{
    UITouch *currentTouch;
    NSMutableArray *marrSelectors;
    NSMutableArray *marrBlocks;
    NSMutableArray *marrActions;
    
    SKAction *actionTouchDown;
    SKAction *actionTouchUp;
}

#pragma mark - CLASS METHODS FOR INIT

+(AGSpriteButton *)buttonWithImageNamed:(NSString *)image
{
    AGSpriteButton *newButton = [[AGSpriteButton alloc]initWithImageNamed:image];
    
    return newButton;
}

+(AGSpriteButton *)buttonWithColor:(SKColor *)color andSize:(CGSize)size
{
    AGSpriteButton *newButton = [[AGSpriteButton alloc]initWithColor:color size:size];
    
    return newButton;
}

+(AGSpriteButton *)buttonWithTexture:(SKTexture *)texture andSize:(CGSize)size
{
    AGSpriteButton *newButton = [[AGSpriteButton alloc]initWithTexture:texture color:[SKColor whiteColor] size:size];
    
    return newButton;
}

+(AGSpriteButton *)buttonWithTexture:(SKTexture *)texture
{
    AGSpriteButton *newButton = [[AGSpriteButton alloc]initWithTexture:texture];
    
    return newButton;
}

#pragma mark - INIT OVERRIDING

-(instancetype)initWithImageNamed:(NSString *)name
{
    if (self = [super initWithImageNamed:name])
    {
        [self setBaseProperties];
    }
    
    return self;
    
}

-(instancetype)initWithColor:(SKColor *)color size:(CGSize)size
{
    if (self = [super initWithColor:color size:size])
    {
        [self setBaseProperties];
    }
    
    return self;
}

-(instancetype)initWithTexture:(SKTexture *)texture color:(SKColor *)color size:(CGSize)size
{
    if (self = [super initWithTexture:texture color:color size:size])
    {
        [self setBaseProperties];
    }
    
    return self;
}

-(instancetype)initWithTexture:(SKTexture *)texture
{
    if (self = [super initWithTexture:texture])
    {
        [self setBaseProperties];
    }
    return self;
}

-(id)init
{
    if (self = [super init])
    {
        [self setBaseProperties];
    }
    
    return self;
}

-(void)setBaseProperties
{
    self.userInteractionEnabled = YES;
    self.exclusiveTouch = YES;
    
    actionTouchDown = [SKAction scaleBy:0.8 duration:0.1];
    actionTouchUp = [SKAction scaleBy:1.25 duration:0.1];
    
}

#pragma mark - LABEL FOR BUTTON


-(void)setLabelWithText:(NSString *)text andFont:(UIFont *)font withColor:(SKColor*)fontColor
{
    if (self.label == nil)
    {
        self.label = [SKLabelNode node];
        self.label.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    }
    else
    {
        [self.label removeFromParent];
    }
    
    if (text != nil)
    {
        self.label.text = text;
    }
    
    if (font != nil)
    {
        self.label.fontName = font.fontName;
        self.label.fontSize = font.pointSize;
    }
    
    if (fontColor != nil)
    {
        self.label.fontColor = fontColor;
    }
    
    [self addChild:self.label];
    
}

#pragma mark - Setters for Transform Actions

-(void)setTouchDownAction:(SKAction *)action
{
    actionTouchDown = action;
}

-(void)setTouchUpAction:(SKAction *)action
{
    actionTouchUp = action;
}

#pragma mark - TOUCH DELEGATES

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.exclusiveTouch)
    {
        if (currentTouch == nil)
        {
            currentTouch = [touches anyObject];
            
            [self controlEventOccured:AGButtonControlEventTouchDown];
            
            [self transformForTouchDown];
            
        }
        else
        {
            //current touch occupied
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.exclusiveTouch)
    {
        if ([touches containsObject:currentTouch])
        {
            CGPoint touchPoint = [currentTouch locationInNode:self];
            float lenX = self.size.width / 2;
            float lenY = self.size.height / 2;
            
            if ((touchPoint.x > lenX + 10)|| (touchPoint.x < (-lenX - 10)) || (touchPoint.y > lenY + 10) || (touchPoint.y < (-lenY - 10)))
            {
                [self touchesCancelled:touches withEvent:Nil];
            }
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.exclusiveTouch)
    {
        if ([touches containsObject:currentTouch])
        {
            //touchupinside
            
            [self controlEventOccured:AGButtonControlEventTouchUp];
            [self controlEventOccured:AGButtonControlEventTouchUpInside];
            
            currentTouch = Nil;
            
            [self transformForTouchUp];
            
        }
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.exclusiveTouch)
    {
        if ([touches containsObject:currentTouch])
        {
            currentTouch = Nil;
            
            [self transformForTouchUp];
            
        }
    }
}

#pragma mark - BUTTON TRANSFORM ON SELECTION

-(void)transformForTouchDown
{    
    [self runAction:actionTouchDown];
}

-(void)transformForTouchDrag
{
    //You can define your custom transformation here.
    
}

-(void)transformForTouchUp
{
    [self runAction:actionTouchUp];
}

#pragma mark - TARGET/SELECTOR HANDLING

-(void)addTarget:(id)target selector:(SEL)selector withObject:(id)object forControlEvent:(AGButtonControlEvent)controlEvent
{
    //check whether selector is already saved, otherwise it will get called twice
    
    if (marrSelectors == nil)
    {
        marrSelectors = [NSMutableArray new];
    }
    
    NSMutableDictionary *mdicSelector = [[NSMutableDictionary alloc]init];
    
    [mdicSelector setObject:target forKey:@"target"];
    [mdicSelector setObject:[NSValue valueWithPointer:selector] forKey:@"selector"];
    
    if (object)
    {
        [mdicSelector setObject:object forKey:@"object"];
    }
    
    [mdicSelector setObject:[NSNumber numberWithInt:controlEvent] forKey:@"controlEvent"];
    
    [marrSelectors addObject:mdicSelector];
}

-(void)removeTarget:(id)target selector:(SEL)selector forControlEvent:(AGButtonControlEvent)controlEvent
{
    NSMutableArray *arrSelectors = [marrSelectors mutableCopy]; //Copied to prevent inconsistency
    
    for (int i = 0; i < [arrSelectors count]; i++)
    {
        
        NSDictionary *dicSelector = [arrSelectors objectAtIndex: i];
        
        BOOL shouldRemove = NO;
        BOOL shouldCheckSelector = NO;
        BOOL shouldCheckControlEvent = NO;
        
        id selTarget = [dicSelector objectForKey:@"target"];
        
        NSValue *valSelector = [dicSelector objectForKey:@"selector"];
        
        SEL selSelector = nil;
        
        if (valSelector)
        {
            selSelector = [valSelector pointerValue];
        }
        
        AGButtonControlEvent selControlEvent = [[dicSelector objectForKey:@"controlEvent"]intValue];
        
        if (target != nil)
        {
            if ([selTarget isEqual:target])
            {
                shouldCheckSelector = YES;
            }
        }
        else
        {
            shouldCheckSelector = YES;
        }
        
        if (shouldCheckSelector)
        {
            if (selector != nil)
            {
                if (selSelector == selector)
                {
                    shouldCheckControlEvent = YES;
                }
            }
            else
            {
                shouldCheckControlEvent = YES;
            }
        }
        
        if (shouldCheckControlEvent)
        {
            if (controlEvent == AGButtonControlEventAllEvents)
            {
                shouldRemove = YES;
            }
            else
            {
                if (selControlEvent == controlEvent)
                {
                    shouldRemove = YES;
                }
            }
        }
        
        if (shouldRemove)
        {
            [arrSelectors removeObject:dicSelector];
            i--; //To make sure the next item is checked
        }
    }
    
    marrSelectors = arrSelectors;
}

-(void)removeAllTargets
{
    [marrSelectors removeAllObjects];
    marrSelectors = nil;
}

#pragma mark - CODE BLOCKS

-(void)performBlock:(void (^)())block onEvent:(AGButtonControlEvent)event
{
    NSDictionary *dicBlock = [NSDictionary dictionaryWithObjectsAndKeys:block, @"block", [NSNumber numberWithInteger:event], @"controlEvent", nil];
    
    if (dicBlock)
    {
        if (marrBlocks == nil)
        {
            marrBlocks = [NSMutableArray new];
        }
        
        [marrBlocks addObject:dicBlock];
    }
}

#pragma mark - ACTIONS HANDLING 

-(void)performAction:(SKAction *)action onNode:(SKNode*)object withEvent:(AGButtonControlEvent)event
{
    if ([object respondsToSelector:@selector(runAction:)])
    {
        NSDictionary *dicAction = [NSDictionary dictionaryWithObjectsAndKeys:action, @"action", object, @"object", [NSNumber numberWithInteger:event], @"controlEvent",  nil];
        
        if (marrActions == nil)
        {
            marrActions = [NSMutableArray new];
        }
        
        [marrActions addObject:dicAction];
    }
    else
    {
        [NSException raise:@"Incompatible object." format:@"Object %@ cannot perform actions.", object];
    }
}

#pragma mark - Internal

-(void)controlEventOccured:(AGButtonControlEvent)controlEvent
{
    //Execute selectors
    for (NSDictionary *dicSelector in marrSelectors) {
        
        if ([[dicSelector objectForKey:@"controlEvent"]integerValue] == controlEvent)
        {
            id target = [dicSelector objectForKey:@"target"];
            
            SEL selector = [[dicSelector objectForKey:@"selector"]pointerValue];
            
            id object = [dicSelector objectForKey:@"object"];
            
            IMP imp = [target methodForSelector:selector];
            
            if (object)
            {
                void (*func)(id, SEL, id) = (void*)imp;
                func (target, selector, object);
            }
            else
            {
                void (*func)(id, SEL) = (void *)imp;
                func(target, selector);
            }
        }
    }
    
    //Execute blocks
    
    for (NSDictionary *dicBlock in marrBlocks)
    {
        if ([[dicBlock objectForKey:@"controlEvent"]integerValue] == controlEvent)
        {
            void (^block)() = [dicBlock objectForKey:@"block"];
            
            block();
        }
    }
    
    //Execute actions
    
    for (NSDictionary *dicAction in marrActions)
    {
        if ([[dicAction objectForKey:@"controlEvent"] integerValue] == controlEvent)
        {
            SKAction *action = [dicAction objectForKey:@"action"];
            SKNode *object = [dicAction objectForKey:@"object"];
            
            [object runAction:action];
        }
    }
}

@end
