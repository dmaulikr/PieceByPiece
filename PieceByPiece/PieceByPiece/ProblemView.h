//
//  ProblemView.h
//  PieceByPiece
//
//  Created by Emma Davis on 11/19/13.
//  Copyright (c) 2013 Team10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fraction.h"

@class ViewController;

@interface ProblemView : UIView {
    ViewController* theController;
    NSMutableArray* theAnswers;
    NSMutableArray* theAnswerButtons;
    int problemNumber;
    Fraction* correctAnswer;
}

-(id)initWithFrame:(CGRect)frame controller:(ViewController*) controller;

-(void)generateEquationWithDifficulty:(int)difficulty;

-(void)generateResultWithHeight:(int)height width:(int)width value:(bool)value;

-(void)answerPressed:(UIButton *)sender;

@end
