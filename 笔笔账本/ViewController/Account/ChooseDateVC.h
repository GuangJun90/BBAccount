//
//  ChooseDateVC.h
//  笔笔账本
//
//  Created by com.sheng on 16/6/18.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseDateVC : UIViewController

@property (nonatomic,strong) void(^ changedate)(NSDictionary *dicDate);

- (void)setChangedate:(void (^)(NSDictionary *dicDate))changedate;



@end
