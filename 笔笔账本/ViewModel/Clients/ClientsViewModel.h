//
//  ClientsViewModel.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/15.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClientsModel.h"

@interface ClientsViewModel : NSObject
/** 客户的数据 */
@property(nonatomic,strong) NSArray<ClientsModel *> *clientsArr;
+(void)saveModelToSQLWith:(ClientsModel *)clientsModel;
//返回所有客户的姓名
-(NSArray *)getClientsNameArray;

@end
