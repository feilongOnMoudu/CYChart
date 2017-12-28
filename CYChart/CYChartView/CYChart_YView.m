//
//  CYChart_YView.m
//  CYChart
//
//  Created by 宋飞龙 on 2017/12/28.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

#import "CYChart_YView.h"

@implementation CYChart_YView

static CGFloat bounceX = 40;
static CGFloat bounceY = 20;

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

-(void)setYTextArray:(NSArray *)yTextArray {
    _yTextArray = yTextArray;
    [self creatYText];
}

-(void)setYCount:(NSInteger)yCount {
    _yCount = yCount;
     [self creatYText];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextMoveToPoint(context, bounceX, 10);
    CGContextAddLineToPoint(context, bounceX, rect.size.height - bounceX);
    CGContextStrokePath(context);
}

- (void)creatYText {
    //CGFloat Ydivision = self.yCount;
    CGFloat maxValue = [[self.yTextArray valueForKeyPath:@"@max.floatValue"] floatValue];
    NSMutableArray * arr = [NSMutableArray array];
    for (int i = 0; i < self.yCount + 1; i++) {
        [arr addObject:[NSString stringWithFormat:@"%.2f",(maxValue/self.yCount)* i]];
    }
    for (int i = 0; i < self.yCount; i++) {
        UILabel * labelYdivision = [[UILabel alloc]initWithFrame:CGRectMake(0, ((self.frame.size.height - bounceX -10)/ self.yCount) * i  + 10, bounceX-5, bounceY/2.0)];
        labelYdivision.tag = 2000 + i;
        labelYdivision.textAlignment = NSTextAlignmentRight;
        labelYdivision.textColor = [UIColor whiteColor];
        labelYdivision.text = [[[arr reverseObjectEnumerator] allObjects] objectAtIndex:i];
        labelYdivision.font = [UIFont systemFontOfSize:10];
        [self addSubview:labelYdivision];
    }
}




@end
