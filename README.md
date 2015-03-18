<h1>AGSpriteButton</h1>

A custom button control for SpriteKit. Subclassed from SKSpriteNode, it handles touches on it's own and performs a desired selector, block or action. 

<center>![AGSpriteButton](https://raw.github.com/akashgupta88/AGSpriteButton/master/AGSPriteButton.gif)

<h2>Setup</h2>

Typically, a button can be set up using the following code:

    AGSpriteButton *button = [AGSpriteButton buttonWithColor:[UIColor redColor] andSize:CGSizeMake(300, 100)];
    [button setLabelWithText:@"Add New Spaceship" andFont:nil withColor:nil];
    button.position = CGPointMake(self.size.width / 2, self.size.height / 3);
    [self addChild:button];

<h2>Selectors</h2>

It can be assigned a selector to be executed for a certain event (a la UIButton):
    
    [button addTarget:self 
            selector:@selector(addSpaceshipAtPoint:) 
            withObject:[NSValue valueWithCGPoint:CGPointMake(self.size.width / 2, self.size.height / 2)]         
            forControlEvent:AGButtonControlEventTouchUpInside];
            

<h2>Actions</h2>

It can be assigned an action to be run on a particular node for an event:

    SKAction *rotate = [SKAction rotateByAngle:M_PI_4 duration:0.5];
        [button performAction:rotate onObject:someSprite withEvent:AGButtonControlEventTouchDown];

<h2>Blocks</h2>

It can be assigned a block to be executed on the occurrence of an event:

    [button performBlock:^{
            [self addSpaceshipAtPoint:[NSValue valueWithCGPoint:CGPointMake(100, 100)]];
        } onEvent:AGButtonControlEventTouchUp];

<hr>

<h2>Usage in Swift</h2>

AGSpriteButton can be used with Swift as well:

    let button = AGSpriteButton(color: UIColor.greenColor(), andSize: CGSize(width: 200, height: 60))
    button.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
    button.addTarget(self, selector: "addSpaceship", withObject: nil, forControlEvent:AGButtonControlEvent.TouchUpInside)
    button.setLabelWithText("Spaceship", andFont: nil, withColor: UIColor.blackColor())
    addChild(button)

    


