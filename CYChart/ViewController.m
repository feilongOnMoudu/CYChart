//
//  ViewController.m
//  CYChart
//
//  Created by 宋飞龙 on 2017/12/28.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

#import "ViewController.h"
#import "CYChart_YView.h"
#import "CYChart_XScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CYChart_YView * v = [[CYChart_YView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
    v.yTextArray = @[@"1",@"20",@"30",@"40",@"80"
                     ,@"11",@"90",@"40",@"22",@"33"
                     ,@"55",@"77"];
    v.yCount = 6;
    [self.view addSubview:v];
    CYChart_XScrollView * v_scrollView = [[CYChart_XScrollView alloc] initWithFrame:CGRectMake(40, 10, v.frame.size.width - 40 - 20, v.frame.size.height - 10)];
    v_scrollView.yTextArray = @[@"1",@"20",@"30",@"40",@"80"
                                ,@"11",@"90",@"40",@"22",@"33"
                                ,@"55",@"77"];
    v_scrollView.yCount = 6;
    v_scrollView.xCount = 12;
    //v_scrollView.backgroundColor = [UIColor yellowColor];
    [v addSubview:v_scrollView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
