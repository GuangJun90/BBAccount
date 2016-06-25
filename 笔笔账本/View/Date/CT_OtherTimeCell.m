//
//  OtherTimeCell.m
//  ELuYunApp
//
//  Created by apple on 16/4/2.
//  Copyright © 2016年 zhaoguodong. All rights reserved.
//

#import "CT_OtherTimeCell.h"

@implementation CT_OtherTimeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setValueWithArray:(NSMutableArray *)arr indexPath:(NSIndexPath *)indexPath
{

    NSDictionary *dic = arr[indexPath.row];
    [self.startTimeBtn setTitle:[dic objectForKey:@"startTime"] forState:UIControlStateNormal];
    [self.endTimeBtn setTitle:[dic objectForKey:@"endTime"] forState:UIControlStateNormal];
    
    
}
- (void)setValueWithStartTime:(NSString *)startTime andEndTime:(NSString *)endTime indexPath:(NSIndexPath *)indexPath
{
    self.startTimeBtn.titleLabel.font = NormalTextFont;
    self.endTimeBtn.titleLabel.font = NormalTextFont;
    if([startTime isEqual:[NSNull null]]||[startTime isEqualToString:@""])
    {
        startTime = @"开始时间";
    }
    if([endTime isEqual:[NSNull null]]||[endTime isEqualToString:@""])
    {
        endTime = @"结束时间";
    }
    [self.startTimeBtn setTitle:startTime forState:UIControlStateNormal];
    [self.endTimeBtn setTitle:endTime forState:UIControlStateNormal];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
