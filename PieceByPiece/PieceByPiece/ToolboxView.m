//
//  ToolboxView.m
//  PieceByPiece
//
//  Created by CS121 on 11/19/13.
//  Copyright (c) 2013 Team10. All rights reserved.
//

#import "ToolboxView.h"
#import "Mode.h"

@implementation ToolboxView


- (id)initWithFrame:(CGRect)frame controller:(ViewController*) controller
{
    self = [super initWithFrame:frame];
    if (self) {
        theController = controller;
        theTools = [NSMutableArray array];

        UIImageView *toolboxView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ToolboxBackground"]];
        [self addSubview:toolboxView];
        
        int unit = self.bounds.size.width * .25;
        int xPos = self.bounds.size.width * .4;
        ToolboxButton *handTool = [[ToolboxButton alloc] initWithFrame:
                                   CGRectMake(xPos, unit * 3.5, unit * 2, unit * 2)];
        [handTool setBackgroundImage: [UIImage imageNamed: @"HandTool.png"] forState: UIControlStateNormal];
        [handTool addTarget:theController action:@selector(modeSelected:) forControlEvents:UIControlEventTouchUpInside];
        handTool.mode = MOVE_MODE;
        [self addSubview: handTool];
        [theTools addObject: handTool];
        
        ToolboxButton *hammerTool = [[ToolboxButton alloc] initWithFrame:
                                   CGRectMake(xPos, unit * 6.25, unit * 2, unit * 2)];
        [hammerTool setBackgroundImage: [UIImage imageNamed: @"HammerTool.png"] forState: UIControlStateNormal];
        [hammerTool addTarget:theController action:@selector(modeSelected:) forControlEvents:UIControlEventTouchUpInside];
        hammerTool.mode = ADD_MODE;
        [self addSubview: hammerTool];
        [theTools addObject: hammerTool];
        
        ToolboxButton *trashTool = [[ToolboxButton alloc] initWithFrame:
                                    CGRectMake(xPos, unit * 9, unit * 2, unit * 2)];
        [trashTool setBackgroundImage: [UIImage imageNamed: @"TrashTool.png"] forState: UIControlStateNormal];
        [trashTool addTarget:theController action:@selector(modeSelected:) forControlEvents:UIControlEventTouchUpInside];
        trashTool.mode = DELETE_MODE;
        [self addSubview: trashTool];
        [theTools addObject: trashTool];
        [self setMode: MOVE_MODE];
    }
    return self;
}

- (void)setMode:(int) mode
{
    for (int i = 0; i < theTools.count; i++) {
        ToolboxButton *tool = [theTools objectAtIndex: i];
        if (mode == tool.mode) {
            [tool setBackgroundColor: [UIColor yellowColor]];
        } else {
            [tool setBackgroundColor: [UIColor clearColor]];
        }
    }
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
