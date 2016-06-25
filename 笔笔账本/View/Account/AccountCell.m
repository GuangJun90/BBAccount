//
//  AccountCell.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/20.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "AccountCell.h"
@interface AccountCell()
@property (weak, nonatomic) IBOutlet UILabel *objectNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodsNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalPLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@property (weak, nonatomic) IBOutlet UILabel *objectLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalPLbl2;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl2;

@end
@implementation AccountCell

-(void)setAccountModel:(AccountListModel *)accountModel{
    self.objectNameLbl.text = accountModel.objectName;
    self.goodsNameLbl.text = accountModel.goodsName;
    self.goodsNumLbl.text = [NSString stringWithFormat:@"%.1f", accountModel.goodsNum];
    if (accountModel.income) {
        self.totalPLbl.text = [NSString stringWithFormat:@"+%.2f元",accountModel.totalP];
        self.totalPLbl2.text = [NSString stringWithFormat:@"+%.2f元",accountModel.totalP];
        self.totalPLbl.textColor = [UIColor redColor];
        self.totalPLbl2.textColor = [UIColor redColor];
        
    }else{
        self.totalPLbl.text = [NSString stringWithFormat:@"-%.2f元",accountModel.totalP];
        self.totalPLbl2.text = [NSString stringWithFormat:@"-%.2f元",accountModel.totalP];
        self.totalPLbl.textColor = [UIColor blueColor];
        self.totalPLbl2.textColor = [UIColor blueColor];
    }
    self.timeLbl.text = accountModel.time;
    self.timeLbl2.text = accountModel.time;
    self.objectLbl.text = accountModel.object;
}
+(instancetype)theAccountCellWith:(AccountListModel *)accountModel{
    if ([accountModel.goodsName isEqualToString:@""]) {
        return [[NSBundle mainBundle] loadNibNamed:@"AccountCell" owner:nil options:nil][1];
    }else{
        return [[NSBundle mainBundle] loadNibNamed:@"AccountCell" owner:nil options:nil][0];
    }
}

- (void)awakeFromNib {
    self.backgroundColor = [UIColor colorWithHexString:ViewBgColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
