//
//  AppDelegate+Custom.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/4.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "AppDelegate+Custom.h"

@implementation AppDelegate (Custom)
- (void)setupGlobalConfig {
//    //监听网络状态
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        //NSLog(@"ReachAbility:%@", AFStringFromNetworkReachabilityStatus(status));
//    }];
//    //启动监听
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    [self setupNaviBar];
//    [self setupTabbar];
    
    [self setNavigationBar];
    [self keyBoardManager];
}

- (AFNetworkReachabilityStatus)netStatus {
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

- (BOOL)isOnLine {
    switch (self.netStatus) {
        case AFNetworkReachabilityStatusUnknown:
        case AFNetworkReachabilityStatusNotReachable:
            return NO;
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
        case AFNetworkReachabilityStatusReachableViaWiFi:
            return YES;
    }
}

- (void)setupNaviBar {
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBarTintColor:[UIColor redColor]];
    [bar setTintColor:[UIColor whiteColor]];
    //更改 状态栏 和 导航栏title 颜色为白色
    [bar setBarStyle:UIBarStyleBlack];
    
}

- (void)setupTabbar {
    //    UITabBar *bar = [UITabBar appearance];
    //window下所有子视图的'高亮颜色'都被设置为红色
    //    [bar setTintColor:[UIColor redColor]];
    self.window.tintColor = [UIColor redColor];
}

-(void)setNavigationBar{
    UINavigationBar *naviBar = [UINavigationBar appearance];
    naviBar.barTintColor = [UIColor colorWithHexString:NavBarColor];
    naviBar.tintColor = [UIColor whiteColor];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    naviBar.titleTextAttributes = attributes;
}
-(void)keyBoardManager{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}


@end
