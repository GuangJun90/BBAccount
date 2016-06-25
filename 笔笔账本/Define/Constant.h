//
//  Constant.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/4.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

/** 宏定义必需以小k开头，这是一个代码规范，表示是自定义的宏 */
#define kAppDelegate ((AppDelegate *)([UIApplication sharedApplication].delegate))

#pragma mark - APPKEY/APPSECRET
#define MOBAPPKEY @"1444d4bd35280"
#define MOBAPPSECRET @"2fc077295e8fa5b1cb9f410edddc1291"

#define HXAPPKEY @"aj-jjz#bbaccount"
#define HXapnsCertName @"huanxinaccount"
//com.gj.bbaccount

#pragma mark - User config
#define kPhoneNumKey @"PhoneNum"
#define My_PhoneNum [[NSUserDefaults standardUserDefaults] objectForKey:kPhoneNumKey]
#define kAutoLonginKey @"AutoLongin"
#define My_AutoLongin [[NSUserDefaults standardUserDefaults] boolForKey:kAutoLonginKey]

#pragma mark - size config
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenBounds [UIScreen mainScreen].bounds

#ifdef DEBUG
#    define DLog(...) NSLog(__VA_ARGS__)
#else
#    define DLog(...)
#endif

#pragma mark - font config
#define NormalTextFont                  [UIFont systemFontOfSize:16.0]
#define SectionTitleFont                [UIFont systemFontOfSize:14.0]


#pragma mark  - color config
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define NavBarColor @"#364254"
#define TabBar_NormalAttrs @"#A4B7BC"
#define TabBar_SelectedAttrs @"#138AC9"
#define ViewBgColor @"#EDEDED"
#define DividingLineColor @"#D9D9D9"
#define LightDividingLineColor @"#E8E8E8"
#define NomalTextFontColor @"#333333"
#define SectionTitleColor @"#999999"
#define NomalBlueTextFontColor @"#178ce6"
#define NomalRedTextFontColor @"#f24949"



#pragma mark - Notification
#define NotificationChooseObject @"NotificationChooseObject"
#define NotificationChooseClients @"NotificationChooseClients"
#define NotificationChooseSuppliers @"NotificationChooseSuppliers"
#define NotificationChooseGoods @"NotificationChooseGoods"


#endif /* Constant_h */
