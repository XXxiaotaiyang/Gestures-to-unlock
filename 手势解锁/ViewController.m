//
//  ViewController.m
//  手势解锁
//
//  Created by 闲人 on 15/12/14.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import "ViewController.h"
#import "LockView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:
                                 [UIImage imageNamed:@"Home_refresh_bg"]];
    LockView *lockV = [[LockView alloc] init];
    lockV.backgroundColor = [UIColor clearColor];
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    lockV.bounds = CGRectMake(0, 0, screenW, screenW);
    lockV.center = self.view.center;
    [self.view addSubview:lockV];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
