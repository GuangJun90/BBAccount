//
//  SuppliersViewModel.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/16.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "SuppliersViewModel.h"

@implementation SuppliersViewModel
-(NSArray<SuppliersModel *> *)suppliersArr{
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
        FMResultSet *resultSet = [database executeQuery:@"select * from suppliers"];
        while ([resultSet next]) {
            SuppliersModel *suppliers = [self modelWith:resultSet];
            [mutArray addObject:suppliers];
        }
    }
    [database close];
    return [mutArray copy];
}
- (SuppliersModel *)modelWith:(FMResultSet *)resultSet{
    SuppliersModel *model = [SuppliersModel new];
    model.name = [resultSet stringForColumn:@"name"];
    model.Img = [resultSet dataForColumn:@"Img"];
    model.address = [resultSet stringForColumn:@"address"];
    model.phone = [resultSet stringForColumn:@"phone"];
    model.ID = [resultSet intForColumn:@"id"];
    return model;
    
}
+(void)saveModelToSQLWith:(SuppliersModel *)clientsModel{
    //1.创建数据库(xx/Documents/fmdb.db)
    NSString *documentPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbFilePath=[documentPath stringByAppendingPathComponent:@"SQL.db"];
    //仅仅是创建fmdb.db文件,并没有打开
    FMDatabase *database=[FMDatabase databaseWithPath:dbFilePath];
    if ([database open]) {
        BOOL isSucess = [database executeUpdate:@"create table if not exists suppliers (id integer primary key, name text,  Img blob, address text, phone text)"];
        if (!isSucess) {
            DLog(@"------创建表失败:%@",database.lastError);
        }
    }
    
    BOOL isSucess=[database executeUpdate:@"insert into suppliers (name, Img, address, phone) values (?,?,?,?)",clientsModel.name, clientsModel.Img, clientsModel.address, clientsModel.phone];
    
    if (!isSucess) {
        NSLog(@"---插入数据失败:%@",database.lastError);
    }
    [database close];
}

-(NSArray *)getSuppliersNameArray{
    NSArray<SuppliersModel *> *arr = [self suppliersArr];
    NSMutableArray *mutableArr = [NSMutableArray array];
    if (arr.count == 0) {
        return nil;
    }
    for (SuppliersModel *model in arr) {
        [mutableArr addObject:model.name];
    }
    return [mutableArr copy];
}


@end
