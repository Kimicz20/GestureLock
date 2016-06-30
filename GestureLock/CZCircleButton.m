//
//  CZCircleButton.m
//  GestureLock
//
//  Created by Geek on 16/6/30.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "CZCircleButton.h"

@implementation CZCircleButton

#pragma mark 初始化
//代码生成View时候会调用
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

//storyboard，xib生成View时候会调用
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

//初始化
-(void)setup{
    // 设置按钮不可用
    self.userInteractionEnabled = NO;
        
    //2.设置按钮样式
    [self setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        
    [self setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];

}


@end
