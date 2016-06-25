//
//  CheckTool.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/25.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckTool : NSObject

/// 检测手机号11位数字
+ (BOOL)checkTelNumberEffective:(NSString *)telNumber;
/// 检测手机号
+ (BOOL)checkTelNumber:(NSString *)telNumber;
/// 正则匹配URL
+ (BOOL)checkURL:(NSString *) url;
/// 正则匹配邮箱
+ (BOOL)checkEmail:(NSString *)email;

@end
