A SpriteKit button which is implemented like a UIButton. Subclassed from SKSpriteNode, it handles touches on it's own and performs the selector which corrseponds to a particular touch event. Helps in minimizing code while setting up buttons. 

Typically, a button can be set up using the following code:

    AGSpriteButton *button = [AGSpriteButton buttonWithColor:[UIColor redColor] andSize:CGSizeMake(300, 100)];
    [button setLabelWithText:@"Add New Spaceship" andFont:nil withColor:nil];
    button.position = CGPointMake(self.size.width / 2, self.size.height / 3);
    [button addTarget:self selector:@selector(addSpaceshipAtPoint:) withObject:[NSValue valueWithCGPoint:CGPointMake(self.size.width / 2, self.size.height / 2)] forControlEvent:AGButtonControlEventTouchUpInside];
    [self addChild:button];

