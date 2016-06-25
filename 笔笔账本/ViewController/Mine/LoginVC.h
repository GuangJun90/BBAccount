//
//  LoginVC.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/24.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LoginType)
{
    LoginTypeNormal = 0, //正常登录(自动登录或者普通登录)
    LoginTypeBeOffLine //另一台设备登录，被挤下线
};

@interface LoginVC : UIViewController

@property (nonatomic,assign) LoginType loginType;

@end
