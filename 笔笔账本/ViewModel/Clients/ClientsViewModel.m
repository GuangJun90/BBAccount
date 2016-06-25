//
//  ClientsViewModel.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/15.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "ClientsViewModel.h"

@implementation ClientsViewModel
-(NSArray<ClientsModel *> *)clientsArr{
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
        FMResultSet *resultSet = [database executeQuery:@"select * from clients"];
        while ([resultSet next]) {
            ClientsModel *clientsModel = [self modelWith:resultSet];
            [mutArray addObject:clientsModel];
        }
    }
    [database close];
    return [mutArray copy];
    
}
/** 解析数据库数据到模型 */
-(ClientsModel *)modelWith:(FMResultSet *)resultSet{
    ClientsModel *clientsModel = [ClientsModel new];
    clientsModel.name = [resultSet stringForColumn:@"name"];
    clientsModel.Img = [resultSet dataForColumn:@"Img"];
    clientsModel.address = [resultSet stringForColumn:@"address"];
    clientsModel.phone = [resultSet stringForColumn:@"phone"];
    clientsModel.ID = [resultSet intForColumn:@"id"];
    return clientsModel;
}
+(void)saveModelToSQLWith:(ClientsModel *)clientsModel{
    //1.创建数据库(xx/Documents/fmdb.db)
    NSString *documentPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbFilePath=[documentPath stringByAppendingPathComponent:@"SQL.db"];
    //仅仅是创建fmdb.db文件,并没有打开
    FMDatabase *database=[FMDatabase databaseWithPath:dbFilePath];
    if ([database open]) {
        BOOL isSucess = [database executeUpdate:@"create table if not exists clients (id integer primary key, name text,  Img blob, address text, phone text)"];
        if (!isSucess) {
            DLog(@"------创建表失败:%@",database.lastError);
        }
    }
    
    BOOL isSucess=[database executeUpdate:@"insert into clients (name, Img, address, phone) values (?,?,?,?)",clientsModel.name, clientsModel.Img, clientsModel.address, clientsModel.phone];
    
    if (!isSucess) {
        NSLog(@"---插入数据失败:%@",database.lastError);
    }
    [database close];
}


-(NSArray *)getClientsNameArray{
    NSArray<ClientsModel *> *arr = [self clientsArr];
    NSMutableArray *mutableArr = [NSMutableArray array];
    if (arr.count == 0) {
        return nil;
    }
    for (ClientsModel *model in arr) {
        [mutableArr addObject:model.name];
    }
    return [mutableArr copy];
}


@end
