//
//  BinButton.m
//  PieceByPiece
//
//  Created by CS121 on 11/5/13.
//  Copyright (c) 2013 Team10. All rights reserved.
//

#import "BinButton.h"


@implementation BinButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage: [UIImage imageNamed: @"Bin.png" ] forState:UIControlStateNormal];
        self.fraction = [[Fraction alloc] initWithNumerator:0 denominator:1];
    }
    return self;
}

- (id) initBin:(CGRect) frame fraction:(Fraction *)theFraction
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
