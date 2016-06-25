//
//  GoodsCategoryViewModel.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/4.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "GoodsCategoryViewModel.h"

@implementation GoodsCategoryViewModel
-(NSArray *)goodsCategoryArray{
    //清除plist文件，可以根据我上面讲的方式进去本地查看plist文件是否被清除
    NSFileManager *fileMger = [NSFileManager defaultManager];
    
    // 生成保存数据的plist文件路径
   NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"GoodsCategory.plist"];
    
    //如果文件路径存在的话
    BOOL bRet = [fileMger fileExistsAtPath:filePath];
    if (!bRet) {
        NSArray *arr = @[@"默认分类"];
        [arr writeToFile:filePath atomically:YES];
    }
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    return arr;
}

-(void)refreshGoodsCategoryWithArray:(NSArray *)array{
    //清除plist文件，可以根据我上面讲的方式进去本地查看plist文件是否被清除
    NSFileManager *fileMger = [NSFileManager defaultManager];
    
    // 生成保存数据的plist文件路径
       NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"GoodsCategory.plist"];
    
    //如果文件路径存在的话
    BOOL bRet = [fileMger fileExistsAtPath:filePath];
    
    if (bRet) {
        NSError *err;
        [fileMger removeItemAtPath:filePath error:&err];
    }
    [array writeToFile:filePath atomically:YES];
}

@end
