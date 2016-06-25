//
//  AccountDailyViewModel.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/19.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountDailyModel.h"

@interface AccountDailyViewModel : NSObject
/** 保存详细账单数据 */
+(void)saveModelToSQLWith:(AccountDailyModel *)model;
/** 返回所有详细账单数据 */
-(NSArray<AccountDailyModel *> *)getAccountDailyModelArray;
/** 根据model更改数据 */
+(void)changeModelToSQLWith:(AccountDailyModel *)model;

/** 返回某时间段的数据 */
- (NSArray<AccountDailyModel *> *)getAccountDailyModelArrayFrom:(NSString*)startTimeStr To:(NSString *)endTimeStr;

/** 根据某段时间的数据返回该段时间营业额的最大值 */
- (float)theMaxTurnoverWith:(NSArray<AccountDailyModel *> *)array;
/** 根据某段时间的数据返回该段时间营业额的最小值 */
- (float)theMinTurnoverWith:(NSArray<AccountDailyModel *> *)array;
/** 根据某段时间的数据返回该段时间营业额的最大值的日期 */
- (NSString *)theMaxTurnoverDateWith:(NSArray<AccountDailyModel *> *)array;
/** 根据某段时间的数据返回该段时间营业额的最小值的日期 */
- (NSString *)theMinTurnoverDateWith:(NSArray<AccountDailyModel *> *)array;

/** 根据某段时间的数据返回该段时间每天的日期(06-22) */
- (NSArray<NSString *> *)theDateArrayWith:(NSArray<AccountDailyModel *> *)array;
/** 根据某段时间的数据返回该段时间每天的营业额 */
- (NSArray *)theTurnoverArrayWith:(NSArray<AccountDailyModel *> *)array;
/** 根据某段时间的数据返回该段时间总营业额 */
- (float)theTotalTurnoverWith:(NSArray<AccountDailyModel *> *)array;
/** 根据某段时间的数据返回该段时间总水费 */
- (float)theTotalWaterPWith:(NSArray<AccountDailyModel *> *)array;
/** 根据某段时间的数据返回该段时间总电费 */
- (float)theTotalElePWith:(NSArray<AccountDailyModel *> *)array;
/** 根据某段时间的数据返回该段时间总采购费 */
- (float)theTotalGoodsInPWith:(NSArray<AccountDailyModel *> *)array;
/** 根据某段时间的数据返回该段时间总房租费 */
- (float)theTotalRentPWith:(NSArray<AccountDailyModel *> *)array;
/** 根据某段时间的数据返回该段时间总其他消费 */
- (float)theTotalOtherPWith:(NSArray<AccountDailyModel *> *)array;



@end
