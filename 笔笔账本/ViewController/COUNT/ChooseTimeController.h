//
//  ChooseTimeController.h
//  ELuYunApp
//
//  Created by apple on 16/3/31.
//  Copyright © 2016年 zhaoguodong. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BaseViewController.h"

@interface ChooseTimeController : UIViewController
@property (nonatomic,strong) void(^ changedate)(NSDictionary *dicDate);

- (void)setChangedate:(void (^)(NSDictionary *dicDate))changedate;
@end
