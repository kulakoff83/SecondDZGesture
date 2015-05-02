//
//  DZBoardView.m
//  firstDZAnimation
//
//  Created by Dmitriy Kulakov on 29.04.15.
//  Copyright (c) 2015 Dmitriy Kulakov. All rights reserved.
//

#import "DZBoardView.h"
#import "DZBoard.h"

@interface UIView ()

@end

@implementation DZBoardView

{
    CGPoint diffPoint;
    CGPoint startPoint;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = frame;
        [self fillBoard];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)fillBoard
{
      DZBoard *board = [[DZBoard alloc]initWithCount:64];
      NSUInteger count = board.cellCount;
      NSUInteger width = sqrt(board.cellCount);
      BOOL isBrown = YES;

    for (int i = 0; i < count; i++)
    {
        isBrown = !isBrown;
        for (int j = 0; j < width; j++)
        {
            if (count == 0)
            {
                break;
            }
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(((self.frame.size.width / width) * j),(self.frame.size.width / width * i),self.frame.size.width / width, self.frame.size.width / width)];
                isBrown ? (view.backgroundColor = [UIColor brownColor]) : (view.backgroundColor = [UIColor yellowColor]);
                i % 2 ? (view.tag = count-1) : (view.tag = count);
                view.userInteractionEnabled = YES;
                [self addSubview:view];
            
                switch (i) {
                case 1:
                {
                    [self setFigureWithFrame:view.frame imageName:board.blackFiguresImg.lastObject];
                }
                    break;
                case 0:
                {
                    [self setFigureWithFrame:view.frame imageName:board.blackFiguresImg[j]];
                }
                    break;
                case 6:
                {
                    [self setFigureWithFrame:view.frame imageName:board.whiteFiguresImg.lastObject];
                }
                    break;
                case 7:
                {
                    [self setFigureWithFrame:view.frame imageName:board.whiteFiguresImg[j]];
                }
                    break;
                    
                default:
                    break;
                }
            count--;
            isBrown = !isBrown;
        }
    }
}

- (void)setFigureWithFrame:(CGRect)frame imageName:(NSString*)imgName
{
    UIImageView *figure = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imgName]];
    figure.userInteractionEnabled = YES;
    figure.frame = frame;
    [self addSubview:figure];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if ([touch.view isKindOfClass:[UIImageView class]])
    {
    [self bringSubviewToFront:touch.view];
    startPoint = touch.view.center;
    CGPoint firstPoint =[touch locationInView:touch.view];
    diffPoint = CGPointMake(CGRectGetMidX(touch.view.bounds) - firstPoint.x, CGRectGetMidY(touch.view.bounds) - firstPoint.y);
    touch.view.transform = CGAffineTransformMakeScale(1.5, 1.5);
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if ([touch.view isKindOfClass:[UIImageView class]])
    {
        CGPoint transition =[touch locationInView:self];
        touch.view.center = CGPointMake(transition.x + diffPoint.x, transition.y + diffPoint.y);
    }
    UIView *cellView = [UIView new];
    for (UIView *subview in self.subviews)
    {
        CGPoint newPoint = [subview convertPoint:point fromView:self];
        if ([subview pointInside:newPoint withEvent:nil] && ![subview isKindOfClass:[UIImageView class]]) {
            cellView = subview;
            cellView.backgroundColor = [UIColor redColor];
        }
        else if (![subview isKindOfClass:[UIImageView class]])
        {
            subview.tag % 2 ? (subview.backgroundColor = [UIColor brownColor]) : (subview.backgroundColor = [UIColor yellowColor]);
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    UIView *cellView = [UIView new];
    
    for (UIView *subview in self.subviews)
    {
        CGPoint newPoint = [subview convertPoint:point fromView:self];
        if ([subview pointInside:newPoint withEvent:nil] && ![subview isKindOfClass:[UIImageView class]]) {
            cellView = subview;
        }
        else if ([subview pointInside:newPoint withEvent:nil] && [subview isKindOfClass:[UIImageView class]] && touch.view != subview)
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                touch.view.transform = CGAffineTransformIdentity;
                touch.view.center = startPoint;
            } ];
        }
        
        if (![subview isKindOfClass:[UIImageView class]])
        {
            subview.tag % 2 ? (subview.backgroundColor = [UIColor brownColor]) : (subview.backgroundColor = [UIColor yellowColor]);
        }
    }
    
    if (CGRectIntersectsRect(cellView.frame, touch.view.frame))
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            touch.view.transform = CGAffineTransformIdentity;
            touch.view.frame = cellView.frame;
        } ];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            touch.view.transform = CGAffineTransformIdentity;
            touch.view.center = startPoint;
        } ];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
