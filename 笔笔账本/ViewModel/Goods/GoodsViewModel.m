//
//  GoodsViewModel.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/6.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "GoodsViewModel.h"

@implementation GoodsViewModel
-(NSArray<GoodsModel *> *)goodsArray{
    NSString *documentPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbFilePath=[documentPath stringByAppendingPathComponent:@"SQL.db"];
    NSFileManager *fileMger = [NSFileManager defaultManager];
    //如果文件路径存在的话
    BOOL bRet = [fileMger fileExistsAtPath:dbFilePath];
    if (!bRet) {
        return nil;
    }
    //仅仅是创建fmdb.db文件,并没有打开
    FMDatabase *database=[FMDatabase databaseWithPath:dbFilePath];
    NSMutableArray *mutArray = [NSMutableArray array];
    if ([database open]) {
        FMResultSet *resultSet = [database executeQuery:@"select * from goods"];
        while ([resultSet next]) {
            GoodsModel *goodsModel = [self modelWith:resultSet];
            
            [mutArray addObject:goodsModel];
        }
    }
    [database close];
    return [mutArray copy];
}

/** 根据货物分类返回货物的数组 */

-(NSArray<GoodsModel *> *)goodsArrayWithCategory:(NSString *)category{
    NSString *documentPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbFilePath=[documentPath stringByAppendingPathComponent:@"SQL.db"];
    NSFileManager *fileMger = [NSFileManager defaultManager];
    //如果文件路径存在的话
    BOOL bRet = [fileMger fileExistsAtPath:dbFilePath];
    if (!bRet) {
        return nil;
    }
    //仅仅是创建fmdb.db文件,并没有打开
    FMDatabase *database=[FMDatabase databaseWithPath:dbFilePath];
    NSMutableArray *mutArray = [NSMutableArray array];
    NSString *selectStr = [NSString stringWithFormat:@"select * from goods where category='%@'",category];
//    DLog(@"%@",selectStr);
    
    if ([database open]) {
        FMResultSet *resultSet = [database executeQuery:selectStr];
        while ([resultSet next]) {
            GoodsModel *goodsModel = [self modelWith:resultSet];
            [mutArray addObject:goodsModel];
        }
    }
    return [mutArray copy];
}


/** 解析数据库数据到模型 */
-(GoodsModel *)modelWith:(FMResultSet *)resultSet{
    GoodsModel *goodsModel = [GoodsModel new];
    goodsModel.name = [resultSet stringForColumn:@"name"];
    goodsModel.Img = [resultSet dataForColumn:@"Img"];
    goodsModel.ID = [resultSet intForColumn:@"goodsID"];
    goodsModel.purchase = [resultSet doubleForColumn:@"purchase"];
    goodsModel.retail = [resultSet doubleForColumn:@"retail"];
    goodsModel.trade = [resultSet doubleForColumn:@"trade"];
    goodsModel.stock = [resultSet doubleForColumn:@"stock"];
    goodsModel.category = [resultSet stringForColumn:@"category"];
    goodsModel.warning = [resultSet intForColumn:@"isWarning"];
    goodsModel.upperLimit = [resultSet doubleForColumn:@"upperLimit"];
    goodsModel.lowLimit = [resultSet doubleForColumn:@"lowlimit"];
    goodsModel.goodsID = [resultSet intForColumn:@"id"];
    
    return goodsModel;
}

+(void)saveModelToSQLWith:(GoodsModel *)goodsModel{
    //1.创建数据库(xx/Documents/fmdb.db)
    NSString *documentPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbFilePath=[documentPath stringByAppendingPathComponent:@"SQL.db"];
    //仅仅是创建fmdb.db文件,并没有打开
    FMDatabase *database=[FMDatabase databaseWithPath:dbFilePath];
    if ([database open]) {
        BOOL isSucess = [database executeUpdate:@"create table if not exists goods (id integer primary key, name text, goodsID integer, Img blob, purchase real, retail real, trade real, stock real, category text, isWarning integer, upperLimit real, lowLimit real)"];
        if (!isSucess) {
            DLog(@"------创建表失败:%@",database.lastError);
        }
    }

    BOOL isSucess=[database executeUpdate:@"insert into goods (name,goodsID, Img, purchase, retail, trade, stock, category, isWarning, upperLimit, lowLimit) values (?,?,?,?,?,?,?,?,?,?,?)",goodsModel.name, @(goodsModel.ID), goodsModel.Img, @(goodsModel.purchase), @(goodsModel.retail), @(goodsModel.trade), @(goodsModel.stock), goodsModel.category, @(goodsModel.isWarning), @(goodsModel.upperLimit), @(goodsModel.lowLimit)];
    
    if (!isSucess) {
        NSLog(@"---插入数据失败:%@",database.lastError);
    }
    [database close];
}

+(void)changeModelToSQLWith:(GoodsModel *)goodsModel{
    NSString *documentPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbFilePath=[documentPath stringByAppendingPathComponent:@"SQL.db"];
    NSFileManager *fileMger = [NSFileManager defaultManager];
    //如果文件路径存在的话
    BOOL bRet = [fileMger fileExistsAtPath:dbFilePath];
    if (!bRet) {
        return;
    }
    NSString *changeStr = [NSString stringWithFormat:@"update goods set stock=%f where id='%ld'",goodsModel.stock,(long)goodsModel.goodsID];
    
    //仅仅是创建fmdb.db文件,并没有打开
    FMDatabase *database=[FMDatabase databaseWithPath:dbFilePath];
    if ([database open]) {
        BOOL isSucess = [database executeUpdate:changeStr];
        if (!isSucess) {
            DLog(@"------修改表失败:%@",database.lastError);
        }
    }
    [database close];
}




@end
