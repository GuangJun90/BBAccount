//
//  NSString+QHNSStringCtg.m
//  QHCategorys
//
//  Created by zhaoguodong on 15/2/10.
//  Copyright (c) 2015年 Dubai. All rights reserved.
//

#import "NSString+QHNSStringCtg.h"
#import "TCDebug.h"
#import "NSDate-Utilities.h"
#import "QHCalendayModel.h"
#import "AppConfiguration.h"

#define kPHONE_REGEX     @"1[0-9]{10}$"
#define kEMAIL_REGEX     @"[A-Z0-9a-z._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"


#ifndef kSERVER_DEFAULT_TIME_ZONE
#define kSERVER_DEFAULT_TIME_ZONE (NSString*)[AppConfiguration getConfiguration:key_Server_Default_Time_Zone]
#endif


@implementation NSString (QHNSStringCtg)

- (BOOL)isNotEmptyCtg {
    if (!self) {
        return NO;
    }
    if ([NSNull null] == (id)self) {
        return NO;
    }

    NSString *curStr = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([curStr isEqualToString:@""]) {
        return NO;
    }
    
    
    if ([self isKindOfClass:[NSNull class]]) {
        
        
        return NO;
    }
    
    
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        
        return NO;
        
        
        
    }
    
    if(self==nil) {
        
        return NO;
        
    }
    

    return YES;
}

- (BOOL)isNotEmptyWithSpace {
    if (!self) {
        return NO;
    }
    if ([self isEqualToString:@""]) {
        return NO;
    }
    
    return YES;

}

- (NSString*)stringByDeleteSignForm:(NSString *)aLeftSign
                       andRightSign:(NSString *)aRightSign {
   return  [self stringByReplacingSignForm:aLeftSign andRightSign:aRightSign andReplacingStr:@""];
}

- (NSString*)stringByReplacingSignForm:(NSString *)aLeftSign
                          andRightSign:(NSString *)aRightSign
                       andReplacingStr:(NSString*)aReplacingStr {
    
    NSString *curStr   = self;
    
    NSRange rangeLeft  = [curStr rangeOfString:aLeftSign];
    NSRange rangeRight = [curStr rangeOfString:aRightSign];
    
    while (rangeLeft.location!=NSNotFound&&rangeRight.location!=NSNotFound&&rangeRight.location>rangeLeft.location) {
        
        NSRange cutRange = NSMakeRange(rangeLeft.location, rangeRight.location-rangeLeft.location+1);
        curStr           =[curStr stringByReplacingCharactersInRange:cutRange withString:aReplacingStr];
        rangeLeft        =[curStr rangeOfString:aLeftSign];
        rangeRight       =[curStr rangeOfString:aRightSign];
    }
    
    return curStr;
}




-(BOOL) isValidPhoneNumber
{
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", kPHONE_REGEX];
    return [prd evaluateWithObject:self];
}

-(BOOL) isValidEmail
{
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", kEMAIL_REGEX];
    return [prd evaluateWithObject:self];
}

+(NSString*) stringWithDate:(NSDate*) date format:(NSString*) dateFormat
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone systemTimeZone]];
    [df setDateFormat:dateFormat];
    return [df stringFromDate:date];
}



+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    // NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSArray *weekdays = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    //NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    NSDateComponents *theComponents = [[NSCalendar autoupdatingCurrentCalendar] components:calendarUnit fromDate:inputDate];
    NSLog(@"%@",[NSString stringWithFormat:@"%i",(int)theComponents.weekday]);
    
    //return [weekdays objectAtIndex:theComponents.weekday];
    
    //return [NSString stringWithFormat:@"%i",(int)theComponents.weekday];
    
    NSString *str = [NSString stringWithFormat:@"%@",[weekdays objectAtIndex:(int)theComponents.weekday - 1]];
    
    return str;
    
}

+ (NSString *)monthDayFromeStr:(NSInteger)inter
{
    
    
    NSString *str = [NSString stringWithFormat:@"%ld",(long)inter];
    return str;
    
}


+ (NSString *)dateFromeString:(NSDate *)date
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    //NSInteger hour = [dateComponent hour];
    //NSInteger minute = [dateComponent minute];
    //NSInteger second = [dateComponent second];
    //NSInteger  week = [dateComponent weekday];
    
    //NSString *str = [NSString stringWithFormat:@"%ld月%ld日",(long)month,(long)day];
    NSString *str = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)year,(long)month,(long)day];

    return str;
    
    
    
}
//---今天的日期
+ (NSString *)todayTimeWithDate:(NSDate *)todayDate
{
   
    

        //日期
        NSDate* now = [NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit;
        NSDateComponents *dd = [cal components:unitFlags fromDate:now];
        NSInteger y = [dd year];
        NSInteger m = [dd month];
        NSInteger d = [dd day];
    
//        int hour = [dd hour];
//        int min = [dd minute];
//        int sec = [dd second];
    
        //    Lable1.text = [NSString stringWithFormat:@"2d%:2d%:2d%",y,m,d];
        //    Lable2.text =[NSStrinstringWithFormat:@"2d%:2d%:2d%",hour,min,sec];
    
    
//        _timelabel.text = [NSString stringWithFormat:@"%d-%d-%d %d:%d:%d",y,m,d,hour,min,sec];
//    
//        NSString *sa = [TimeUtil stringFromDate:now dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    
    NSString *todayTimeStr = [NSString stringWithFormat:@"%d-%d-%d",(int)y,(int)m,(int)d];
    
    return todayTimeStr;
    








}




//json解析-----

- (id)json
{
    //    if([NSJSONSerialization isValidJSONObject:self] == NO)
    //    {
    //        return nil;
    //    }
    
    NSError* err = nil;
    if (self != nil && self.length > 0) {
        NSData *jsonData = [self dataUsingEncoding:NSUnicodeStringEncoding];
        if (jsonData)
        {
            id ret = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
            if(err)
            {
                NSLog(@"json error: %@", err);
            }
            return ret;
        }
    }
    
    return nil;
    
}

//------------不知道------------
+(NSString *)GUID
{
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    NSString * uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    CFRelease(newUniqueId);
    
    NSString *UUIDStr = [uuidString stringByReplacingOccurrencesOfString:@"-" withString:@""];

    
    return UUIDStr;
}

//- (NSString *)encodeURL
//{
//    NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
//    return nil != newString ? newString  : nil;
//}
//


//--------------pan判断字符串-------------


//清除字符串中的空白字符
-(NSString*)trimString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
//判断是否为空字符串
-(BOOL)isEmptyString
{
    return self.length == 0;
}
//写入系统偏好
-(void)saveToNSDefaultsWithKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults]setValue:self forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
//正则验证手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    NSString *mobile = [mobileNum trimString];
    if (([regextestmobile evaluateWithObject:mobile] == YES)
        || ([regextestcm evaluateWithObject:mobile] == YES)
        || ([regextestct evaluateWithObject:mobile] == YES)
        || ([regextestcu evaluateWithObject:mobile] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}



// 当前时间 时间戳
+(NSString*)dateToInterval
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString ;
}

//判断两个日期是否是同一天
+(BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

//判断两个日期是否在同一年
+(BOOL)isSameYear:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    return  [comp1 year]  == [comp2 year];
}

//将时间戳 转化成  常用 时间 （今天 HH:MM）
+(NSString *)updateTimeText:(NSString *)updateInterval
{
    if (updateInterval == nil || [updateInterval isEqualToString:@""]) {
        return nil;
    }
    double updateTimeInterval = [updateInterval doubleValue];
    updateTimeInterval = updateTimeInterval/1000;
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSDate *date  =[NSDate dateWithTimeIntervalSince1970:updateTimeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *datestr = [dateFormatter stringFromDate:date];
    
    if (dat.year == date.year && dat.month == date.month ) {
        if (dat.day == date.day) {
            datestr=[[datestr substringFromIndex:11]substringToIndex:5];
            return [NSString stringWithFormat:@"今天 %@",datestr];//今天 11:23
        }else if((dat.day - date.day)==1){
            datestr=[[datestr substringFromIndex:11]substringToIndex:5];
            return [NSString stringWithFormat:@"昨天 %@",datestr];//今天 11:23
            
        }else
            return datestr;
    }else
        return datestr ;
}

/////------------------------------------------------------------------------///////////


//将 yyyy-MM-dd HH:mm:ss 转化成时间戳
- (int64_t)yyyyMMddHHmmssToInterval
{
    if (self.length < 1)
    {
        return 0;
    }

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:kSERVER_DEFAULT_TIME_ZONE]];

    NSDate *destDate = [dateFormatter dateFromString:self];
    ;

    return [destDate timeIntervalSince1970];
}

- (NSString *)yyyyMMddHHmmssToAge
{
    NSString *age = nil;

    if (self.length > 1)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //        dateFormatter.timeStyle = NSDateFormatterLongStyle;
        //        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        //
        //        NSLocale *zh_Locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
        //        [dateFormatter setLocale:zh_Locale];
        //        [zh_Locale release];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:kSERVER_DEFAULT_TIME_ZONE]];
        @try
        {
            NSDate *date = [dateFormatter dateFromString:self];
            NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                               components:NSCalendarUnitYear
                                               fromDate:date
                                               toDate:[NSDate date]
                                               options:0];
            age = [NSString stringWithFormat:@"%ld", (long)[ageComponents year]];
        }
        @catch (NSException *exp)
        {
            DLog_c(@"%@", exp);
        }
        @finally
        {

            return age;
        }
    }
}

- (NSString *)yyyyMMddHHmmssFromAge
{
    NSDateComponents *comps = [[NSCalendar currentCalendar]
                                    components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                    fromDate:[NSDate date]];


    comps.year -= self.integerValue;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:kSERVER_DEFAULT_TIME_ZONE]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];


    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setTimeZone: [NSTimeZone timeZoneWithAbbreviation:kSERVER_DEFAULT_TIME_ZONE]];
    NSString *datestr = [dateFormatter stringFromDate:[gregorian dateFromComponents:comps]];

    return datestr;
}


+ (NSString *)dateStrFrom:(int64_t)interval fmt:(NSString *)fmt
{
    NSString *datestr = nil;
    NSDate *date  =[NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:kSERVER_DEFAULT_TIME_ZONE]];
    [dateFormatter setDateFormat:fmt];

    @try
    {
        datestr = [dateFormatter stringFromDate:date];
    }
    @catch (NSException *exception)
    {
        datestr = nil;
    }
    @finally
    {
        //[dateFormatter release];
        return datestr;
    }
}



+ (NSString *)yyyyMMddFromTimeInterval:(NSTimeInterval)interval
{
    return [self dateStrFrom:interval fmt:@"yyyy/MM/dd"];
}

+ (NSString*)updateTimeTextByChineseYYYYMMYYHHMM:(NSTimeInterval)updateTimeInterval
{
    NSDate *date  =[NSDate dateWithTimeIntervalSince1970:updateTimeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:kSERVER_DEFAULT_TIME_ZONE]];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日 HH:mm"];
    NSString *datestr = [dateFormatter stringFromDate:date];
    return datestr;
}

+(NSString* )updateTimeTextByHHMM:(NSTimeInterval)updateTimeInterval
{
    NSDate *date  =[NSDate dateWithTimeIntervalSince1970:updateTimeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:kSERVER_DEFAULT_TIME_ZONE]];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *datestr = [dateFormatter stringFromDate:date];
    return datestr;

}


//----时间戳
+(NSString *)timeNowDate
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970]*1000;
    long long int date = (long long int)time;
    NSString* nowtime =[NSString stringWithFormat:@"%lld",date ];
    return nowtime;
}


+ (NSString *)str{
NSDateFormatter * dateForMatter=[[NSDateFormatter alloc]init];
[dateForMatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
NSString* nowtime =[dateForMatter stringFromDate:[NSDate date]];
NSDate* dateNow=[dateForMatter dateFromString:nowtime];
    
    NSString *timeStr = [NSString stringWithFormat:@"%@",dateNow];
    return timeStr;
}

////-------排序--拼接---加密--转小写------
//+ (NSString *)sortArray:(NSArray *)paramsArray{
//    
//    //——排序
//    //    NSArray *orderedTitles = [paramsArray sortedArrayUsingSelector:@selector()];
//    NSMutableArray *array=[paramsArray mutableCopy];
//    
//    for (int i=0; i<array.count; i++) {
//        for (int j=i; j<array.count; j++) {
//            if ([array[j] compare:array[i] options:NSLiteralSearch] == NSOrderedAscending) {
//                NSString* c;
//                c=array[i];
//                array[i]=array[j];
//                array[j]=c;
//            }
//        }
//    }
//    
//    
//    //拼接
//    NSMutableString *hashStr = [NSMutableString string];
//    for (NSString *str in array) {
//        [hashStr appendString:str];
//    }
//    
//    NSLog(@"——hastr =——%@———",hashStr);
//    //——MD5加密——
//    const char *original_str = [hashStr UTF8String];
//    
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    
//    CC_MD5(original_str, strlen(original_str), result);
//    
//    NSMutableString *hash = [NSMutableString string];
//    
//    for (int i = 0; i < 16; i++){
//        
//        [hash appendFormat:@"%02X", result[i]];
//        
//    }
//    
//    // return [hash lowercaseString];
//    hash= [hash lowercaseString];
//    NSLog(@"—hash = %@——",hash);
//    
//    return hash;
//}
//
//


//------字符匹配-------
+ (NSString*)formatPhone:(NSString *)phone{
    if(phone){
        NSMutableString *phoneNumber=[[NSMutableString alloc]init];
        for(int i=0;i<[phone length];i++){
            unichar c=[phone characterAtIndex:i];
            if((c>=48&&c<=57)||c==43){
                [phoneNumber appendFormat:@"%c",c];
            }
        }
        return [NSString stringWithFormat:@"%@",phoneNumber];
    }
    return @"";
}

/**
 @param author   Dubai
 
 @brief 检测版本号
 
 @param methor
 
 @param  APP
 
 @return  NSString
 
 */

+ (NSString *)appInfo:(NSString *)versonStr
{

    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    // 当前应用名称
//    NSString *appCurName = [infoDict objectForKey:@"CFBundleDisplayName"];
    // 当前应用软件版本 比如：1.0.1
    NSString *appCurVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];

    return appCurVersion;

}


+ ( NSString *)dateFrometoday
{


    
    //日期
    NSDate* now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit;
    NSDateComponents *dd = [cal components:unitFlags fromDate:now];
    //int y = [dd year];
    int m = (int)[dd month];
    int d = (int)[dd day];
    
//    int hour = [dd hour];
//    int min = [dd minute];
//    int sec = [dd second];
    
    //    Lable1.text = [NSString stringWithFormat:@"2d%:2d%:2d%",y,m,d];
    //    Lable2.text =[NSStrinstringWithFormat:@"2d%:2d%:2d%",hour,min,sec];
    // NSString *sa = [TimeUtil stringFromDate:now dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *mouthAndDatStr = [NSString stringWithFormat:@"%d月-%d日",m,d];
    
    return mouthAndDatStr;
    

}




/*
 根据日期获得整型周几---以及日期
 **/
+ (NSMutableDictionary *)weekWithSelectedDate
{

    
    NSString *timeStr = [NSString dateFromeString:[NSDate date]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *datenow = [dateFormatter dateFromString:timeStr];
    NSLog(@"date = %@", datenow);
    
    //七天前
    NSTimeInterval  oneDay = -24*60*60*1;  //1天的长度
    NSDate  *sevenDaysTime = [datenow initWithTimeInterval:oneDay*7 sinceDate:datenow];
    NSLog(@"----%@-----",sevenDaysTime);
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit
                                         fromDate:sevenDaysTime];
    
    
    
     NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
//    //NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    NSDateComponents *theComponents = [[NSCalendar autoupdatingCurrentCalendar] components:calendarUnit fromDate:datenow];
    NSLog(@"%@",[NSString stringWithFormat:@"%i",(int)theComponents.weekday]);
    
    
    NSInteger str = ((int)theComponents.weekday - 1);
    
    
    
    //NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];
    
    
    
    long firstDiff,lastDiff;
    if (str == 0) {
        firstDiff = 1;
        lastDiff = 6;
    }else{
        firstDiff = [calendar firstWeekday] - str;
        lastDiff = 7 - str;
    }
    
    

    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:sevenDaysTime];
    [firstDayComp setDay:day + firstDiff];
    NSDate *sevenDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:sevenDaysTime];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    
    NSString *mondyStr = [NSString stringWithFormat:@"%@",[formater stringFromDate:sevenDayOfWeek]];
    
    NSLog(@"星期一开始 %@",[formater stringFromDate:sevenDayOfWeek]);
    NSLog(@"当前 %@",[formater stringFromDate:sevenDaysTime]);
    
    
    NSString *sunDayStr = [NSString stringWithFormat:@"%@",[formater stringFromDate:lastDayOfWeek]];
    
    NSLog(@"星期天结束 %@",[formater stringFromDate:lastDayOfWeek]);
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    
    [dic setValue:mondyStr forKey:@"mondy"];
    [dic setValue:sunDayStr forKey:@"sunday"];
    
    

    return dic;


}

/*
 
 获取上个月--或者下个月的这一天的日期----
 
 **/

+ (NSString *)getTodayTimeBeforMouthOrNextMouth:(NSInteger)selectFlag
{

    
    NSString *timeStr = [NSString dateFromeString:[NSDate date]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:timeStr];

    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = nil;
    
//    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:-1];
    
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    
    
    
    
    NSDateFormatter *dateFormatterStr = [[NSDateFormatter alloc] init];
    [dateFormatterStr setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:newdate];

    

    return strDate;
    
}

/*
 Dubai
 
 获取上一月---或者下个月--一个月的---第一天---和最后一天
 
 **/

+ (NSMutableDictionary *)getBeforeMonthBeginAndEndWith:(NSString *)dateStr
{
   
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return nil;
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    
    NSString *s = [NSString stringWithFormat:@"%@",beginString];

    
    
    
    //----根据日期--获得几月几号---
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateMouthDay = [dateFormatter dateFromString:s];
    
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit;
    NSDateComponents *dd = [cal components:unitFlags fromDate:dateMouthDay];
    //int y = [dd year];
    int m = (int)[dd month];
    int d = (int)[dd day];

    
    NSString *startTimeStr = [NSString stringWithFormat:@"%d-%d",m,d];

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setValue:startTimeStr forKey:@"beginTime"];
   // [dic setValue:endString forKey:@"endTime"];
    
    return dic;
    
}


+ (NSInteger)getMouthDays:(NSString *)timeStr
{

    
//    NSString *timeStr = [NSString dateFromeString:[NSDate date]];
//    
//    NSLog(@"---%@-----",timeStr);
//    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    NSLog(@"date = %@", date);
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
//    NSDateComponents *comps = nil;
    
//    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    
//    NSLog(@"---%@----",newdate);
    
    NSDateFormatter *dateFormatterStr = [[NSDateFormatter alloc] init];
    [dateFormatterStr setDateFormat:@"yyyy-MM-dd"];

    
    
    
    NSCalendar *Dubaicalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSRange range = [Dubaicalendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:newdate];
    NSUInteger numberOfDaysInMonth = range.length;
    // 获取当月天数
    
    
    

    return numberOfDaysInMonth;
    
}

+ (NSMutableDictionary *)getMouth:(NSString *)timeStr
{
    //日期
   // NSDate* now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit;
    NSDateComponents *dd = [cal components:unitFlags fromDate:date];
    int y = (int)[dd year];
    int m = (int)[dd month];
    //int d = [dd day];
    
    //    int hour = [dd hour];
    //    int min = [dd minute];
    //    int sec = [dd second];
    
    //    Lable1.text = [NSString stringWithFormat:@"2d%:2d%:2d%",y,m,d];
    //    Lable2.text =[NSStrinstringWithFormat:@"2d%:2d%:2d%",hour,min,sec];
    // NSString *sa = [TimeUtil stringFromDate:now dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSString *ye = [NSString stringWithFormat:@"%d",y];

    
    NSString *mo = [NSString stringWithFormat:@"%d",m];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    
     [dic setValue:ye forKey:@"year"];
     [dic setValue:mo forKey:@"mouth"];
    
    return dic;
    
}


+ (NSMutableDictionary *)getTodayWeekedDate:(NSDate *)date
{


    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit
                                         fromDate:now];
    
    // 得到星期几
    // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
    NSInteger weekDay = [comp weekday]-1;
    // 得到几号
    NSInteger day = [comp day];
    
    
    
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = 0;
        lastDiff = 6;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay;
        lastDiff = 9 - weekDay-2;
    }
    
    NSLog(@"firstDiff:%ld   lastDiff:%ld",firstDiff,lastDiff);
    
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd "];
    NSLog(@"星期一开始 %@",[formater stringFromDate:firstDayOfWeek]);
    NSLog(@"当前 %@",[formater stringFromDate:now]);
    NSLog(@"星期天结束 %@",[formater stringFromDate:lastDayOfWeek]);

    
    
    NSString *a = [NSString stringWithFormat:@"%@",[formater stringFromDate:firstDayOfWeek]];
    NSString *b = [NSString stringWithFormat:@"%@",[formater stringFromDate:lastDayOfWeek]];


    NSString *startTime = [NSString getdayDate:a];

    NSString *endTime = [NSString getdayDate:b];


    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setValue:startTime forKey:@"beginTime"];
    [dic setValue:endTime forKey:@"endTime"];


    return dic;

    
    

}

//----获得今天的日期----
+ (NSString *)getdayDate:(NSString *)time
{

    //日期
    // NSDate* now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:time];
    
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit;
    NSDateComponents *dd = [cal components:unitFlags fromDate:date];
    int y = (int)[dd year];
    int m = (int)[dd month];
    int d = (int)[dd day];
    
    //    int hour = [dd hour];
    //    int min = [dd minute];
    //    int sec = [dd second];
    
    //    Lable1.text = [NSString stringWithFormat:@"2d%:2d%:2d%",y,m,d];
    //    Lable2.text =[NSStrinstringWithFormat:@"2d%:2d%:2d%",hour,min,sec];
    // NSString *sa = [TimeUtil stringFromDate:now dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *mouthAndDatStr = [NSString stringWithFormat:@"%d-%d-%d",y,m,d];
    
    return mouthAndDatStr;


}

//----本月--第一条----最后一天---
+ (NSMutableDictionary *)getMonthBeginAndEndWith:(NSDate *)todayDate{
    
//    NSDateFormatter *format=[[NSDateFormatter alloc] init];
//    [format setDateFormat:@"yyyy-MM"];
//    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:todayDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY.MM.dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    NSString *s = [NSString stringWithFormat:@"%@-%@",beginString,endString];
    
    
    
    NSString *a = [NSString stringWithFormat:@"%@",beginString];
    NSString *b = [NSString stringWithFormat:@"%@",endString];
    
    
    NSString *startTime = [NSString getdayDate:a];
    
    NSString *endTime = [NSString getdayDate:b];
    
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:startTime forKey:@"beginTime"];
    [dic setValue:endTime forKey:@"endTime"];

    return dic;
    
    
    
}

//-------几月几号---------

+ (NSString *)getMouthMMdd:(NSString *)timeStr
{
    //日期
    // NSDate* now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit;
    NSDateComponents *dd = [cal components:unitFlags fromDate:date];
    //int y = [dd year];
    int m = (int)[dd month];
    int d = (int)[dd day];
    
    //    int hour = [dd hour];
    //    int min = [dd minute];
    //    int sec = [dd second];
    
    //    Lable1.text = [NSString stringWithFormat:@"2d%:2d%:2d%",y,m,d];
    //    Lable2.text =[NSStrinstringWithFormat:@"2d%:2d%:2d%",hour,min,sec];
    // NSString *sa = [TimeUtil stringFromDate:now dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *mouthAndDatStr = [NSString stringWithFormat:@"%d-%d",m,d];
    
    
    return mouthAndDatStr;
    
}




/*
 比较两个时间大小
 **/

+ (NSString *)bigDate:(NSString *)big sameDate:(NSString *)same
{


    
    
//    //计算上报时间差
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYY-MM-dd"];//设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
//    [formatter setTimeZone:timeZone];
//    NSDate *datenow = [NSDate date];
    
    
    //设置一个字符串的时间
    NSMutableString *samtring = [NSMutableString stringWithFormat:@"%@",same];
    //注意 如果20141202052740必须是数字，如果是UNIX时间，不需要下面的插入字符串。
    NSLog(@"datestring==%@",samtring);
    NSDateFormatter * samDm = [[NSDateFormatter alloc]init];
    //指定输出的格式   这里格式必须是和上面定义字符串的格式相同，否则输出空
    [samDm setDateFormat:@"YYYY-MM-dd"];
    NSDate * samD = [samDm dateFromString:samtring];

    
    
    
    
    
    
    
    
    //设置一个字符串的时间
    NSMutableString *bigtring = [NSMutableString stringWithFormat:@"%@",big];
    //注意 如果20141202052740必须是数字，如果是UNIX时间，不需要下面的插入字符串。
    NSLog(@"datestring==%@",bigtring);
    NSDateFormatter * bigDm = [[NSDateFormatter alloc]init];
    //指定输出的格式   这里格式必须是和上面定义字符串的格式相同，否则输出空
    [bigDm setDateFormat:@"YYYY-MM-dd"];
    
    
    NSDate * bigD = [bigDm dateFromString:bigtring];
    
    
    long dd = (long)[bigD timeIntervalSince1970] - [samD timeIntervalSince1970];
    NSString *timeString=@"";
    
    timeString = [NSString stringWithFormat:@"%ld", dd/86400];
   // timeString=[NSString stringWithFormat:@"%@天前", timeString];
    
    
    
    
    NSString *h = [NSString stringWithFormat:@"%@",timeString];
    
    return h;
  
}



/**
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+(NSString *) compareCurrentTime:(NSDate*)currentDate withAfterTime:(NSDate *)afterDate
//
{
    NSTimeInterval  timeInterval = [currentDate timeIntervalSinceDate:afterDate];
    timeInterval = -timeInterval;
    
    timeInterval = ABS(timeInterval);

    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%d分前",(int)temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%d小前",(int)temp];
    }
    
    else if((temp = temp/24) <30){
       NSString *s = [NSString stringWithFormat:@"%d",(int)temp];
        if ([s isEqualToString:@"1"]) {
            
            result = @"1";
            
        }else{
        
         result = @"2";
         
        }
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%d月前",(int)temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%d年前",(int)temp];
    }
    
    return  result;
}



//----得出相差几天
+(NSString *)OthrecompareCurrentTime:(NSDate*)currentDate withAfterTime:(NSDate *)afterDate
{
    NSTimeInterval  timeInterval = [currentDate timeIntervalSinceDate:afterDate];
    timeInterval = -timeInterval;
    
    timeInterval = ABS(timeInterval);
    
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%d分前",(int)temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%d小前",(int)temp];
    }
    
    else if((temp = temp/24) <30){
        NSString *s = [NSString stringWithFormat:@"%d",(int)temp];
//        if ([s isEqualToString:@"1"]) {
//            
//            result = @"1";
//            
//        }else{
//            
//            result = @"2";
//            
//        }
        
        return s;
        
        
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%d月前",(int)temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%d年前",(int)temp];
    }
    
    return  result;


}

+ (NSString *)agoTime:(NSString *)beforeTime afterTime:(NSString *)afterTime
{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
   [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    NSDate* sDate = [dateFormatter dateFromString:beforeTime];
    NSDate* eDate = [dateFormatter dateFromString:afterTime];

    BOOL result = [sDate compare:eDate];
    
    NSString *resultStr;

    switch (result) {
        case NSOrderedDescending:
        {
        
        resultStr = @"0";//过期
        
            break;
        }case NSOrderedAscending:
        {
        
        
        resultStr = @"1";//没有过期
        
            break;
        }case NSOrderedSame:
        {
        
        resultStr = @"1";//一样大
        
        
            break;
        }
            break;
            
        default:
            break;
    }


    return resultStr;




}


//-----2016-2-20----2-20
+  (NSString *)MMDDWithYYMMDD:(NSString *)timeStr
{

    
   // NSString *timeStr = [NSString stringWithFormat:@"%@",inhouseModel.startDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* inhouseDate = [dateFormatter dateFromString:timeStr];
    
   // MSLog(@"----%@-----",inhouseDate);
    
    
    
    NSTimeZone *zoneRend = [NSTimeZone systemTimeZone];
    NSInteger intervalRend = [zoneRend secondsFromGMTForDate: inhouseDate];
    NSDate *localeDateRend = [inhouseDate  dateByAddingTimeInterval: intervalRend];
    //MSLog(@"enddate=%@",localeDateRend);
    
    
    
    //---算出默认下一天的时间--
    // NSMutableArray *dates = [[NSMutableArray alloc] initWithCapacity:18];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitCalendar;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    QHCalendayModel *model = [QHCalendayModel new];
    
    NSTimeInterval late=0*24*3600;
    NSDate *oneDaysAfterTime = [NSDate dateWithTimeInterval:late sinceDate:localeDateRend];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[oneDaysAfterTime timeIntervalSince1970]+0];
    NSDateComponents *calendarTime = [calendar components:unitFlags fromDate:date];
    model.calendarTime = calendarTime;
    NSString *endTimestr = [NSString stringWithFormat:@"%d-%d",(int)calendarTime.month,(int)calendarTime.day];
    
    //MSLog(@"--%@----",endTimestr);
    
  
    return endTimestr;


}




/*
 获得设备UUID--可变
 **/
+ (NSString *)getAppUUIDString
{

 NSString *uuid = [[NSUUID UUID] UUIDString];
 NSString *curStr = [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];

 return curStr;

}




+ ( NSMutableAttributedString *)stringWithBeforStr:(NSString *)befor andendStr:(NSString *)end withAllStr:(NSString *)muStr
{

    
    
    NSMutableAttributedString *tuitodayIn = [[NSMutableAttributedString alloc]initWithString:muStr];
    NSInteger tuilen = [tuitodayIn length];
    //设置：在0-3个单位长度内的内容显示成红色
    
    NSString *tuibeforstr = befor;
    NSInteger tuibeforLen = [tuibeforstr length];
    
    NSString *tuiendStr = end;
    NSInteger tuiendLen = [tuiendStr length];
    
    [tuitodayIn addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:NomalBlueTextFontColor] range:NSMakeRange(tuibeforLen,tuilen - tuibeforLen - tuiendLen)];
//    
//    if ([muStr integerValue] ==0) {
//        
//        return muStr;
//        
//    }else{
        return tuitodayIn;
    
    //}
    
}




@end
