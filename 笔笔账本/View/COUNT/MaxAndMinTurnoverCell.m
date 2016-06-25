//
//  MaxAndMinTurnoverCell.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/23.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "MaxAndMinTurnoverCell.h"

@interface MaxAndMinTurnoverCell()
@property (weak, nonatomic) IBOutlet UILabel *maxTurnoverLbl;
@property (weak, nonatomic) IBOutlet UILabel *minTurnoverLbl;
@property (weak, nonatomic) IBOutlet UILabel *maxDateLbl;

@property (weak, nonatomic) IBOutlet UILabel *minDateLbl;

/** accounDailyVM */
@property(nonatomic,strong) AccountDailyViewModel *accountDailyVM;

@end


@implementation MaxAndMinTurnoverCell

-(AccountDailyViewModel *)accountDailyVM{
    if (!_accountDailyVM) {
        _accountDailyVM = [AccountDailyViewModel new];
    }
    return _accountDailyVM;
}

-(void)setViewDataWithArray:(NSArray<AccountDailyModel *> *)arr{
    if (arr.count == 0) {
        self.maxTurnoverLbl.text = @"";
        self.minTurnoverLbl.text = @"";
        self.maxDateLbl.hidden = YES;
        self.minDateLbl.hidden = YES;
    }else if (arr.count == 1){
        self.maxTurnoverLbl.text = [NSString stringWithFormat:@"%.0f元",[self.accountDailyVM theMaxTurnoverWith:arr]];
        self.minTurnoverLbl.hidden = YES;
        self.maxDateLbl.text = [self.accountDailyVM theMaxTurnoverDateWith:arr];
        self.minDateLbl.hidden = YES;
    }else{
        self.maxTurnoverLbl.text = [NSString stringWithFormat:@"%.0f元",[self.accountDailyVM theMaxTurnoverWith:arr]];
        self.minTurnoverLbl.text = [NSString stringWithFormat:@"%.0f元",[self.accountDailyVM theMinTurnoverWith:arr]];
        self.maxDateLbl.text = [self.accountDailyVM theMaxTurnoverDateWith:arr];
        self.minDateLbl.text = [self.accountDailyVM theMinTurnoverDateWith:arr];
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
