//
//  GoodsModel.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/6.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject
/** 货物名称 */
@property(nonatomic,strong) NSString *name;
/** 货物ID */
@property(nonatomic,assign) NSInteger ID;
/** 货物图片 */
@property(nonatomic,strong) NSData *Img;
/** 货物采购价 */
@property(nonatomic,assign) float purchase;
/** 货物零售价 */
@property(nonatomic,assign) float retail;
/** 货物批发价 */
@property(nonatomic,assign) float trade;
/** 库存量 */
@property(nonatomic,assign) float stock;
/** 货物分类 */
@property(nonatomic,strong) NSString *category;
/** 是否预警 */
@property(nonatomic,assign,getter=isWarning) BOOL warning;
/** 上限 */
@property(nonatomic,assign) float upperLimit;
/** 下限 */
@property(nonatomic,assign) float lowLimit;
/** id */
@property(nonatomic,assign) NSInteger goodsID;


@end
