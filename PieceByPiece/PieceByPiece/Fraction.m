//
//  Fraction.m
//  PieceByPiece
//
//  Created by Emma Davis on 11/12/13.
//  Copyright (c) 2013 Team10. All rights reserved.
//

#import "Fraction.h"

@implementation Fraction

-(id) initWithNumerator:(int) theNumerator denominator:(int) theDenominator
{
    self.numerator = theNumerator;
    self.denominator = theDenominator;
    return self;
}

-(Fraction *) initWithFraction:(Fraction *) fraction
{
    self.numerator = fraction.numerator;
    self.denominator = fraction.denominator;
    return self;
}

-(bool) equalsFraction:(Fraction *) otherFraction
{
    if ((self.numerator == otherFraction.numerator) && (self.numerator == 0)) {
        return true;
    }
    Fraction *simpleFraction = [self simplifyFraction];
    Fraction *simpleFraction2 = [otherFraction simplifyFraction];
    if ((simpleFraction.numerator == simpleFraction2.numerator) && (simpleFraction.denominator == simpleFraction2.denominator)) {
        return true;
    } else {
        return false;
    }
}

-(NSString *) toString
{
    NSString *fractionString;
    if (self.numerator == 0) {
        fractionString = [NSString stringWithFormat: @"0"];
    } else {
        fractionString = [NSString stringWithFormat: @"%d/%d", self.numerator, self.denominator];
    }
    return fractionString;
}

-(Fraction *) sumWithFraction:(Fraction *) otherFraction
{
    int newNumerator = (self.numerator * otherFraction.denominator) + (self.denominator * otherFraction.numerator);
    int newDenominator = self.denominator * otherFraction.denominator;
    Fraction *sum = [[Fraction alloc] initWithNumerator:newNumerator denominator:newDenominator];
    return [sum simplifyFraction];
}

-(Fraction *) subtractFraction:(Fraction *) fractionToSubtract
{
    int newNumerator = (self.numerator * fractionToSubtract.denominator) - (self.denominator * fractionToSubtract.numerator);
    int newDenominator = self.denominator * fractionToSubtract.denominator;
    Fraction *result = [[Fraction alloc] initWithNumerator:newNumerator denominator:newDenominator];
    return [result simplifyFraction];
}

-(Fraction *) simplifyFraction
{
    if (self.numerator == 0) {
        return self;
    }
    int gcd = [self gcdOfNumerator:self.numerator andDenominator:self.denominator];
    self.numerator = self.numerator / gcd;
    self.denominator = self.denominator / gcd;
    return self;
}

// Concept taken from Stack Overflow
// http://stackoverflow.com/questions/5279466/greatest-common-factor-on-objective-c
-(int) gcdOfNumerator:(int)numerator andDenominator:(int)denominator
{
    int curNum = numerator;
	int curDen = denominator;
	int gcd;
    
	while (1) {
		if (curNum == 0)
		{
			gcd = curDen;
			break;
		}
		while (curDen >= curNum)
			curDen -= curNum;
		if (curDen == 0)
		{
			gcd = curNum;
			break;
		}
		while (curNum >= curDen)
			curNum -= curDen;
	}
    
	return gcd;
}

@end
