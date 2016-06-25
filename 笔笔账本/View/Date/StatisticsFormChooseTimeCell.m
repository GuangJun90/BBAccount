//
//  ChooseTimeCell.m
//  ELuYunApp
//
//  Created by apple on 16/3/31.
//  Copyright © 2016年 zhaoguodong. All rights reserved.
//

#import "StatisticsFormChooseTimeCell.h"

@implementation StatisticsFormChooseTimeCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setViewDataWithArray:(NSMutableArray *)arr
{
    
}

+ (CGFloat)getTableViewHeight:(id)sender{
    return 40;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setValueWithArray:(NSMutableArray *)arr index:(NSInteger)index{
    NSDictionary *dic = arr[index];
    self.timeSelectLabel.text = [dic objectForKey:@"startTime"];
    
}



@end
