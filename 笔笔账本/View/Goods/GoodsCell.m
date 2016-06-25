//
//  GoodsCell.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/6.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "GoodsCell.h"

@interface GoodsCell()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsStock;

- (IBAction)StepperValueChange:(UIStepper *)sender;

@end


@implementation GoodsCell

-(void)setGoodsModel:(GoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    self.goodsImg.image = [UIImage imageWithData:self.goodsModel.Img];
    [self.goodsImg setRoundLayer];
    
    self.goodsName.text = self.goodsModel.name;
    self.goodsStock.text = [NSString stringWithFormat:@"%.1f", self.goodsModel.stock];
}

- (IBAction)StepperValueChange:(UIStepper *)sender {
    
    self.goodsStock.text = [NSString stringWithFormat:@"%.1f",self.goodsModel.stock + sender.value];
    
    if ([self.delegate respondsToSelector:@selector(goodsCellStepperClicked:)]) {
        self.goodsModel.stock += sender.value;
        [self.delegate goodsCellStepperClicked:self.goodsModel];
        self.goodsModel.stock -= sender.value;
    }
}
@end
