//
//  AccountListViewModel.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/18.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "AccountListViewModel.h"

@implementation AccountListViewModel
+(void)saveModelToSQLWith:(AccountListModel *)model toDate:(NSString *)date{
    //1.创建数据库(xx/Documents/fmdb.db)
    NSString *documentPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbFilePath=[documentPath stringByAppendingPathComponent:@"accountList.db"];
    //仅仅是创建fmdb.db文件,并没有打开
    FMDatabase *database=[FMDatabase databaseWithPath:dbFilePath];
    NSString *createStr = [NSString stringWithFormat:@"create table if not exists w%@ (id integer primary key, income integer, time text, object text, objectName text, goodsName text, unitP real, goodsNum real, totalP real, timeID integer)",date];

    
    if ([database open]) {
        BOOL isSucess = [database executeUpdate:createStr];
        if (!isSucess) {
            DLog(@"------创建表失败:%@",database.lastError);
        }
    }
    NSString *insertStr = [NSString stringWithFormat:@"insert into w%@ (income, time, object, objectName, goodsName, unitP, goodsNum, totalP, timeID) values (?,?,?,?,?,?,?,?,?)",date];
    BOOL isSucess=[database executeUpdate:insertStr, @(model.income), model.time, model.object, model.objectName, model.goodsName, @(model.unitP), @(model.goodsNum), @(model.totalP), @(model.timeID)];
    
    if (!isSucess) {
        NSLog(@"---插入数据失败:%@",database.lastError);
    }
    [database close];
}

- (AccountListModel *)modelWith:(FMResultSet *)resultSet{
    AccountListModel *model = [AccountListModel new];
    model.income = [resultSet intForColumn:@"income"];
    model.time = [resultSet stringForColumn:@"time"];
    model.object = [resultSet stringForColumn:@"object"];
    model.objectName = [resultSet stringForColumn:@"objectName"];
    model.goodsName = [resultSet stringForColumn:@"goodsName"];
    model.unitP = [resultSet doubleForColumn:@"unitP"];
    model.goodsNum = [resultSet doubleForColumn:@"goodsNum"];
    model.totalP = [resultSet doubleForColumn:@"totalP"];
    model.timeID = [resultSet intForColumn:@"timeID"];
    return model;
}
    
-(NSArray<AccountListModel *> *)getAccountListArrayWith:(NSString *)date{
    NSString *documentPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbFilePath=[documentPath stringByAppendingPathComponent:@"accountList.db"];
    NSFileManager *fileMger = [NSFileManager defaultManager];
    
    //如果文件路径存在的话
    BOOL bRet = [fileMger fileExistsAtPath:dbFilePath];
    if (!bRet) {
        return nil;
    }
    //仅仅是创建fmdb.db文件,并没有打开
    FMDatabase *database=[FMDatabase databaseWithPath:dbFilePath];
    
    NSString *createStr = [NSString stringWithFormat:@"create table if not exists w%@ (id integer primary key, income integer, time text, object text, objectName text, goodsName text, unitP real, goodsNum real, totalP real, timeID integer)",date];
    if ([database open]) {
        BOOL isSucess = [database executeUpdate:createStr];
        if (!isSucess) {
            DLog(@"------创建表失败:%@",database.lastError);
        }
    }
    
    NSMutableArray *mutArray = [NSMutableArray array];
    if ([database open]) {
        NSString *selectStr = [NSString stringWithFormat:@"select * from w%@",date];
        FMResultSet *resultSet = [database executeQuery:selectStr];
        while ([resultSet next]) {
            AccountListModel *model = [self modelWith:resultSet];
            [mutArray addObject:model];
        }
    }
    [database close];
    NSArray *arr = [self sortArrayWith:mutArray];
    return arr;
}
- (NSArray<AccountListModel *> *)sortArrayWith:(NSMutableArray<AccountListModel *> *)array{
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeID" ascending:YES];//其中，timeID为数组中的对象的属性，这个针对数组中存放对象比较更简洁方便
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    [array sortUsingDescriptors:sortDescriptors];
    
    return [array copy];
}
- (NSInteger)handleTimeStr:(NSString *)timeStr{
    NSString *resultStr = @"";
    NSArray *array = [timeStr componentsSeparatedByString:@":"];
    for (NSString *  str in array) {
        NSString *tempStr = str;
        if (str.length<4 && str.length == 1) {
            tempStr = [NSString stringWithFormat:@"0%@",str];
        }
        resultStr = [NSString stringWithFormat:@"%@%@",resultStr,tempStr];
    }
    
    return [resultStr integerValue];
}


@end
