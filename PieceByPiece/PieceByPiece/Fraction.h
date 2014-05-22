//
//  Fraction.h
//  PieceByPiece
//
//  Created by Emma Davis on 11/12/13.
//  Copyright (c) 2013 Team10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fraction : NSObject

@property int numerator;
@property int denominator;

-(id) initWithNumerator:(int) theNumerator denominator:(int) theDenominator;
-(Fraction *) initWithFraction:(Fraction *) fraction;
-(bool) equalsFraction:(Fraction *) otherFraction;
-(NSString *) toString;
-(Fraction *) sumWithFraction:(Fraction *) otherFraction;
-(Fraction *) subtractFraction:(Fraction *) fractionToSubtract;
-(Fraction *) simplifyFraction;
-(int) gcdOfNumerator: (int) numerator andDenominator:(int) denominator;


@end
