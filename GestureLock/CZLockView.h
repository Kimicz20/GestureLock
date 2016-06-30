//
//  CZLockView.h
//  GestureLock
//
//  Created by Geek on 16/6/30.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZLockView;

@protocol CZLockViewDelegate <NSObject>

@optional
-(void)lockView:(CZLockView *)lockView didFinshUnLockPath:(NSString *)path;
@end

@interface CZLockView : UIView
@property (nonatomic,weak)id<CZLockViewDelegate> delegate;
@end
