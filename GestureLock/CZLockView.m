//
//  CZLockView.m
//  GestureLock
//
//  Created by Geek on 16/6/30.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "CZLockView.h"
#import "CZCircleButton.h"

@interface CZLockView()
    @property (nonatomic,strong) NSMutableArray *selectedBtn;
    @property (nonatomic,assign) CGPoint currentPoint;
@end

@implementation CZLockView

-(NSMutableArray *)selectedBtn{
    if (_selectedBtn == nil) {
        _selectedBtn = [NSMutableArray array];
    }
    return _selectedBtn;
}


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
    for (int index = 0; index < 9; index++) {
        //创建按钮
        CZCircleButton *btn = [CZCircleButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        [self addSubview:btn];
    }
}

//设置子控件格式
-(void)layoutSubviews{
    for (int index = 0; index < self.subviews.count; index++) {
        //1.获取按钮
        CZCircleButton *btn = self.subviews[index];
        
        //2.设置按钮的位置
        int colNum = 3;
        int col = index % colNum;
        int row = index / colNum;
        CGFloat btnWH = 74;
        CGFloat marigeW = (self.frame.size.width - colNum * btnWH) / (colNum + 1);
        CGFloat btnX = marigeW + col * ( btnWH + marigeW );
        CGFloat btnY = marigeW + row * ( btnWH + marigeW );
        
        btn.frame = CGRectMake(btnX, btnY, btnWH, btnWH);
        
    }
}

#pragma mark 自定义方法
// 获取当前点
-(CGPoint)pointWithTouches:(NSSet<UITouch *> *)touches{
    
    UITouch *touch = [touches anyObject];
    CGPoint pos = [touch locationInView:touch.view];
    return pos;
}

//获取点击点对应的按钮
-(CZCircleButton *)btnContainOfPoint:(CGPoint)point{
    for (CZCircleButton *btn in self.subviews) {
        
        CGFloat wh = 24;
        CGFloat frameX = btn.center.x - wh * 0.5;
        CGFloat frameY = btn.center.y - wh * 0.5;

        if(CGRectContainsPoint(CGRectMake(frameX, frameY, wh, wh),point)){
            return btn;
        }
    }
    return nil;
}

#pragma mark 点击事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.currentPoint = CGPointZero;
    
    //1.获取当前点击位置
    CGPoint pos = [self pointWithTouches:touches];
    
    //2.判断该点是否在 按钮位置内（获取点击到的按钮）
    CZCircleButton *btn = [self btnContainOfPoint:pos];
    
    //3.设置按钮的状态
    if(btn && btn.selected == NO){
        btn.selected = YES;
        [_selectedBtn addObject:btn];
    }
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //1.获取当前点击位置
    CGPoint pos = [self pointWithTouches:touches];
    
    //2.判断该点是否在 按钮位置内（获取点击到的按钮）
    CZCircleButton *btn = [self btnContainOfPoint:pos];
    
    //3.设置按钮的状态
    if(btn && btn.selected == NO){
        btn.selected = YES;
        [_selectedBtn addObject:btn];
    }else{
        self.currentPoint = pos;
    }
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if([self.delegate respondsToSelector:@selector(lockView:didFinshUnLockPath:)]){
        //1.记录路径
        NSMutableString *path = [NSMutableString string];
        for (CZCircleButton *btn in self.selectedBtn) {
            [path appendFormat:@"%d",btn.tag];
        }
        [self.delegate lockView:self didFinshUnLockPath:path];
    }
    
    //1.去除全选的按钮的样式
    [self.selectedBtn makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
    
    //2.删除所选的数组中所有元素
    [self.selectedBtn removeAllObjects];
    [self setNeedsDisplay];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchesEnded:touches withEvent:event];
}

//绘图
-(void)drawRect:(CGRect)rect{
    if(self.selectedBtn.count == 0) return;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for (int index =0 ; index<self.selectedBtn.count; index++) {
        CZCircleButton *btn = self.selectedBtn[index];
        
        if(index == 0){
            [path moveToPoint:btn.center];
        }else{
            [path addLineToPoint:btn.center];
        }
    }
    
    // 连接
    if (CGPointEqualToPoint(self.currentPoint, CGPointZero) == NO) {
        [path addLineToPoint:self.currentPoint];
    }
    
    // 绘图
    path.lineWidth = 8;
    path.lineJoinStyle = kCGLineJoinBevel;
    [[UIColor colorWithRed:32/255.0 green:210/255.0 blue:254/255.0 alpha:0.5] set];
    [path stroke];
}

@end
