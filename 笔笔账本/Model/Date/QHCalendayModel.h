//
//  QHCalendarModel.h
//  zhoudao
//
//  Created by imqiuhang on 15/7/27.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//


@interface QHCalendayModel : NSObject

@property (nonatomic,strong) NSString         *weekdayStr;

@property (nonatomic,strong) NSDateComponents *calendarTime;

@property(nonatomic)int hour;

@end
