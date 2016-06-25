//
//  UIView+HUD.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/5.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

@interface UIView (HUD)
//忙提示
- (void)showBusyHUD;
//文字提示
- (void)showWarning:(NSString *)warning;
//隐藏提示
- (void)hideBusyHUD;

@end
