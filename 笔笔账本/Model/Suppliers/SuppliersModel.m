//
//  SuppliersModel.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/16.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "SuppliersModel.h"

@implementation SuppliersModel
-(NSString *)pinYin{
    if (_name == nil) {
        return nil;
    }
    if (!_pinYin) {
        _pinYin = [self transform:self.name];
    }
    return _pinYin;
}
//汉字转拼音
- (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return [pinyin uppercaseString];
}
@end
