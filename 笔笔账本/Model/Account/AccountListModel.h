//
//  AccountListModel.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/18.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountListModel : NSObject
/** 收支 */
@property(nonatomic,assign,getter=isIncome) BOOL income;
/** 时间 */
@property(nonatomic,strong) NSString *time;
/** 对象 */
@property(nonatomic,strong) NSString *object;
/** 对象名称 */
@property(nonatomic,strong) NSString *objectName;
/** 货物名 */
@property(nonatomic,strong) NSString *goodsName;
/** 货物单价 */
@property(nonatomic,assign) float unitP;
/** 货物数量 */
@property(nonatomic,assign) float goodsNum;
/** 总价 */
@property(nonatomic,assign) float totalP;
/** timeID */
@property(nonatomic,assign) NSInteger timeID;

@end
