//
//  GoodsCatrgoryCell.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/13.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "GoodsCatrgoryCell.h"

@interface GoodsCatrgoryCell()






@end


@implementation GoodsCatrgoryCell

- (void)awakeFromNib {
    self.categoryNameLbl.text = @"默认分类";

}
//-(void)setOpen:(BOOL)open{
//    [self changeButtonState:open];
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(openButtonClickWith:)]) {
        [self.delegate openButtonClickWith:self];
    }
    self.open = !self.open;
}

-(void)changeButtonState:(BOOL)open{

    if (open) {
        [UIView animateWithDuration:0.3f animations:^{
            
            self.button.transform = CGAffineTransformRotate(self.button.transform, -M_PI/2.0);
//            self.button.transform = CGAffineTransformMakeRotation(-M_PI /2.0)
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:0.3f animations:^{
            
            self.button.transform = CGAffineTransformRotate(self.button.transform, M_PI/2.0);
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

@end
