<h1>AGSpriteButton</h1>

A custom button control for SpriteKit. Subclassed from SKSpriteNode, it handles touches on it's own and performs a desired selector, block or action. 

Typically, a button can be set up using the following code:

    AGSpriteButton *button = [AGSpriteButton buttonWithColor:[UIColor redColor] andSize:CGSizeMake(300, 100)];
    [button setLabelWithText:@"Add New Spaceship" andFont:nil withColor:nil];
    button.position = CGPointMake(self.size.width / 2, self.size.height / 3);
    [self addChild:button];

It can be assigned an action to be run on a particular node for an event:

    SKAction *rotate = [SKAction rotateByAngle:M_PI_4 duration:0.5];
        [button performAction:rotate onObject:someSprite withEvent:AGButtonControlEventTouchDown];
        
It can be assigned a block to be run on a particular node for an event:

    [button performBlock:^{
            [self addSpaceshipAtPoint:[NSValue valueWithCGPoint:CGPointMake(100, 100)]];
        } onEvent:AGButtonControlEventTouchUp];

It can be assigned a selector to be executed for a certain event (a la UIButton):
    
    [button addTarget:self 
            selector:@selector(addSpaceshipAtPoint:) 
            withObject:[NSValue valueWithCGPoint:CGPointMake(self.size.width / 2, self.size.height / 2)]         
            forControlEvent:AGButtonControlEventTouchUpInside];
            

    
    


