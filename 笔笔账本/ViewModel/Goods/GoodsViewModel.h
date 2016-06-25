//
//  GoodsViewModel.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/6.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"

@interface GoodsViewModel : NSObject

/** 货物的数据数组 */
@property(nonatomic,strong) NSArray<GoodsModel *> *goodsArray;

/** 根据货物分类返回货物的数组 */
-(NSArray<GoodsModel *> *)goodsArrayWithCategory:(NSString *)category;

+(void)saveModelToSQLWith:(GoodsModel *)goodsModel;

/** 改货物的数据 */
+(void)changeModelToSQLWith:(GoodsModel *)goodsModel;


@end
