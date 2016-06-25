//
//  TimeArray.m
//  ELuYunApp
//
//  Created by apple on 16/4/3.
//  Copyright © 2016年 zhaoguodong. All rights reserved.
//

#import "TimeArray.h"
#import "NSString+QHNSStringCtg.h"
#import "QHCalendayModel.h"
#import "QHUtilAss.h"
@implementation TimeArray
+ (NSMutableArray *)getTimeArray
{

    NSMutableArray *_timeArray = [[NSMutableArray alloc] init];
    //今天
    NSString *timeStr = [NSString dateFromeString:[NSDate date]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    
    NSArray *arr = [QHUtilAss getSelectedDaysCalendaWithDate:date];
    QHCalendayModel *model = [arr objectAtIndex:0];
    NSString *todayTime = [NSString stringWithFormat:@"%d-%d-%d",(int)model.calendarTime.year,(int)model.calendarTime.month,(int)model.calendarTime.day];
    NSString *todayDate = [NSString getMouthMMdd:todayTime];
    NSString *todayStr = @"今天";
    NSMutableDictionary *todayDic = [@{@"startTime":todayTime,@"endTime":todayTime,@"startDate":todayDate,@"endDate":todayDate,@"title":todayStr,@"backTitle":@""} mutableCopy];
    
    [_timeArray addObject:todayDic];
    
    //昨天
    NSTimeInterval  oneDay = -24*60*60*1;
    NSDate  *oneDayTime = [date initWithTimeInterval:oneDay*1 sinceDate:date];
    NSString *yesterdayTime = [QHUtilAss getyesAgoDay:oneDayTime];
    NSString *yeaterdayDate = [NSString getMouthMMdd:yesterdayTime];
    NSString*yesterdayStr = @"昨天";
    NSMutableDictionary *yesterdayDic = [@{@"startTime":yesterdayTime,@"endTime":yesterdayTime,@"startDate":yeaterdayDate,@"endDate":yeaterdayDate,@"title":yesterdayStr} mutableCopy];
    
    [_timeArray addObject:yesterdayDic];
    
    //上周
    NSDictionary *agoWeekDayDic = [NSString weekWithSelectedDate];
    NSString *lastWeekStartTime = [NSString stringWithFormat:@"%@",[agoWeekDayDic objectForKey:@"mondy"]];
    
    NSString *lastWeekEndTime = [NSString stringWithFormat:@"%@",[agoWeekDayDic objectForKey:@"sunday"]];
    NSString *lastWeekStartDate = [NSString getMouthMMdd:lastWeekStartTime];
    NSString *lastWeekEndDate = [NSString getMouthMMdd:lastWeekEndTime];
    NSString *lastWeekStr = @"上周";
    NSMutableDictionary *agoWeekDic = [@{@"startTime":lastWeekStartTime,@"endTime":lastWeekEndTime,@"startDate":lastWeekStartDate,@"endDate":lastWeekEndDate,@"title":lastWeekStr} mutableCopy];
    
    [_timeArray addObject:agoWeekDic];
    
    //上月
    NSString *beforeMouth = [NSString getTodayTimeBeforMouthOrNextMouth:-1];
    NSInteger allDays = [NSString getMouthDays:beforeMouth];
    NSDictionary  *mouth = [NSString getMouth:beforeMouth];
    NSMutableDictionary *beforeMouthDic = [NSString getBeforeMonthBeginAndEndWith:beforeMouth];
    NSString *entMouthStr = [NSString stringWithFormat:@"%@-%ld",[mouth valueForKey:@"mouth"],(long)allDays];
    
    [beforeMouthDic setValue:entMouthStr forKey:@"endTime"];
    
    NSString *beforMouthOne = [NSString stringWithFormat:@"%@-%@",[mouth valueForKey:@"year"],[beforeMouthDic objectForKey:@"beginTime"]];
    
    NSString *beforMouthEnd = [NSString stringWithFormat:@"%@-%@",[mouth valueForKey:@"year"],[beforeMouthDic objectForKey:@"endTime"]];
    
    
    NSString *beforeMfirst = [NSString getMouthMMdd:beforMouthOne];
    
    NSString *beforeMlast = [NSString getMouthMMdd:beforMouthEnd];
    
    NSString *lastMonthStr = @"上月";
    NSMutableDictionary *agoMouthDic = [@{@"startTime":beforMouthOne,@"endTime":beforMouthEnd,@"startDate":beforeMfirst,@"endDate":beforeMlast,@"title":lastMonthStr} mutableCopy];
    
    [_timeArray addObject:agoMouthDic];
    
    
    //本周
    NSDictionary *weekDic = [NSString getTodayWeekedDate:[NSDate date]];
    
    NSString *thisWone = [NSString getMouthMMdd:[weekDic objectForKey:@"beginTime"]];
    
    NSString *thisWSeven = [NSString getMouthMMdd:[weekDic objectForKey:@"endTime"]];
    
    NSString *thisWeekStr = [NSString stringWithFormat:@"本周(%@至%@)",thisWone,thisWSeven];
    NSMutableDictionary *thisWDic = [@{@"startTime":[NSString stringWithFormat:@"%@",[weekDic objectForKey:@"beginTime"]],@"endTime":[NSString stringWithFormat:@"%@",[weekDic objectForKey:@"endTime"]],@"startDate":thisWone,@"endDate":thisWSeven,@"title":thisWeekStr} mutableCopy];
    
    [_timeArray addObject:thisWDic];
    
    //本月
    NSDictionary *mouthDic = [NSString getMonthBeginAndEndWith:[NSDate date]];
    NSString *thisMone = [NSString getMouthMMdd:[mouthDic objectForKey:@"beginTime"]];
    NSString *thisMend = [NSString getMouthMMdd:[mouthDic objectForKey:@"endTime"]];
    
    NSString *thisMonthStr = [NSString stringWithFormat:@"本月(%@至%@)",thisMone,thisMend];
    NSMutableDictionary *thisMDic = [@{@"startTime":[NSString stringWithFormat:@"%@",[mouthDic objectForKey:@"beginTime"]],@"endTime":[NSString stringWithFormat:@"%@",[mouthDic objectForKey:@"endTime"]],@"startDate":thisMone,@"endDate":thisMend,@"title":thisMonthStr} mutableCopy];
    
    [_timeArray addObject:thisMDic];
    
    //过去7天
    NSDate  *sevenDaysTime = [date initWithTimeInterval:oneDay*7 sinceDate:date];
    NSDictionary *sevendayageDic = [QHUtilAss getTodayBeforeSevenDaysTime:sevenDaysTime];
    NSString *sevenDaysOne = [NSString getMouthMMdd:[NSString stringWithFormat:@"%@",[sevendayageDic objectForKey:@"starTime"]]];
    NSString *sevenDaysSeven = [NSString getMouthMMdd:[NSString stringWithFormat:@"%@",[sevendayageDic objectForKey:@"endTime"]]];
    NSString *lastSevenDay = @"过去7天";
    NSMutableDictionary *beforSenDic = [@{@"startTime":[NSString stringWithFormat:@"%@",[sevendayageDic objectForKey:@"starTime"]],@"endTime":[NSString stringWithFormat:@"%@",[sevendayageDic objectForKey:@"endTime"]],@"startDate":sevenDaysOne,@"endDate":sevenDaysSeven,@"title":lastSevenDay} mutableCopy];
    
    [_timeArray addObject:beforSenDic];
    
    
    //过去30天
    NSDate  *oneMouthAgo = [date initWithTimeInterval:oneDay*30 sinceDate:[NSDate date]];
    NSDictionary *oneMouthDic = [QHUtilAss getoneMouthData:oneMouthAgo];
    NSString *thirdtyOne = [NSString getMouthMMdd:[NSString stringWithFormat:@"%@",[oneMouthDic objectForKey:@"starTime"]]];
    
    NSString *thirdtyEnd = [NSString getMouthMMdd:[NSString stringWithFormat:@"%@",[oneMouthDic objectForKey:@"endTime"]]];
    
    NSString *lastThirthDay = @"过去30天";
    NSMutableDictionary *ageThirtyDic = [@{@"startTime":[NSString stringWithFormat:@"%@",[oneMouthDic objectForKey:@"starTime"]],@"endTime":[NSString stringWithFormat:@"%@",[oneMouthDic objectForKey:@"endTime"]],@"startDate":thirdtyOne,@"endDate":thirdtyEnd,@"title":lastThirthDay} mutableCopy];
    
    [_timeArray addObject:ageThirtyDic];
    
    //其他
    NSDictionary *otherDic = @{@"startTime":@"",@"endTime":@"",@"startDate":@"",@"endDate":@"",@"title":@"其他"};
    [_timeArray addObject:otherDic];
        
        
    return _timeArray;
}

+ (NSMutableArray *)getDateArray
{
    
    NSMutableArray *_timeArray = [[NSMutableArray alloc] init];
    //今天
    NSString *timeStr = [NSString dateFromeString:[NSDate date]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    
    NSArray *arr = [QHUtilAss getSelectedDaysCalendaWithDate:date];
    QHCalendayModel *model = [arr objectAtIndex:0];
    NSString *todayTime = [NSString stringWithFormat:@"%d-%d-%d",(int)model.calendarTime.year,(int)model.calendarTime.month,(int)model.calendarTime.day];
    NSString *todayDate = [NSString getMouthMMdd:todayTime];
    NSString *todayStr = @"今天";

    
    NSMutableDictionary *todayDic = [@{@"startTime":todayTime,@"endTime":todayTime,@"startDate":todayDate,@"endDate":todayDate,@"title":todayStr,@"backTitle":@""} mutableCopy];
    
    [_timeArray addObject:todayDic];
    
    //昨天
    NSTimeInterval  oneDay = -24*60*60*1;
    NSDate  *oneDayTime = [date initWithTimeInterval:oneDay*1 sinceDate:date];
    NSString *yesterdayTime = [QHUtilAss getyesAgoDay:oneDayTime];
    NSString *yeaterdayDate = [NSString getMouthMMdd:yesterdayTime];
    NSString*yesterdayStr = @"昨天";
    
    NSMutableDictionary *yesterdayDic = [@{@"startTime":yesterdayTime,@"endTime":yesterdayTime,@"startDate":yeaterdayDate,@"endDate":yeaterdayDate,@"title":yesterdayStr} mutableCopy];
    
    [_timeArray addObject:yesterdayDic];
    
    //前天
    NSTimeInterval  twoDay = -24*60*60*2;
    NSDate  *twoDayTime = [date initWithTimeInterval:twoDay*1 sinceDate:date];
    NSString *twoDayAgoTime = [QHUtilAss getyesAgoDay:twoDayTime];
    NSString *twoDayAgoDate = [NSString getMouthMMdd:twoDayAgoTime];
    NSString*twoDayAgoStr = @"前天";
    
    NSMutableDictionary *twoDayAgoDic = [@{@"startTime":twoDayAgoTime,@"endTime":twoDayAgoTime,@"startDate":twoDayAgoDate,@"endDate":twoDayAgoDate,@"title":twoDayAgoStr} mutableCopy];
    
    [_timeArray addObject:twoDayAgoDic];
    
    //其他
    NSDictionary *otherDic = @{@"startTime":@"选择日期",@"endTime":@"",@"startDate":@"",@"endDate":@"",@"title":@"其他"};
    [_timeArray addObject:otherDic];
    
    
    return _timeArray;
}

@end
