//
//  ViewController.m
//  PieceByPiece
//
//  Created by CS121 on 11/5/13.
//  Copyright (c) 2013 Team10. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background"]];
    [self.view addSubview:backgroundView];
    
    // Create frame for sandbox.
    int sandboxOriginX = self.view.frame.size.height * .15;
    int sandboxOriginY = self.view.frame.size.width * .20;
    int sandboxWidth = self.view.frame.size.height * .85;
    int sandboxHeight = self.view.frame.size.width * .77;
    CGRect sandboxFrame = CGRectMake(sandboxOriginX, sandboxOriginY, sandboxWidth, sandboxHeight);
    theSandbox = [[SandboxView alloc] initWithFrame: sandboxFrame controller: self];
    [self.view addSubview: theSandbox];
    
    // Create frame for toolbox.
    int toolboxOriginX = 0;
    int toolboxOriginY = sandboxOriginY;
    int toolboxWidth = sandboxOriginX;
    int toolboxHeight = sandboxHeight;
    CGRect toolboxFrame = CGRectMake(toolboxOriginX, toolboxOriginY, toolboxWidth, toolboxHeight);
    theToolbox = [[ToolboxView alloc] initWithFrame: toolboxFrame controller: self];
    [self.view addSubview: theToolbox];
    
    // Create frame for the problem.
    int problemOriginX = 0;
    int problemOriginY = self.view.frame.size.width * .03;
    int problemWidth = self.view.frame.size.width * 0.95;
    int problemHeight = self.view.frame.size.height * .13;
    srand(time(NULL));
    CGRect problemFrame = CGRectMake(problemOriginX, problemOriginY, problemWidth, problemHeight);
    theProblem = [[ProblemView alloc] initWithFrame: problemFrame controller: self];
    [self.view addSubview: theProblem];
    
    answerAlreadyPressed = false;

}

- (void)modeSelected: (ToolboxButton*) sender {
    [theToolbox setMode: sender.mode];
    [theSandbox setMode: sender.mode];
}

-(void)choseRightAnswer: (UIButton*) sender {
    if (!answerAlreadyPressed) {
        answerAlreadyPressed = true;
        [theProblem generateResultWithHeight:self.view.frame.size.height width:self.view.frame.size.width value:true];
        [self performSelector:@selector(problemDone:) withObject:sender afterDelay:2.0];
    }
}

-(void)choseWrongAnswer: (UIButton*) sender {
    if (!answerAlreadyPressed) {
        answerAlreadyPressed = true;
        [theProblem generateResultWithHeight:self.view.frame.size.height width:self.view.frame.size.width value:false];
        [self performSelector:@selector(problemDone:) withObject:sender afterDelay:2.0];
    }
}

-(void)problemDone: (UIButton*) sender {
    answerAlreadyPressed = false;
    [theSandbox resetSandbox];
    [theProblem answerPressed:sender];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
