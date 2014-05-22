//
//  SandboxView.m
//  PieceByPiece
//
//  Created by CS121 on 11/5/13.
//  Copyright (c) 2013 Team10. All rights reserved.
//

#import "SandboxView.h"
#import "math.h"
#import "Mode.h"
#import <QuartzCore/QuartzCore.h>

@implementation SandboxView

const int MAX_PLANKS = 10;

- (id)initWithFrame:(CGRect)frame controller:(ViewController*) controller
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mode = MOVE_MODE;
        plankSelected = false;
        
        plankUnitWidth = self.bounds.size.width * .38;
        theController = controller;
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SandboxBackground"]];
        [self addSubview:backgroundView];
        theBins = [NSMutableArray array];
        thePlanks = [NSMutableArray array];
        
        UIImageView *theRuler = [[UIImageView alloc] initWithFrame:
                            CGRectMake(0, self.bounds.size.height *.75,
                                       self.bounds.size.width, self.bounds.size.height *.25)];
        theRuler.image = [UIImage imageNamed: @"TapeMeasure.png"];
        [self addSubview: theRuler];
        [self setBins: [[Fraction alloc] initWithNumerator:1 denominator:2]
                 bin2: [[Fraction alloc] initWithNumerator:1 denominator:4]
                 bin3: [[Fraction alloc] initWithNumerator:1 denominator:3]];

        UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        resetButton.frame = CGRectMake(self.bounds.size.width * .03, self.bounds.size.width * .03, self.bounds.size.width * .08, self.bounds.size.width * .08);
        [resetButton addTarget: self action:@selector(resetSandbox)
              forControlEvents: UIControlEventTouchUpInside];
        [resetButton setTitle: @"Reset" forState: UIControlStateNormal];
        [resetButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [resetButton setBackgroundImage: [UIImage imageNamed: @"ResetToolWhite.png" ] forState:UIControlStateNormal];
        [self addSubview: resetButton];
    }
    return self;
}

- (void) setBins:(Fraction*) fraction1 bin2:(Fraction*) fraction2 bin3:(Fraction*) fraction3 {
    for (int i = 0; i < [theBins count]; i++) {
        BinButton* bin = [theBins objectAtIndex: i];
        [bin removeFromSuperview];
    }
    theBins = [NSMutableArray array];
    [self generateBin:0 fraction: fraction1];
    [self generateBin:1 fraction: fraction2];
    [self generateBin:2 fraction: fraction3];
}

// Index can only be 0, 1, or 2. Use other values at your own risk.
- (void)generateBin:(int) index fraction:(Fraction*) theFraction
{
    int binOriginX = self.bounds.size.width * .85;
    int binOriginY = self.bounds.size.height * .05;
    int binSize = self.bounds.size.width * .13;
    CGRect binFrame = CGRectMake(binOriginX, (1 + index) * binOriginY + (binSize * index), binSize, binSize);
    BinButton *bin = [BinButton alloc];
    bin = [bin initBin: binFrame fraction: theFraction];
    [bin addTarget: self action: @selector(binPressed:) forControlEvents:UIControlEventTouchDown];
    [self addSubview: bin];
    [theBins addObject: bin];
}

- (void)binPressed:(BinButton*)sender
{
    // If we have too many planks, we don't want to generate a new one.
    if ([thePlanks count] >= MAX_PLANKS) {
        return;
    }
    Fraction* fraction = [[Fraction alloc] initWithFraction: sender.fraction];
    int plankWidth = plankUnitWidth * fraction.numerator / fraction.denominator;
    int plankHeight = self.bounds.size.height * .10;
    int plankX = sender.center.x - plankWidth / 2;
    int plankY = sender.center.y - plankHeight / 2;
    CGRect plankFrame = CGRectMake(plankX, plankY, plankWidth, plankHeight);
    PlankButton *plank = [PlankButton alloc];
    plank = [plank initPlank: plankFrame fraction: fraction];
    // add drag listener
	[plank addTarget:self action:@selector(plankWasDragged:withEvent:)
     forControlEvents:UIControlEventTouchDragInside];
    [self addSubview: plank];
    // add tap listener
    [plank addTarget:self action:@selector(plankWasTapped:) forControlEvents:UIControlEventTouchDown];
    // ensure plank fits inside sandbox
	plank.center = CGPointMake(fmax(plank.center.x, plank.bounds.size.width / 2),
                               fmax(plank.center.y, plank.bounds.size.height / 2));
    plank.center = CGPointMake(fmin(plank.center.x, self.bounds.size.width - plank.bounds.size.width / 2),
                               fmin(plank.center.y, self.bounds.size.height - plank.bounds.size.height / 2));
    
    [thePlanks addObject: plank];
}

- (void)plankWasTapped: (PlankButton*) sender
{
    [self bringSubviewToFront: sender];
    switch (self.mode) {
        case DELETE_MODE:
            [sender removeFromSuperview];
            [thePlanks removeObject: sender];
            break;
        case ADD_MODE:
            [self plankAddition: sender];
            break;
    }
}

- (void)plankAddition:(PlankButton *) plank {
    if (!plankSelected) {
        plankSelected = true;
        theSelectedPlank = plank;
        [plank setBackgroundImage:[UIImage imageNamed: @"HighlightedPlank.png" ] forState:UIControlStateNormal];
        plank.layer.borderColor = [UIColor whiteColor].CGColor;
    } else {
        plankSelected = false;
        if (plank == theSelectedPlank) {
            [plank setBackgroundImage:[UIImage imageNamed: @"Plank.png" ] forState:UIControlStateNormal];
            plank.layer.borderColor = [UIColor blackColor].CGColor;
        } else {
            [theSelectedPlank removeFromSuperview];
            [thePlanks removeObject: theSelectedPlank];
            Fraction* newFract = [theSelectedPlank.fraction sumWithFraction: plank.fraction];
            NSString* newLabel = [NSString stringWithFormat: @"%@ + %@", [theSelectedPlank titleLabel].text,
                                  [plank titleLabel].text];
            [plank setFraction: newFract];
            [plank setTitle: newLabel forState: UIControlStateNormal];
            int plankWidth = plankUnitWidth * newFract.numerator / newFract.denominator;
            [plank setFrame: CGRectMake(plank.frame.origin.x, plank.frame.origin.y, plankWidth,
                                        plank.frame.size.height)];
            // ensure plank fits inside sandbox (may break if merged planks become too large)
            plank.center = CGPointMake(fmax(plank.center.x, plank.bounds.size.width / 2),
                                       fmax(plank.center.y, plank.bounds.size.height / 2));
            plank.center = CGPointMake(fmin(plank.center.x, self.bounds.size.width - plank.bounds.size.width / 2),
                                       fmin(plank.center.y, self.bounds.size.height - plank.bounds.size.height / 2));
        }
    }
}

- (void)plankWasDragged:(PlankButton *)plank withEvent:(UIEvent *)event
{
    if (self.mode != MOVE_MODE) {
        return;
    }
	// get the touch
	UITouch *touch = [[event touchesForView:plank] anyObject];
    
	// get delta
	CGPoint previousLocation = [touch previousLocationInView:self];
	CGPoint location = [touch locationInView:self];
	CGFloat delta_x = location.x - previousLocation.x;
	CGFloat delta_y = location.y - previousLocation.y;
    
	// move button, checking to ensure it stays within bounds.
	plank.center = CGPointMake(fmax(plank.center.x + delta_x, plank.bounds.size.width / 2),
                                fmax(plank.center.y + delta_y, plank.bounds.size.height / 2));
    plank.center = CGPointMake(fmin(plank.center.x, self.bounds.size.width - plank.bounds.size.width / 2),
                                fmin(plank.center.y, self.bounds.size.height - plank.bounds.size.height / 2));
    
}

- (void)resetSandbox
{
    for (int i = 0; i < [thePlanks count]; i++) {
        PlankButton * plank = [thePlanks objectAtIndex:i];
        [plank removeFromSuperview];
    }
    thePlanks = [NSMutableArray array];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
