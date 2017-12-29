//
//  CYChart_XScrollView.m
//  CYChart
//
//  Created by 宋飞龙 on 2017/12/28.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

#import "CYChart_XScrollView.h"

@interface CYChart_XScrollView ()

@property (nonatomic,strong)NSMutableArray * lineChartLayerArray;
@end

@implementation CYChart_XScrollView

static CGFloat bounceX = 40;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.lineChartLayerArray = [NSMutableArray array];
        [self creatXText];
    }
    return self;
}

- (void)setXTextArray:(NSArray *)xTextArray {
    _xTextArray = xTextArray;
}

- (void)setYTextArray:(NSArray *)yTextArray {
    _yTextArray = yTextArray;
    [self createLine];
}

-(void)setYCount:(NSInteger)yCount {
    _yCount = yCount;
    [self createXLineDash];
}
- (void)setXCount:(NSInteger)xCount {
    _xCount = xCount;
    [self createYLineDash];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextMoveToPoint(context, 0, rect.size.height-bounceX);
    CGContextAddLineToPoint(context,rect.size.width -20, rect.size.height-bounceX);
    CGContextStrokePath(context);
}

- (void)creatXText{
    CGFloat  month = 12;
    for (NSInteger i = 0; i < month; i++) {
        UILabel * LabelMonth = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-20)/month * (i + 1) -((self.frame.size.width - 20)/month)/2 , self.frame.size.height- bounceX, (self.frame.size.width - 20)/month, bounceX)];
        //LabelMonth.backgroundColor = [UIColor colorWithRed:(i*2 + 50) /255.0 green:(i*30 + 5) /255.0 blue:(i*20 + 15) /255.0 alpha:1];
        LabelMonth.tag = 1000 + i;
        LabelMonth.numberOfLines = 0;
        LabelMonth.textAlignment = NSTextAlignmentCenter;
        LabelMonth.text = [NSString stringWithFormat:@"%ld\n月",i+1];
        LabelMonth.font = [UIFont systemFontOfSize:10];
        [self addSubview:LabelMonth];
    }
}

- (void)createLine {
    UIBezierPath * path = [[UIBezierPath alloc]init];
    path.lineWidth = 1.0;
    path.lineCapStyle = kCGLineJoinMiter;
    CGFloat maxValue = [[self.yTextArray valueForKeyPath:@"@max.floatValue"] floatValue];
    [path moveToPoint:CGPointMake((self.frame.size.width-20)/12, (self.frame.size.height -bounceX) - (([[self.yTextArray objectAtIndex:0] floatValue]) * (self.frame.size.height -bounceX))/maxValue)];
    for (int i = 1; i < 12; i++) {
        [path addLineToPoint:CGPointMake(((self.frame.size.width-20)/12)*(i+1), (self.frame.size.height -bounceX) - (([[self.yTextArray objectAtIndex:i] floatValue]) * (self.frame.size.height -bounceX))/maxValue)];
    }
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 1;
    lineLayer.strokeColor = [UIColor greenColor].CGColor;
    lineLayer.path = path.CGPath;
    lineLayer.fillColor = nil; // 默认为blackColor
    [self addAnimation:lineLayer];
    [self.lineChartLayerArray addObject:lineLayer];
    [self.layer addSublayer:lineLayer];
}

- (void)addAnimation:(CAShapeLayer *)lineLayer {
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [lineLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (int i = 0; i < self.lineChartLayerArray.count; i++) {
        CAShapeLayer *lineLayer = self.lineChartLayerArray[i];
        lineLayer.lineWidth = 1;
        [self addAnimation:lineLayer];
    }
}

- (void)createXLineDash {
    for (int i = 0; i < self.yCount; i++) {
        CAShapeLayer * dashLayer = [CAShapeLayer layer];
        dashLayer.strokeColor = [UIColor colorWithWhite:1 alpha:0.7].CGColor;
        dashLayer.fillColor = [[UIColor clearColor] CGColor];
        dashLayer.lineWidth = 1.0;
        UIBezierPath * path = [[UIBezierPath alloc]init];
        path.lineWidth = 1.0;
        UIColor * color = [UIColor blueColor];
        [color set];
        [path moveToPoint:CGPointMake(0, ((self.frame.size.height - bounceX)/self.yCount) * i)];
        [path addLineToPoint:CGPointMake(self.frame.size.width - 20,((self.frame.size.height - bounceX)/self.yCount) * i)];
        dashLayer.lineDashPattern=[NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:10],nil];
        dashLayer.path = path.CGPath;
        [self.layer addSublayer:dashLayer];
    }
}

- (void)createYLineDash {
    for (int i = 1; i < 13; i++) {
        CAShapeLayer * dashLayer = [CAShapeLayer layer];
        dashLayer.strokeColor = [UIColor colorWithWhite:1 alpha:0.7].CGColor;
        dashLayer.fillColor = [[UIColor clearColor] CGColor];
        dashLayer.lineWidth = 1.0;
        UIBezierPath * path = [[UIBezierPath alloc]init];
        path.lineWidth = 1.0;
        UIColor * color = [UIColor blueColor];
        [color set];
        [path moveToPoint:CGPointMake(((self.frame.size.width - 20)/12)*i, 0)];
        [path addLineToPoint:CGPointMake(((self.frame.size.width - 20)/12)*i,self.frame.size.height - bounceX)];
        dashLayer.lineDashPattern=[NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:10],nil];
        dashLayer.path = path.CGPath;
        [self.layer addSublayer:dashLayer];
    }
}


@end
