//
//  SandboxView.h
//  PieceByPiece
//
//  Created by CS121 on 11/5/13.
//  Copyright (c) 2013 Team10. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "BinButton.h"
#import "PlankButton.h"
#import "Fraction.h"
@class ViewController;

@interface SandboxView : UIView {
    int plankUnitWidth;
    ViewController* theController;
    NSMutableArray* theBins;
    NSMutableArray* thePlanks;
    bool plankSelected;
    PlankButton* theSelectedPlank;
}

@property int mode;


-(id)initWithFrame:(CGRect)frame controller:(ViewController*) controller;

-(void)setBins:(Fraction*) fraction1 bin2: (Fraction*) fraction2 bin3: (Fraction*) fraction3;

-(void)generateBin:(int) index fraction:(Fraction*) theFraction;

-(void)binPressed:(id)sender;

-(void)plankWasTapped:(id)sender;

-(void)plankAddition:(PlankButton *) plank;

-(void)plankWasDragged:(PlankButton *)button withEvent:(UIEvent *)event;

-(void)resetSandbox;

@end
