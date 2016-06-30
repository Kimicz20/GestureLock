//
//  ViewController.m
//  GestureLock
//
//  Created by Geek on 16/6/30.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "ViewController.h"
#import "CZLockView.h"

@interface ViewController ()<CZLockViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)lockView:(CZLockView *)lockView didFinshUnLockPath:(NSString *)path{
    NSLog(@"%@",path);
}


@end
