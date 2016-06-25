//
//  HZQDatePickerView.h
//  HZQDatePickerView
//
//  Created by 1 on 15/10/26.
//  Copyright © 2015年 HZQ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    
    // 开始日期
    DateTypeOfStart = 0,
    
    // 结束日期
    DateTypeOfEnd,
    
    //项目时间
    DateTypeOfItem,
    
    DateTypeOfFood,
    
    DateTypeOfAmusement,
    
}DateType;

@class HZQDatePickerView;

@protocol HZQDatePickerViewDelegate <NSObject>

@optional
- (void)getSelectDate:(NSString *)date type:(DateType)type;

//- (void)getTimeData:(NSString *)time type:(DateType)type;

- (void)datePickerView:(HZQDatePickerView *)pickerView getSelectDate:(NSString *)date type:(DateType)type;

@end

@interface HZQDatePickerView : UIView

+ (HZQDatePickerView *)instanceDatePickerView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

@property (nonatomic, weak) id<HZQDatePickerViewDelegate> delegate;

@property (nonatomic, assign) DateType type;

@property (nonatomic, strong) NSString* itemType;//新加为区别餐饮与娱乐

@property (nonatomic,assign)NSInteger tagForIdx;//用于记录位置

-(void)initWithDate:(NSDate*)datex;

@end
