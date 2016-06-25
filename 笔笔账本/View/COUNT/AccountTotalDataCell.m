//
//  AccountTotalDataCell.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/23.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "AccountTotalDataCell.h"

@interface AccountTotalDataCell()
@property (weak, nonatomic) IBOutlet UILabel *totalTurnoverLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalWaterPLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalElePLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalRentPLbl;
@property (weak, nonatomic) IBOutlet UILabel *otherPLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalGoodsInLbl;

/** accounDailyVM */
@property(nonatomic,strong) AccountDailyViewModel *accountDailyVM;

@end


@implementation AccountTotalDataCell
-(AccountDailyViewModel *)accountDailyVM{
    if (!_accountDailyVM) {
        _accountDailyVM = [AccountDailyViewModel new];
    }
    return _accountDailyVM;
}

-(void)setViewDataWithArray:(NSArray<AccountDailyModel *> *)arr{
    if (arr.count == 0) {
        self.totalTurnoverLbl.text = @"0元";
        self.totalWaterPLbl.text = @"0元";
        self.totalElePLbl.text = @"0元";
        self.totalGoodsInLbl.text = @"0元";
        self.otherPLbl.text = @"0元";
        self.totalRentPLbl.text = @"0元";
        
    }else{
        self.totalTurnoverLbl.text = [NSString stringWithFormat:@"%.0f元",[self.accountDailyVM theTotalTurnoverWith:arr]];
        self.totalWaterPLbl.text = [NSString stringWithFormat:@"%.0f元",[self.accountDailyVM theTotalWaterPWith:arr]];
        self.totalElePLbl.text = [NSString stringWithFormat:@"%.0f元",[self.accountDailyVM theTotalElePWith:arr]];
        self.totalGoodsInLbl.text = [NSString stringWithFormat:@"%.0f元",[self.accountDailyVM theTotalGoodsInPWith:arr]];
        self.otherPLbl.text = [NSString stringWithFormat:@"%.0f元",[self.accountDailyVM theTotalOtherPWith:arr]];
        self.totalRentPLbl.text = [NSString stringWithFormat:@"%.0f元",[self.accountDailyVM theTotalRentPWith:arr]];
    }
    
}
+(CGFloat)getTableViewHeight:(id)sender{
    return 120;
}






- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
