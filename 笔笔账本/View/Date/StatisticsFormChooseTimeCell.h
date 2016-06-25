//
//  ChooseTimeCell.h
//  ELuYunApp
//
//  Created by apple on 16/3/31.
//  Copyright © 2016年 zhaoguodong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 统计报表
 */
@interface StatisticsFormChooseTimeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeSelectLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectImage;
- (void)setValueWithArray:(NSMutableArray *)arr index:(NSInteger)index;
+ (CGFloat)getTableViewHeight:(id)sender;

- (void)setViewDataWithArray:(NSMutableArray *)arr;




@end
