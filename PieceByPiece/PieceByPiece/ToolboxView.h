//
//  ToolboxView.h
//  PieceByPiece
//
//  Created by CS121 on 11/19/13.
//  Copyright (c) 2013 Team10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolboxButton.h"
@class ViewController;

@interface ToolboxView : UIView {
    ViewController* theController;
    NSMutableArray* theTools;
}

-(id)initWithFrame:(CGRect)frame controller:(ViewController*) controller;

-(void)setMode:(int) mode;

@end
