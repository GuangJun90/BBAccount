//
//  AccountDailyModel.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/19.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountDailyModel : NSObject
/** 日期 */
@property(nonatomic,assign) NSInteger date;
/** 本金 */
@property(nonatomic,assign) float capitalP;
/** 毛收入 */
@property(nonatomic,assign) float grossIncomeP;
/** 每天的总营业额 */
@property(nonatomic,assign) float turnover;
/** 水费 */
@property(nonatomic,assign) float waterP;
/** 电费 */
@property(nonatomic,assign) float eleP;
/** 采购费 */
@property(nonatomic,assign) float goodsInP;
/** 房租 */
@property(nonatomic,assign) float rentP;
/** 其他费用 */
@property(nonatomic,assign) float otherP;

@end


