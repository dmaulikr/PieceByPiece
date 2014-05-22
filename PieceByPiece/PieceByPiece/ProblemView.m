//
//  ProblemView.m
//  PieceByPiece
//
//  Created by Emma Davis on 11/19/13.
//  Copyright (c) 2013 Team10. All rights reserved.
//

#import "ProblemView.h"
#import "Fraction.h"

@implementation ProblemView

- (id)initWithFrame:(CGRect)frame controller:(ViewController*) controller
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor: [UIColor clearColor]];
        theController = controller;
        theAnswerButtons = [NSMutableArray array];

        [self generateEquationWithDifficulty:0];

        [self generateAnswerButtons];
    }
    return self;
}

-(void) generateEquationWithDifficulty:(int)difficulty {

    int denom1,denom2,denom3,numer1,numer2,numer3;
    denom1 = rand()%3 + 2;
    do {
        denom2 = rand()%3 + 2;
    } while(denom2 == denom1);
    
    do {
        numer1 = rand()%(denom1+2);
        numer2 = rand()%(denom2+2);
    } while(numer1==0 && numer2==0);
    
    denom3 = denom2*denom1;
    numer3 = numer1*denom2 + numer2*denom1;
    
    Fraction* frac1 = [[Fraction alloc] initWithNumerator:numer1 denominator:denom1];
    NSString* frac1str = [frac1 toString];
    
    Fraction* frac2 = [[Fraction alloc] initWithNumerator:numer2 denominator:denom2];
    NSString* frac2str = [frac2 toString];
    
    Fraction* answer = [[Fraction alloc] initWithNumerator:numer3 denominator:denom3];
    
    answer = [answer simplifyFraction];
    NSString* answerstr = [answer toString];
    
    int hidden = rand()%3;
    if (hidden == 0) {
        frac1str = @"?";
        correctAnswer = [[Fraction alloc] initWithFraction:frac1];
    } else if (hidden == 1) {
        frac2str = @"?";
        correctAnswer = [[Fraction alloc] initWithFraction:frac2];
    } else {
        answerstr = @"?";
        correctAnswer = [[Fraction alloc] initWithFraction:answer];
    }
    
    
    NSString*equation = [NSString stringWithFormat: @"%@+%@=%@", frac1str, frac2str, answerstr];
    
    int equationWidth = self.bounds.size.width;
    int equationHeight = self.bounds.size.height * 0.8;
    
    UILabel *problemText = [[UILabel alloc] initWithFrame:CGRectMake(0,0,equationWidth,equationHeight)];
    [problemText setText:equation];
    problemText.textAlignment = NSTextAlignmentCenter;
    [problemText setFont:[UIFont systemFontOfSize:60]];
    [problemText setBackgroundColor: [UIColor clearColor]];
    [self addSubview:problemText];
}

-(void) generateAnswerButtons {
    
    theAnswers = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil];
    int correctAnswerIndex = rand()%3;
    [theAnswers replaceObjectAtIndex:correctAnswerIndex withObject: [correctAnswer toString]];
    
    printf("correct answer is %s\n", [[correctAnswer toString] cStringUsingEncoding:[NSString defaultCStringEncoding]]);
    printf("index is %d\n", correctAnswerIndex);
    printf("object at index is %s\n", [[theAnswers objectAtIndex:correctAnswerIndex] cStringUsingEncoding:[NSString defaultCStringEncoding]]);
    
    Fraction *offAnswer = [[Fraction alloc] initWithFraction:correctAnswer];
    while ([offAnswer equalsFraction:correctAnswer]) {
        offAnswer.numerator = rand()%correctAnswer.denominator;
    }
    
    int offAnswerIndex = correctAnswerIndex;
    while (offAnswerIndex == correctAnswerIndex) {
        offAnswerIndex = rand()%3;
    }
    [theAnswers replaceObjectAtIndex:offAnswerIndex withObject:[offAnswer toString]];
    
    printf("off answer is %s\n", [[offAnswer toString] cStringUsingEncoding:[NSString defaultCStringEncoding]]);
    printf("index is %d\n", offAnswerIndex);
    printf("object at index is %s\n", [[theAnswers objectAtIndex:offAnswerIndex] cStringUsingEncoding:[NSString defaultCStringEncoding]]);
    
    Fraction *randAnswer = [[Fraction alloc] initWithFraction:correctAnswer];
    while ([randAnswer equalsFraction:correctAnswer] || [randAnswer equalsFraction:offAnswer]) {
        randAnswer.denominator = rand()%4+1;
        randAnswer.numerator = rand()%randAnswer.denominator;
    }
    
    for (int i = 0; i < 3; i++) {
        if (i != correctAnswerIndex && i != offAnswerIndex) {
            [theAnswers replaceObjectAtIndex:i withObject:[randAnswer toString]];
            printf("rand answer is %s\n", [[randAnswer toString] cStringUsingEncoding:[NSString defaultCStringEncoding]]);
            printf("index is %d\n", i);
            printf("object at index is %s\n", [[theAnswers objectAtIndex:i] cStringUsingEncoding:[NSString defaultCStringEncoding]]);
        }
    }
    
    int answerWidth = self.bounds.size.width * 0.15;
    int answerHeight = self.bounds.size.height * 0.25;
    int answerOriginY = self.bounds.size.height * 0.66;
    
    int answer1OriginX = self.bounds.size.width * 0.43;
    UIButton *answer1 = [[UIButton alloc] initWithFrame:CGRectMake(answer1OriginX,answerOriginY,answerWidth,answerHeight)];
    answer1.backgroundColor = [UIColor blueColor];
    [answer1 setTitle:[theAnswers objectAtIndex: 1] forState: UIControlStateNormal];
    answer1.titleLabel.font = [UIFont systemFontOfSize:30];
    [answer1 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    if (correctAnswerIndex == 1) {
        [answer1 addTarget:theController action:@selector(choseRightAnswer:) forControlEvents:UIControlEventTouchDown];
    } else {
        [answer1 addTarget:theController action:@selector(choseWrongAnswer:) forControlEvents:UIControlEventTouchDown];
    }
    [self addSubview:answer1];
    
    int answer2OriginX = self.bounds.size.width * 0.23;
    UIButton *answer2 = [[UIButton alloc] initWithFrame:CGRectMake(answer2OriginX,answerOriginY,answerWidth,answerHeight)];
    answer2.backgroundColor = [UIColor blueColor];
    [answer2 setTitle:[theAnswers objectAtIndex: 0] forState: UIControlStateNormal];
    answer2.titleLabel.font = [UIFont systemFontOfSize:30];
    [answer2 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    if (correctAnswerIndex == 0) {
        [answer2 addTarget:theController action:@selector(choseRightAnswer:) forControlEvents:UIControlEventTouchDown];
    } else {
        [answer2 addTarget:theController action:@selector(choseWrongAnswer:) forControlEvents:UIControlEventTouchDown];
    }
    [self addSubview:answer2];
    
    int answer3OriginX = self.bounds.size.width * 0.63;
    UIButton *answer3 = [[UIButton alloc] initWithFrame:CGRectMake(answer3OriginX,answerOriginY,answerWidth,answerHeight)];
    answer3.backgroundColor = [UIColor blueColor];
    [answer3 setTitle:[theAnswers objectAtIndex: 2] forState: UIControlStateNormal];
    answer3.titleLabel.font = [UIFont systemFontOfSize:30];
    [answer3 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    if (correctAnswerIndex == 2) {
        [answer3 addTarget:theController action:@selector(choseRightAnswer:) forControlEvents:UIControlEventTouchDown];
    } else {
        [answer3 addTarget:theController action:@selector(choseWrongAnswer:) forControlEvents:UIControlEventTouchDown];
    }
    [self addSubview:answer3];
}

-(void)generateResultWithHeight:(int)height width:(int)width value:(bool)value {
    UILabel *resultText = [[UILabel alloc] initWithFrame:CGRectMake(height * 0.5,width * 0.03,height * 0.5,height * .13)];
    [resultText setBackgroundColor: [UIColor clearColor]];
    if (value == true) {
        [resultText setText:@"Correct!"];
        [resultText setTextColor:[UIColor greenColor]];
    } else {
        [resultText setText:@"Incorrect."];
        [resultText setTextColor:[UIColor redColor]];
    }
    resultText.textAlignment = NSTextAlignmentCenter;
    [resultText setFont:[UIFont systemFontOfSize:60]];
    [self addSubview:resultText];
}

-(void) answerPressed:(UIButton *)sender {
    for (UIView *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
    [self generateEquationWithDifficulty:0];
    [self generateAnswerButtons];
    
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
