//
//  SuppliersViewModel.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/16.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuppliersModel.h"

@interface SuppliersViewModel : NSObject
/** 客户的数据 */
@property(nonatomic,strong) NSArray<SuppliersModel *> *suppliersArr;
+(void)saveModelToSQLWith:(SuppliersModel *)clientsModel;
//返回所有客户的姓名
-(NSArray *)getSuppliersNameArray;

@end
