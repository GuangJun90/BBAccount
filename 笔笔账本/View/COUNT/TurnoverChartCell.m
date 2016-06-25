//
//  TurnoverChartCell.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/23.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "TurnoverChartCell.h"
#import "UUChart.h"


@interface TurnoverChartCell()<UUChartDataSource>
{
    NSIndexPath *path;
    UUChart *chartView;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *maxTurnoverlbl;
@property (weak, nonatomic) IBOutlet UILabel *minTurnoverLbl;
@property (weak, nonatomic) IBOutlet UILabel *quarterTurnoverLbl;
@property (weak, nonatomic) IBOutlet UILabel *halfTurnoverLbl;
@property (weak, nonatomic) IBOutlet UILabel *three_fourthsLbl;
@property (weak, nonatomic) IBOutlet UILabel *yuanLbl;
@property (weak, nonatomic) IBOutlet UILabel *noDataLbl;


/** accounDailyVM */
@property(nonatomic,strong) AccountDailyViewModel *accountDailyVM;

@end
@implementation TurnoverChartCell
-(AccountDailyViewModel *)accountDailyVM{
    if (!_accountDailyVM) {
        _accountDailyVM = [AccountDailyViewModel new];
    }
    return _accountDailyVM;
}

- (void)awakeFromNib {
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
-(void)setViewDataWithArray:(NSArray<AccountDailyModel *> *)arr{
    self.accountArray = arr;
    float max = [self.accountDailyVM theMaxTurnoverWith:self.accountArray] * 1.2;
    float min = [self.accountDailyVM theMinTurnoverWith:self.accountArray];
    if (max == min) {
        self.maxTurnoverlbl.text = [NSString stringWithFormat:@"%.0f",max];
        self.minTurnoverLbl.text = @"0";
        self.quarterTurnoverLbl.text = [NSString stringWithFormat:@"%.0f",max /4.0 ];
        self.halfTurnoverLbl.text = [NSString stringWithFormat:@"%.0f",max /2.0];
        self.three_fourthsLbl.text = [NSString stringWithFormat:@"%.0f",max /4.0 * 3];
    }else{
        self.maxTurnoverlbl.text = [NSString stringWithFormat:@"%.0f",max];
        self.minTurnoverLbl.text = [NSString stringWithFormat:@"%.0f",min];
        self.quarterTurnoverLbl.text = [NSString stringWithFormat:@"%.0f",(max - min)/4.0 + min];
        self.halfTurnoverLbl.text = [NSString stringWithFormat:@"%.0f",(max - min)/2.0];
        self.three_fourthsLbl.text = [NSString stringWithFormat:@"%.0f",(max - min)/4.0 * 3 + min];
    }
    [chartView removeFromSuperview];
    if (arr.count == 0) {
        self.scrollView.hidden = YES;
        self.noDataLbl.hidden = NO;
        self.yuanLbl.hidden = YES;
        self.maxTurnoverlbl.hidden = YES;
        self.minTurnoverLbl.hidden = YES;
        self.quarterTurnoverLbl.hidden = YES;
        self.halfTurnoverLbl.hidden = YES;
        self.three_fourthsLbl.hidden = YES;
        
        return;
    }else{
        self.scrollView.hidden = NO;
        self.noDataLbl.hidden = YES;
        self.yuanLbl.hidden = NO;
        self.maxTurnoverlbl.hidden = NO;
        self.minTurnoverLbl.hidden = NO;
        self.quarterTurnoverLbl.hidden = NO;
        self.halfTurnoverLbl.hidden = NO;
        self.three_fourthsLbl.hidden = NO;
    }
    CGFloat width = self.scrollView.frame.size.width/7*self.accountArray.count;
    chartView = [[UUChart alloc] initWithFrame:CGRectMake(0, 5,width , 175) dataSource:self style:UUChartStyleLine];
    [chartView showInView:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth/8*arr.count, self.scrollView.bounds.size.height-10);
    [chartView strokeChart];
    
}
//- (void)createUUChart{
//    chartView = [[UUChart alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth/8*self.accountArray.count-kScreenWidth/16+10, 150) dataSource:self style:UUChartStyleLine];
//    
//    [chartView showInView:self.scrollView];
//}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)chartConfigAxisXLabel:(UUChart *)chart
{
    
    return [self.accountDailyVM theDateArrayWith:self.accountArray];
}
//数值多重数组
- (NSArray *)chartConfigAxisYValue:(UUChart *)chart
{
    NSArray *arr = [self.accountDailyVM theTurnoverArrayWith:self.accountArray];
    return @[arr];
//    return @[@[@"20"]];
}

//判断显示横线条
- (BOOL)chart:(UUChart *)chart showHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}


#pragma mark - @optional
//颜色数组
- (NSArray *)chartConfigColors:(UUChart *)chart
{
    UIColor *color = [UIColor colorWithHexString:NomalBlueTextFontColor];
    
    return @[color,color,color];
}
//显示数值范围
- (CGRange)chartRange:(UUChart *)chart{
    float max = [self.accountDailyVM theMaxTurnoverWith:self.accountArray];
    float min = [self.accountDailyVM theMinTurnoverWith:self.accountArray];
    if (max == min) {
        return CGRangeMake(max * 1.2, 0);
    }
    
    return CGRangeMake(max * 1.2, min);
}


#pragma mark 折线图专享功能

//标记数值区域
- (CGRange)UUChartMarkRangeInLineChart:(UUChart *)chart
{
    
    return CGRangeMake(0, 0);
}

//判断显示横线条
- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断显示最大最小值
- (BOOL)UUChart:(UUChart *)chart ShowMaxMinAtIndex:(NSInteger)index
{
    return YES;
}



+ (CGFloat)getTableViewHeight:(id)sender{
    return 250;
}

@end
