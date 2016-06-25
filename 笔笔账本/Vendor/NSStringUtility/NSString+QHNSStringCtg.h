//
//  NSString+QHNSStringCtg.h
//  QHCategorys
//
//  Created by zhaoguodong on 15/2/10.
//  Copyright (c) 2015年 Dubai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QHNSStringCtg)

///去除空格判断是否为空
- (BOOL)isNotEmptyCtg;
///不去除空格判断是否为空
- (BOOL)isNotEmptyWithSpace;


- (NSString*)stringByDeleteSignForm:(NSString *)aLeftSign
                       andRightSign:(NSString *)aRightSign;


- (NSString*)stringByReplacingSignForm:(NSString *)aLeftSign
                          andRightSign:(NSString *)aRightSign
                       andReplacingStr:(NSString*)aReplacingStr;
/**
 * NSDate to NSString
 * @param dateFormat sample(@"YYYY年MM月dd日")
 **/
+(NSString*) stringWithDate:(NSDate*) date format:(NSString*) dateFormat;

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

+ (NSString *)monthDayFromeStr:(NSInteger)inter;


//计算几月几号
+ (NSString *)dateFromeString:(NSDate *)date;

+ (NSString *)todayTimeWithDate:(NSDate *)todayDate;



//检测手机号码
-(BOOL) isValidPhoneNumber;

//检测邮箱
-(BOOL) isValidEmail;


//------------------------------------------------
//json解析

- (id)json;

//----不知道---
+(NSString *)GUID;

//- (NSString *)encodeURL;


//////////

-(NSString*)trimString;
-(BOOL)isEmptyString;
-(void)saveToNSDefaultsWithKey:(NSString*)key;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;


+ (NSString*)dateToInterval;

+(BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;

//+ (NSString *)calucateTime:(NSTimeInterval)gmt_create;


+(NSString *)updateTimeText:(NSString *)updateInterval;

//--------------------------------------------------------


- (int64_t)yyyyMMddHHmmssToInterval;

// 返回年龄
- (NSString*)yyyyMMddHHmmssToAge;

- (NSString*)yyyyMMddHHmmssFromAge;

+ (NSString*)yyyyMMddFromTimeInterval:(NSTimeInterval)interval;

+ (NSString*)dateStrFrom:(int64_t)interval fmt:(NSString *)fmt;

 //-----当前时间 时间戳
//+ (NSString*)dateToInterval;

+ (NSString*)timeformatFromSeconds:(NSInteger)seconds;

+(NSString* )updateTimeTextByHHMM:(NSTimeInterval)updateTimeInterval;



//+ (NSString*)updateTimeTextByChineseMMYYHHMM:(NSTimeInterval)updateTimeInterval;

+ (NSString*)updateTimeTextByChineseYYYYMMYYHHMM:(NSTimeInterval)updateTimeInterval;





//时间戳
+(NSString *)timeNowDate;

+ (NSString *)str;



/////号码匹配

//字符格式处理
+ (NSString*)formatPhone:(NSString *)phone;

/**
 @param author   Dubai
 
 @brief 检测版本号
 
 @param methor
 
 @param  APP
 
 @return  NSString
 
 */

+ (NSString *)appInfo:(NSString *)versonStr;


/*
 
 
 获得几月几号几时几秒
 
 **/

+ ( NSString *)dateFrometoday;



/*
 根据日期获得整型周几---以及日期
 **/
+ (NSMutableDictionary *)weekWithSelectedDate;




/*
 
 获取上个月--或者下个月的这一天的日期----
 
 **/
+ (NSString *)getTodayTimeBeforMouthOrNextMouth:(NSInteger)selectFlag;





+ (NSMutableDictionary *)getBeforeMonthBeginAndEndWith:(NSString *)dateStr;

+ (NSInteger)getMouthDays:(NSString *)timeStr;


+ (NSMutableDictionary *)getMouth:(NSString *)timeStr;

+ (NSMutableDictionary *)getTodayWeekedDate:(NSDate *)date;


+ (NSString *)getdayDate:(NSString *)time;


+ (NSMutableDictionary *)getMonthBeginAndEndWith:(NSDate *)todayDate;


+ (NSString *)getMouthMMdd:(NSString *)timeStr;

/*
 比较两个时间大小
 **/

+ (NSString *)bigDate:(NSString *)big sameDate:(NSString *)same;



+(NSString *) compareCurrentTime:(NSDate*)currentDate withAfterTime:(NSDate *)afterDate;

//----得出相差几天
+(NSString *)OthrecompareCurrentTime:(NSDate*)currentDate withAfterTime:(NSDate *)afterDate;

+ (NSString *)agoTime:(NSString *)beforeTime afterTime:(NSString *)afterTime;

//-----2016-2-20----2-20
+  (NSString *)MMDDWithYYMMDD:(NSString *)timeStr;



/*
 获得设备UUID--可变
 **/
+ (NSString *)getAppUUIDString;



/*
 
 
  可变字符串变颜色
 
 **/

+ ( NSMutableAttributedString *)stringWithBeforStr:(NSString *)befor andendStr:(NSString *)end withAllStr:(NSString *)muStr;



@end
