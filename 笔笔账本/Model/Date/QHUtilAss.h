//
//  QHUtilAss.h
//  qingmedia_ios
//
//  Created by Dubai on 15/7/14.
//  Copyright (c) 2015年 Dubai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QHUtilAss : NSObject

+ (NSString *)jsonInfo:(id)info andDefaultStr:(NSString *)defaultStr;


+ (NSArray *)get7daysCalendayModels;
+ (NSString *)replacingWeekDayWithDate:(NSString *)weekday;

+ (NSURL *)testGetImageWhenTest;
+ (NSDictionary *)testGetDataWhenTest;




+ (NSArray *)getNext14DaysCalendaWithDate:(NSDate *)dayDate;

//-------选择的那一天的时间---几月几号----星期几-----
+ (NSArray *)getSelectedDaysCalendaWithDate:(NSDate *)dayDate;


//-----获得-前一天的时间------几月几号---星期几-----
+ (NSArray *)getBeforeDayDate:(NSDate *)fayDate;


+ (NSArray *)getNextDayDate:(NSDate *)fayDate;

+ (NSArray *)get14daysCalendayModelsWithstartDate:(NSDate*)startDate;

+ (NSString *)getyesAgoDay:(NSDate *)data;



+ (NSMutableDictionary *)getTodayBeforeSevenDaysTime:(NSDate *)sevenDays;

+ (NSMutableDictionary *)getoneMouthData:(NSDate *)mouthdate;


+ (NSMutableArray *)getsomeDaysTime:(NSString *)days withNum:(NSInteger)num;

@end
