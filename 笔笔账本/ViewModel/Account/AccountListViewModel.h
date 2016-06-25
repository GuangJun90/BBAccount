//
//  AccountListViewModel.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/18.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountListModel.h"


@interface AccountListViewModel : NSObject

/** 保存详细账单数据 */
+(void)saveModelToSQLWith:(AccountListModel *)model toDate:(NSString *)date;
/** 返回某天的所有详细账单数据 */
-(NSArray<AccountListModel *> *)getAccountListArrayWith:(NSString *)date;

@end
