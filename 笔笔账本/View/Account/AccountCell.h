//
//  AccountCell.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/20.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountListModel.h"

@interface AccountCell : UITableViewCell
/** 账单详细数据 */
@property(nonatomic,strong) AccountListModel *accountModel;
+(instancetype)theAccountCellWith:(AccountListModel *)accountModel;

@end
