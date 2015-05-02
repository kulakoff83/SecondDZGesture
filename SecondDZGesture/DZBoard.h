//
//  DZBoard.h
//  firstDZAnimation
//
//  Created by Dmitriy Kulakov on 29.04.15.
//  Copyright (c) 2015 Dmitriy Kulakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DZBoard : NSObject

@property (nonatomic,assign) NSUInteger cellCount;
@property (nonatomic,strong) NSArray *whiteFiguresImg;
@property (nonatomic,strong) NSArray *blackFiguresImg;

-(id)initWithCount:(NSUInteger)cellCount;

@end

