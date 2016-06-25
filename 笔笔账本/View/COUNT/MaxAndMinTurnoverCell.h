//
//  MaxAndMinTurnoverCell.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/23.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountDailyViewModel.h"
#import "AccountDailyModel.h"

@interface MaxAndMinTurnoverCell : UITableViewCell


- (void)setViewDataWithArray:(NSArray<AccountDailyModel *> *)arr;
+ (CGFloat)getTableViewHeight:(id)sender;

@end
