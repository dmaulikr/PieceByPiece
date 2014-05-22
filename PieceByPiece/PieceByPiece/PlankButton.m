//
//  PlankButton.m
//  PieceByPiece
//
//  Created by CS121 on 11/5/13.
//  Copyright (c) 2013 Team10. All rights reserved.
//

#import "PlankButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation PlankButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 3.0f;
        [self setBackgroundImage: [UIImage imageNamed: @"Plank.png" ] forState:UIControlStateNormal];
        self.fraction = [[Fraction alloc] initWithNumerator: 0 denominator: 1];
    }
    return self;
}

- (id) initPlank:(CGRect) frame fraction:(Fraction *)theFraction
{
    self = [self initWithFrame: frame];
    if (self) {
        self.fraction = theFraction;
        [self setFractionLabel];
    }
    return self;
}

- (void)setFractionLabel
{
    NSString* label = [self.fraction toString];
    [self setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
    [self setTitle: label forState: UIControlStateNormal];
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
