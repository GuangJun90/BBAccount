//
//  UIImageView+RoundImageView.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/13.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "UIImageView+RoundImageView.h"

@implementation UIImageView (RoundImageView)
-(void)setRoundLayer{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor greenColor].CGColor;
}
@end
