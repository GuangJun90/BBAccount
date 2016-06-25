//
//  OtherTimeCell.h
//  ELuYunApp
//
//  Created by apple on 16/4/2.
//  Copyright © 2016年 zhaoguodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CT_OtherTimeCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *startTimeBtn;

@property (weak, nonatomic) IBOutlet UIButton *endTimeBtn;


- (void)setValueWithArray:(NSMutableArray *)arr indexPath:(NSIndexPath *)indexPath;

- (void)setValueWithStartTime:(NSString *)startTime andEndTime:(NSString *)endTime indexPath:(NSIndexPath *)indexPath;
@end
