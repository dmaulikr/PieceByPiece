//
//  ViewController.h
//  PieceByPiece
//
//  Created by CS121 on 11/5/13.
//  Copyright (c) 2013 Team10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SandboxView.h"
#import "ToolboxView.h"
#import "ProblemView.h"

@interface ViewController : UIViewController {
    SandboxView* theSandbox;
    ToolboxView* theToolbox;
    ProblemView* theProblem;
    bool answerAlreadyPressed;
}

-(void) modeSelected:(ToolboxButton*) sender;

-(void) choseRightAnswer:(UIButton*) sender;

-(void) choseWrongAnswer:(UIButton*) sender;

-(void)problemDone: (UIButton*) sender;

@end
