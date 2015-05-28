//
//  ViewController.m
//  NSStringExtension
//
//  Created by ZK on 15/5/28.
//  Copyright (c) 2015年 ZK. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Height.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIFont *font = [UIFont systemFontOfSize:12];
    NSLog(@"%f", font.pointSize);
    
    NSString * str = [NSString stringWithFormat:@"%@", @"这是一个自定义间距的Label，这是一个自定义间距的Label，这是一个自定义间距的Label。"];
    str = [NSString stringWithFormat:@"%@\n%@", str, str];
    
    CGFloat height = [str getStringHeightByWidth:335.0 font:[UIFont fontWithName:@"Zapfino" size:16.0] characterSpacing:5 linesSpacing:10 paragraphSpacing:30];
    NSLog(@"height---%f", height);
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 335.0, height)];
    lable.attributedText = str.attributedString;
    lable.numberOfLines = 0;
    lable.backgroundColor = [UIColor greenColor];
    [self.view addSubview:lable];
}

@end
