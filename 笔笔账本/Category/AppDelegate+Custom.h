//
//  AppDelegate+Custom.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/4.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "AppDelegate.h"
/** 用于判断手机当前网络状态的类 */
#import <AFNetworkReachabilityManager.h>

@interface AppDelegate (Custom)
/*
 计算属性:只有get方法,用于计算某些数据,然后返回
 存储属性:有set和get方法,用于保存数据
 */

/** 当前是否在线,计算属性 */
@property (nonatomic, readonly, getter=isOnLine) BOOL onLine;

/** 当前网络状态:无网络、未知、Wifi、手机网络2G/3G/4G */
@property (nonatomic, readonly) AFNetworkReachabilityStatus netStatus;

/** 全局的一些配置 */
- (void)setupGlobalConfig;
@end
