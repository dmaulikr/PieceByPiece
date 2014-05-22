//
//  PlankButton.h
//  PieceByPiece
//
//  Created by CS121 on 11/5/13.
//  Copyright (c) 2013 Team10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fraction.h"

@interface PlankButton : UIButton {
    
}
@property Fraction* fraction;

-(id) initPlank:(CGRect) frame fraction:(Fraction*) theFraction;
-(void) setFractionLabel;

@end
