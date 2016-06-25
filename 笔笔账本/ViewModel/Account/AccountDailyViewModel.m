//
//  AccountDailyViewModel.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/19.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "AccountDailyViewModel.h"

@implementation AccountDailyViewModel
/** 保存详细账单数据 */
+(void)saveModelToSQLWith:(AccountDailyModel *)model{
    //1.创建数据库(xx/Documents/fmdb.db)
    NSString *documentPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbFilePath=[documentPath stringByAppendingPathComponent:@"account.db"];
    //仅仅是创建fmdb.db文件,并没有打开
    FMDatabase *database=[FMDatabase databaseWithPath:dbFilePath];
    NSString *createStr = @"create table if not exists daily (id integer primary key, date integer, capitalP real, grossIncomeP real,turnover real, waterP real, eleP real, goodsInP real, rentP real, otherP real)";
    
    if ([database open]) {
        BOOL isSucess = [database executeUpdate:createStr];
        if (!isSucess) {
            DLog(@"------创建表失败:%@",database.lastError);
        }
    }
    NSString *insertStr = @"insert into daily (date, capitalP, grossIncomeP, turnover, waterP, eleP, goodsInP, rentP, otherP) values (?,?,?,?,?,?,?,?,?)";
    BOOL isSucess=[database executeUpdate:insertStr,@(model.date), @(model.capitalP), @(model.grossIncomeP), @(model.turnover), @(model.waterP), @(model.eleP), @(model.goodsInP), @(model.rentP), @(model.otherP)];
    
    if (!isSucess) {
        NSLog(@"---插入数据失败:%@",database.lastError);
    }
    [database close];
    
}
/** 返回所有详细账单数据 */
-(NSArray<AccountDailyModel *> *)getAccountDailyModelArray{
    NSString *documentPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbFilePath=[documentPath stringByAppendingPathComponent:@"account.db"];
    NSFileManager *fileMger = [NSFileManager defaultManager];
    //如果文件路径存在的话
    BOOL bRet = [fileMger fileExistsAtPath:dbFilePath];
    if (!bRet) {
        return nil;
    }
    //仅仅是创建fmdb.db文件,并没有打开
    FMDatabase *database=[FMDatabase databaseWithPath:dbFilePath];
    
    NSString *createStr = @"create table if not exists daily (id integer primary key, date integer, capitalP real, grossIncomeP real,turnover real, waterP real, eleP real, goodsInP real, rentP real, otherP real)";
    
    if ([database open]) {
        BOOL isSucess = [database executeUpdate:createStr];
        if (!isSucess) {
            DLog(@"------创建表失败:%@",database.lastError);
        }
    }
    
    NSMutableArray *mutArray = [NSMutableArray array];
    if ([database open]) {
        NSString *selectStr = @"select * from daily";
        FMResultSet *resultSet = [database executeQuery:selectStr];
        while ([resultSet next]) {
            AccountDailyModel *model = [self modelWith:resultSet];
            [mutArray addObject:model];
        }
    }
    [database close];
    return [mutArray copy];
    
}
/** 解析 */
- (AccountDailyModel *)modelWith:(FMResultSet *)resultSet{
    AccountDailyModel *model = [AccountDailyModel new];
    model.date = [resultSet intForColumn:@"date"];
    model.capitalP = [resultSet doubleForColumn:@"capitalP"];
    model.grossIncomeP = [resultSet doubleForColumn:@"grossIncomeP"];
    model.turnover = [resultSet doubleForColumn:@"turnover"];
    model.waterP = [resultSet doubleForColumn:@"waterP"];
    model.eleP = [resultSet doubleForColumn:@"eleP"];
    model.goodsInP = [resultSet doubleForColumn:@"goodsInP"];
    model.rentP = [resultSet doubleForColumn:@"rentP"];
    model.otherP = [resultSet doubleForColumn:@"otherP"];
    return model;
}
/** 根据model更改数据 */
+(void)changeModelToSQLWith:(AccountDailyModel *)model{
    NSString *documentPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbFilePath=[documentPath stringByAppendingPathComponent:@"account.db"];
    NSFileManager *fileMger = [NSFileManager defaultManager];
    //如果文件路径存在的话
    BOOL bRet = [fileMger fileExistsAtPath:dbFilePath];
    if (!bRet) {
        return;
    }
    NSString *changeStr = [NSString stringWithFormat:@"update daily set grossIncomeP=%f  where date='%ld'",model.grossIncomeP,(long)model.date];
    NSString *changeStr0 = [NSString stringWithFormat:@"update daily set capitalP=%f  where date='%ld'",model.capitalP,(long)model.date];
    NSString *changeStr1 = [NSString stringWithFormat:@"update daily set turnover=%f  where date='%ld'",model.turnover,(long)model.date];
    NSString *changeStr2 = [NSString stringWithFormat:@"update daily set waterP=%f  where date='%ld'",model.waterP,(long)model.date];
    NSString *changeStr3 = [NSString stringWithFormat:@"update daily set eleP=%f  where date='%ld'",model.eleP,(long)model.date];
    NSString *changeStr4 = [NSString stringWithFormat:@"update daily set goodsInP=%f  where date='%ld'",model.goodsInP,(long)model.date];
    NSString *changeStr5 = [NSString stringWithFormat:@"update daily set rentP=%f  where date='%ld'",model.rentP,(long)model.date];
    NSString *changeStr6 = [NSString stringWithFormat:@"update daily set otherP=%f  where date='%ld'",model.otherP,(long)model.date];
    
    //仅仅是创建fmdb.db文件,并没有打开
    FMDatabase *database=[FMDatabase databaseWithPath:dbFilePath];
    if ([database open]) {
        BOOL isSucess = [database executeUpdate:changeStr];
        if (!isSucess) {
            DLog(@"------修改表失败:%@",database.lastError);
        }
        isSucess = [database executeUpdate:changeStr0];
        if (!isSucess) {
            DLog(@"------修改表失败:%@",database.lastError);
        }
        isSucess = [database executeUpdate:changeStr1];
        if (!isSucess) {
            DLog(@"------修改表失败:%@",database.lastError);
        }
        isSucess = [database executeUpdate:changeStr2];
        if (!isSucess) {
            DLog(@"------修改表失败:%@",database.lastError);
        }
        isSucess = [database executeUpdate:changeStr3];
        if (!isSucess) {
            DLog(@"------修改表失败:%@",database.lastError);
        }
        isSucess = [database executeUpdate:changeStr4];
        if (!isSucess) {
            DLog(@"------修改表失败:%@",database.lastError);
        }
        isSucess = [database executeUpdate:changeStr5];
        if (!isSucess) {
            DLog(@"------修改表失败:%@",database.lastError);
        }
        isSucess = [database executeUpdate:changeStr6];
        if (!isSucess) {
            DLog(@"------修改表失败:%@",database.lastError);
        }
    }
    [database close];
}

/** 返回某时间段的数据 */
-(NSArray<AccountDailyModel *> *)getAccountDailyModelArrayFrom:(NSString *)startTimeStr To:(NSString *)endTimeStr{
    NSArray<AccountDailyModel *> *array = [self getAccountDailyModelArray];
    NSMutableArray *mutArray = [NSMutableArray array];
    for (AccountDailyModel *model in array) {
        if (model.date >= [startTimeStr integerValue] &&  model.date <= [endTimeStr integerValue]) {
            [mutArray addObject:model];
        }
    }
    return [self sortArrayWith:mutArray];
}
/** 排序 */
- (NSArray<AccountDailyModel *> *)sortArrayWith:(NSMutableArray<AccountDailyModel *> *)array{
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];//其中，date为数组中的对象的属性，这个针对数组中存放对象比较更简洁方便
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    [array sortUsingDescriptors:sortDescriptors];
    
    return [array copy];
}

#pragma mark - ******** CountChart ********
/** 根据某段时间的数据返回该段时间营业额的最大值 */
- (float)theMaxTurnoverWith:(NSArray<AccountDailyModel *> *)array{
    float max = 0;
    for (AccountDailyModel *model in array) {
        if (max < model.turnover) {
            max = model.turnover;
        }
    }
    return max;
}
/** 根据某段时间的数据返回该段时间营业额的最小值 */
- (float)theMinTurnoverWith:(NSArray<AccountDailyModel *> *)array{
    if (array.count == 0) {
        return 0;
    }
    float min = array[0].turnover;
    for (AccountDailyModel *model in array) {
        if (min > model.turnover) {
            min = model.turnover;
        }
    }
    return min;
}
/** 根据某段时间的数据返回该段时间营业额的最大值的日期 */
- (NSString *)theMaxTurnoverDateWith:(NSArray<AccountDailyModel *> *)array{
    if (array.count == 0) {
        return nil;
    }
    int index = 0;
    float max = array[0].turnover;
    for (int i = 0; i < array.count; i++) {
        AccountDailyModel *model = array[i];
        if (max < model.turnover) {
            max = model.turnover;
            index = i;
        }
    }
    NSString *dateStr = [NSString stringWithFormat:@"%ld",(long)array[index].date];
//    NSRange year = {0,4};
    NSRange month = {4,2};
    NSRange day = {6,2};
    NSString *yearStr = [dateStr substringToIndex:4];
    NSString *monthStr=[dateStr substringWithRange:month];
    NSString *dayStr=[dateStr substringWithRange:day];
    return [NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr];
    
}
/** 根据某段时间的数据返回该段时间营业额的最小值的日期 */
- (NSString *)theMinTurnoverDateWith:(NSArray<AccountDailyModel *> *)array{
    if (array.count == 0) {
        return nil;
    }
    int index = 0;
    float min = array[0].turnover;
    for (int i = 0; i < array.count; i++) {
        AccountDailyModel *model = array[i];
        if (min > model.turnover) {
            min = model.turnover;
            index = i;
        }
    }
    NSString *dateStr = [NSString stringWithFormat:@"%ld",(long)array[index].date];
//    NSRange year = {0,4};
    NSRange month = {4,2};
    NSRange day = {6,2};
    NSString *yearStr = [dateStr substringToIndex:4];
    NSString *monthStr=[dateStr substringWithRange:month];
    NSString *dayStr=[dateStr substringWithRange:day];
    return [NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr];
}


/** 根据某段时间的数据返回该段时间每天的日期(06-22) */
- (NSArray<NSString *> *)theDateArrayWith:(NSArray<AccountDailyModel *> *)array{
    NSMutableArray *mutArray = [NSMutableArray array];
    for (AccountDailyModel *model in array) {
        NSString *dateStr = [NSString stringWithFormat:@"%ld",(long)model.date];
        NSRange month = {4,2};
        NSRange day = {6,2};
        NSString *monthStr=[dateStr substringWithRange:month];
        NSString *dayStr=[dateStr substringWithRange:day];
        
        [mutArray addObject:[NSString stringWithFormat:@"%@-%@",monthStr,dayStr]];
    }
    return [mutArray copy];
}
/** 根据某段时间的数据返回该段时间每天的营业额 */
- (NSArray *)theTurnoverArrayWith:(NSArray<AccountDailyModel *> *)array{
    NSMutableArray *mutArray = [NSMutableArray array];
    for (AccountDailyModel *model in array) {
        [mutArray addObject:[NSString stringWithFormat:@"%.2f",model.turnover]];
    }
    return [mutArray copy];
}
/** 根据某段时间的数据返回该段时间总营业额 */
- (float)theTotalTurnoverWith:(NSArray<AccountDailyModel *> *)array{
    float total = 0;
    for (AccountDailyModel *model in array) {
        total += model.turnover;
    }
    return total;
}
/** 根据某段时间的数据返回该段时间总水费 */
- (float)theTotalWaterPWith:(NSArray<AccountDailyModel *> *)array{
    float total = 0;
    for (AccountDailyModel *model in array) {
        total += model.waterP;
    }
    return total;
}
/** 根据某段时间的数据返回该段时间总电费 */
- (float)theTotalElePWith:(NSArray<AccountDailyModel *> *)array{
    float total = 0;
    for (AccountDailyModel *model in array) {
        total += model.eleP;
    }
    return total;
}
/** 根据某段时间的数据返回该段时间总采购费 */
- (float)theTotalGoodsInPWith:(NSArray<AccountDailyModel *> *)array{
    float total = 0;
    for (AccountDailyModel *model in array) {
        total += model.goodsInP;
    }
    return total;
}
/** 根据某段时间的数据返回该段时间总房租费 */
- (float)theTotalRentPWith:(NSArray<AccountDailyModel *> *)array{
    float total = 0;
    for (AccountDailyModel *model in array) {
        total += model.rentP;
    }
    return total;
}
/** 根据某段时间的数据返回该段时间总其他消费 */
- (float)theTotalOtherPWith:(NSArray<AccountDailyModel *> *)array{
    float total = 0;
    for (AccountDailyModel *model in array) {
        total += model.otherP;
    }
    return total;
}




@end
