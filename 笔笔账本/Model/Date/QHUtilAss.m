//
//  QHUtilAss.m
//  qingmedia_ios
//
//  Created by Dubai on 15/7/14.
//  Copyright (c) 2015年 Dubai. All rights reserved.
//

#import "QHUtilAss.h"
#import "QHCalendayModel.h"
#import "NSString+QHNSStringCtg.h"



@implementation QHUtilAss


+ (NSString *)jsonInfo:(id)info andDefaultStr:(NSString *)defaultStr {
    if (!info) {
        return defaultStr;
    }
    
    if ([info isKindOfClass:[NSNull class]]) {
        return defaultStr;
    }
    
    if ([info isKindOfClass:[NSString class]]) {
        if ([info isNotEmptyWithSpace]) {
            if ([info isEqualToString:@"<null>"]) {
                return defaultStr;
            }
            return [NSString stringWithFormat:@"%@", info];
        } else {
            return defaultStr;
            
        }
    }
    
    return [NSString stringWithFormat:@"%@", info];
    
    return @"";
}

+ (NSArray *)getBeforeDayDate:(NSDate *)fayDate
{

    
    
    NSMutableArray *nextTwoWeeksArray = [[NSMutableArray alloc] initWithCapacity:18];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitCalendar;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
//    for(int i=0;i<14;i++) {
        QHCalendayModel *model = [QHCalendayModel new];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[fayDate timeIntervalSince1970]+(-1)*24*3600];
        NSDateComponents *calendarTime = [calendar components:unitFlags fromDate:date];
        
        model.calendarTime = calendarTime;
        
//        NSString *str = [NSString stringWithFormat:@"%ld-%ld",(long)calendarTime.year,(long)calendarTime.month,calendarTime.day];
    

    
        
        model.weekdayStr = [QHUtilAss replacingWeekDayWithDate:[NSString stringWithFormat:@"%i",(int)calendarTime.weekday]];
        [nextTwoWeeksArray addObject:model];
    //}
    
    
    
    
    return nextTwoWeeksArray;
    
}


+ (NSArray *)getNextDayDate:(NSDate *)fayDate
{


    
    NSMutableArray *nextTwoWeeksArray = [[NSMutableArray alloc] initWithCapacity:18];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitCalendar;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    //for(int i=0;i<14;i++) {
        QHCalendayModel *model = [QHCalendayModel new];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[fayDate timeIntervalSince1970]+1*24*3600];
        NSDateComponents *calendarTime = [calendar components:unitFlags fromDate:date];
        
        model.calendarTime = calendarTime;
        
//        NSString *str = [NSString stringWithFormat:@"%d-%d",calendarTime.year,calendarTime.month,calendarTime.day];

    
    
        
        model.weekdayStr = [QHUtilAss replacingWeekDayWithDate:[NSString stringWithFormat:@"%i",(int)calendarTime.weekday]];
        [nextTwoWeeksArray addObject:model];
    //}
    
    
    
    
    return nextTwoWeeksArray;
    
    

}



+ (NSArray *)getSelectedDaysCalendaWithDate:(NSDate *)dayDate
{
    
    
    NSMutableArray *nextTwoWeeksArray = [[NSMutableArray alloc] initWithCapacity:18];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitCalendar;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    for(int i=0;i<1;i++) {
        QHCalendayModel *model = [QHCalendayModel new];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dayDate timeIntervalSince1970]+i*24*3600];
        NSDateComponents *calendarTime = [calendar components:unitFlags fromDate:date];
        
        model.calendarTime = calendarTime;
        
        
        
        model.weekdayStr = [QHUtilAss replacingWeekDayWithDate:[NSString stringWithFormat:@"%i",(int)calendarTime.weekday]];
        [nextTwoWeeksArray addObject:model];
    }
    
    return nextTwoWeeksArray;
    
}


+ (NSArray *)getNext14DaysCalendaWithDate:(NSDate *)dayDate
{


    NSMutableArray *nextTwoWeeksArray = [[NSMutableArray alloc] initWithCapacity:18];

    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitCalendar;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    for(int i=0;i<14;i++) {
        QHCalendayModel *model = [QHCalendayModel new];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dayDate timeIntervalSince1970]+i*24*3600];
        NSDateComponents *calendarTime = [calendar components:unitFlags fromDate:date];
        
        model.calendarTime = calendarTime;
        
//        NSString *str = [NSString stringWithFormat:@"%d-%d",calendarTime.month,calendarTime.day];
        

        
        
        model.weekdayStr = [QHUtilAss replacingWeekDayWithDate:[NSString stringWithFormat:@"%i",(int)calendarTime.weekday]];
        [nextTwoWeeksArray addObject:model];
    }




    return nextTwoWeeksArray;




}


+ (NSString *)getyesAgoDay:(NSDate *)data
{
    
    
    
    NSMutableArray *nextTwoWeeksArray = [[NSMutableArray alloc] initWithCapacity:18];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitCalendar;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    for(int i=0;i<2;i++) {
        QHCalendayModel *model = [QHCalendayModel new];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[data timeIntervalSince1970]+i*24*3600];
        NSDateComponents *calendarTime = [calendar components:unitFlags fromDate:date];
        
        model.calendarTime = calendarTime;
        

        
        model.weekdayStr = [QHUtilAss replacingWeekDayWithDate:[NSString stringWithFormat:@"%i",(int)calendarTime.weekday]];
        [nextTwoWeeksArray addObject:model];
    }
    
    
    QHCalendayModel *modelSenven = [nextTwoWeeksArray objectAtIndex:0];
    
    NSString *startTimeStr = [NSString stringWithFormat:@"%d-%ld-%ld",(int)modelSenven.calendarTime.year,(long)modelSenven.calendarTime.month,(long)modelSenven.calendarTime.day];
    
    startTimeStr = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)modelSenven.calendarTime.year,(long)modelSenven.calendarTime.month,(long)modelSenven.calendarTime.day];
    
//    
//    QHCalendayModel *modelOne = [nextTwoWeeksArray objectAtIndex:1];
//    NSString *endTimeStr = [NSString stringWithFormat:@"%d-%d-%d",(int)modelOne.calendarTime.year,modelOne.calendarTime.month,modelOne.calendarTime.day];
//    
//    endTimeStr = [NSString stringWithFormat:@"%d-%d",modelOne.calendarTime.month,modelOne.calendarTime.day];
//    
//    MSLog(@"--%@----_%@",startTimeStr,endTimeStr);
    
    return startTimeStr;











}

+ (NSMutableDictionary *)getTodayBeforeSevenDaysTime:(NSDate *)sevenDays
{
   
    NSMutableArray *nextTwoWeeksArray = [[NSMutableArray alloc] initWithCapacity:18];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitCalendar;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    for(int i=0;i<7;i++) {
        QHCalendayModel *model = [QHCalendayModel new];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[sevenDays timeIntervalSince1970]+i*24*3600];
        NSDateComponents *calendarTime = [calendar components:unitFlags fromDate:date];
        
        model.calendarTime = calendarTime;
        
//        NSString *str = [NSString stringWithFormat:@"%d-%d-%d",calendarTime.year,calendarTime.month,calendarTime.day];
        
//        MSLog(@"--%@----",str);
        
        model.weekdayStr = [QHUtilAss replacingWeekDayWithDate:[NSString stringWithFormat:@"%i",(int)calendarTime.weekday]];
        [nextTwoWeeksArray addObject:model];
    }
    
    
    QHCalendayModel *modelSenven = [nextTwoWeeksArray objectAtIndex:0];
//    NSString *startTimeStr = [NSString stringWithFormat:@"%d-%d-%d",(int)modelSenven.calendarTime.year,modelSenven.calendarTime.month,modelSenven.calendarTime.day];
    
     NSString *startTimeStr = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)modelSenven.calendarTime.year,(long)modelSenven.calendarTime.month,(long)modelSenven.calendarTime.day];
    
    
    QHCalendayModel *modelOne = [nextTwoWeeksArray objectAtIndex:6];
//    NSString *endTimeStr = [NSString stringWithFormat:@"%d-%d-%d",(int)modelOne.calendarTime.year,modelOne.calendarTime.month,modelOne.calendarTime.day];
    
    NSString *endTimeStr = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)modelOne.calendarTime.year,(long)modelOne.calendarTime.month,(long)modelOne.calendarTime.day];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setValue:startTimeStr forKey:@"starTime"];
    [dic setValue:endTimeStr forKey:@"endTime"];
    
    return dic;
    
}

+ (NSArray *)get7daysCalendayModels {
    
    NSMutableArray *dates = [[NSMutableArray alloc] initWithCapacity:18];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitCalendar;
    NSCalendar *calendar = [NSCalendar currentCalendar];

    
    for(int i=0;i<14;i++) {
        QHCalendayModel *model = [QHCalendayModel new];
        
        
        NSTimeInterval late=-2*24*3600;
        
        NSDate *twoDaysAgeTime = [NSDate dateWithTimeInterval:late sinceDate:[NSDate date]];
        
        
       // NSTimeInterval *twoDaysAgeTime = [NSDate dateWithTimeInterval:-2*24*3600 sinceDate:[NSDate date]];
        
        //  NSDate *date = [NSDate dateWithTimeIntervalSince1970:[sevenDays timeIntervalSince1970]+i*24*3600];
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[twoDaysAgeTime timeIntervalSince1970]+i*24*3600];
        NSDateComponents *calendarTime = [calendar components:unitFlags fromDate:date];
        
        model.calendarTime = calendarTime;
        
        
        model.weekdayStr = [QHUtilAss replacingWeekDayWithDate:[NSString stringWithFormat:@"%i",(int)calendarTime.weekday]];
        [dates addObject:model];
    }
    return dates;
    
}


+ (NSArray *)get14daysCalendayModelsWithstartDate:(NSDate*)startDate{
    
    NSMutableArray *dates = [[NSMutableArray alloc] initWithCapacity:18];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitCalendar;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    for(int i=0;i<14;i++) {
        QHCalendayModel *model = [QHCalendayModel new];
        
        
        NSTimeInterval late=0*24*3600;
        
        NSDate *twoDaysAgeTime = [NSDate dateWithTimeInterval:late sinceDate:startDate];
        
        
        // NSTimeInterval *twoDaysAgeTime = [NSDate dateWithTimeInterval:-2*24*3600 sinceDate:[NSDate date]];
        
        //  NSDate *date = [NSDate dateWithTimeIntervalSince1970:[sevenDays timeIntervalSince1970]+i*24*3600];
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[twoDaysAgeTime timeIntervalSince1970]+i*24*3600];
        NSDateComponents *calendarTime = [calendar components:unitFlags fromDate:date];
        
        model.calendarTime = calendarTime;
        
        
        model.weekdayStr = [QHUtilAss replacingWeekDayWithDate:[NSString stringWithFormat:@"%i",(int)calendarTime.weekday]];
        [dates addObject:model];
    }
    return dates;
    
}







+ (NSString *)replacingWeekDayWithDate:(NSString *)weekday {
    NSArray *weekdayStrs = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    for(int i=1;i<=7;i++) {
        weekday =  [weekday stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%i",i] withString:weekdayStrs[i-1]];
    }
    return weekday;
}


+ (NSURL *)testGetImageWhenTest {
    NSArray *testImages = @[@"http://h.hiphotos.baidu.com/zhidao/pic/item/1c950a7b02087bf46d99d8abf0d3572c11dfcf7f.jpg",@"http://img4.goumin.com/attachments/photo/0/0/44/11437/2927990o2.jpg",@"http://www.goumin.com/attachments/photo/0/0/67/17159/4392850o2.jpg",@"http://img4.goumin.com/attachments/photo/0/0/46/11820/3026050o2.jpg",@"http://img4.goumin.com/attachments/photo/0/0/54/13933/3566860o2.jpg",@"http://www.goumin.com/attachments/photo/0/0/4/1202/307718o2.jpg",@"http://img.boqii.com/Data/BK/A/1306/17/img56851371453434_y.png"];
    int random = arc4random() % testImages.count;
    return [NSURL URLWithString:testImages[random]];
}

+ (NSDictionary *)testGetDataWhenTest {
    NSMutableArray *testArr = [[NSMutableArray alloc] initWithCapacity:10];
    for(int i=0;i<10;i++) {
        [testArr addObject:@"test"];
    }
    return @{@"data":[testArr copy]};
}






+ (NSMutableDictionary *)getoneMouthData:(NSDate *)mouthdate
{
   
    NSMutableArray *nextTwoWeeksArray = [[NSMutableArray alloc] initWithCapacity:100];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitCalendar;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    for(int i=0;i<30;i++) {
        QHCalendayModel *model = [QHCalendayModel new];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[mouthdate timeIntervalSince1970]+i*24*3600];
        NSDateComponents *calendarTime = [calendar components:unitFlags fromDate:date];
        
        model.calendarTime = calendarTime;
        
//        NSString *str = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)calendarTime.year,(long)calendarTime.month,(long)calendarTime.day];
        

        
        model.weekdayStr = [QHUtilAss replacingWeekDayWithDate:[NSString stringWithFormat:@"%i",(int)calendarTime.weekday]];
        [nextTwoWeeksArray addObject:model];
    }
    
    
    QHCalendayModel *modelSenven = [nextTwoWeeksArray objectAtIndex:0];
   NSString *startTimeStr = [NSString stringWithFormat:@"%d-%ld-%ld",(int)modelSenven.calendarTime.year,(long)modelSenven.calendarTime.month,(long)modelSenven.calendarTime.day];
    
    startTimeStr = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)modelSenven.calendarTime.year,(long)modelSenven.calendarTime.month,(long)modelSenven.calendarTime.day];
    
    
    QHCalendayModel *modelOne = [nextTwoWeeksArray objectAtIndex:29];
   NSString *endTimeStr = [NSString stringWithFormat:@"%d-%ld-%ld",(int)modelOne.calendarTime.year,(long)modelOne.calendarTime.month,(long)modelOne.calendarTime.day];
    
   endTimeStr = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)modelOne.calendarTime.year,(long)modelOne.calendarTime.month,(long)modelOne.calendarTime.day];
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    
    [dic setValue:startTimeStr forKey:@"starTime"];
    [dic setValue:endTimeStr forKey:@"endTime"];
    
    return dic;



}




+ (NSMutableArray *)getsomeDaysTime:(NSString *)days withNum:(NSInteger)num
{


    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateA = [dateFormatter dateFromString:days];
    

    

    NSMutableArray *nextTwoWeeksArray = [[NSMutableArray alloc] initWithCapacity:100];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitCalendar;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    for(int i=0;i<num;i++) {
        QHCalendayModel *model = [QHCalendayModel new];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dateA timeIntervalSince1970]+i*24*3600];
        NSDateComponents *calendarTime = [calendar components:unitFlags fromDate:date];
        
        model.calendarTime = calendarTime;
        
        NSString *str = [NSString stringWithFormat:@"%d-%d",(int)calendarTime.month,(int)calendarTime.day];
        

        
       // model.weekdayStr = [QHUtilAss replacingWeekDayWithDate:[NSString stringWithFormat:@"%i",(int)calendarTime.weekday]];
        [nextTwoWeeksArray addObject:str];
    }
    
    
    return nextTwoWeeksArray;
    

}


@end




