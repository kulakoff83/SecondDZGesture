//
//  DZBoard.m
//  firstDZAnimation
//
//  Created by Dmitriy Kulakov on 29.04.15.
//  Copyright (c) 2015 Dmitriy Kulakov. All rights reserved.
//

#import "DZBoard.h"


@interface DZBoard ()

@end

@implementation DZBoard

-(id)initWithCount:(NSUInteger)cellCount
{
    self = [super init];
    if (self)
    {
        self.cellCount = cellCount;
        self.whiteFiguresImg = @[@"rookW",@"knightW",@"bishopW",@"queenW",@"kingW",@"bishopW",@"knightW",@"rookW",@"pawnW"];
        self.blackFiguresImg = @[@"rookB",@"knightB",@"bishopB",@"queenB",@"kingB",@"bishopB",@"knightB",@"rookB",@"pawnB"];
    }
    
    return self;
}


@end