//
//  CountChartVC.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/22.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "CountChartVC.h"

#import "AccountDailyViewModel.h"
#import <RESideMenu.h>

#import "StatisticsFormChooseTimeCell.h"
#import "TurnoverChartCell.h"
#import "MaxAndMinTurnoverCell.h"
#import "AccountTotalDataCell.h"

#import "ChooseTimeController.h"
#import "NSString+QHNSStringCtg.h"
#import "QHUtilAss.h"

static NSString * const kChooseTimeIdentifierID = @"chooseTimeCell";
static NSString * const kTurnoverChartIdentifierID = @"turnoverChartCell";
static NSString * const kMaxMinTurnoverIdentifierID = @"maxMinTurnoverCell";
static NSString * const kTotalDataIdentifierID = @"totalDataCell";

@interface CountChartVC ()<UITableViewDataSource,UITableViewDelegate>
/** tableView */
@property(nonatomic,strong) UITableView *tableView;
/** 开始时间 */
@property(nonatomic,strong) NSString *startTimeStr;
/** 结束时间 */
@property(nonatomic,strong) NSString *endTimeStr;
/** 标题显示的时间 */
@property(nonatomic,strong) NSString *timeTitleStr;

/** accountDailyVM */
@property(nonatomic,strong) AccountDailyViewModel *accountDailyVM;

/** 某段时间的数据 */
@property(nonatomic,strong) NSArray<AccountDailyModel *> *accountDailyArray;

@end

@implementation CountChartVC
#pragma mark - ******** 懒加载 ********
-(AccountDailyViewModel *)accountDailyVM
{
    if (!_accountDailyVM) {
        _accountDailyVM = [AccountDailyViewModel new];
    }
    return _accountDailyVM;
}

#pragma mark - ******** 初始化 ********
- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"StatisticsFormChooseTimeCell" bundle:nil] forCellReuseIdentifier:kChooseTimeIdentifierID];
    [_tableView registerNib:[UINib nibWithNibName:@"TurnoverChartCell" bundle:nil] forCellReuseIdentifier:kTurnoverChartIdentifierID];
    [_tableView registerNib:[UINib nibWithNibName:@"MaxAndMinTurnoverCell" bundle:nil] forCellReuseIdentifier:kMaxMinTurnoverIdentifierID];
    [_tableView registerNib:[UINib nibWithNibName:@"AccountTotalDataCell" bundle:nil] forCellReuseIdentifier:kTotalDataIdentifierID];
}
/** 过去7天 */
- (void)lastSevenDay
{
    //今天
    NSString *timeStr = [NSString dateFromeString:[NSDate date]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    //过去7天
    NSTimeInterval  oneDay = -24*60*60*1;
    NSDate  *sevenDaysTime = [date initWithTimeInterval:oneDay*7 sinceDate:date];
    NSDictionary *sevendayageDic = [QHUtilAss getTodayBeforeSevenDaysTime:sevenDaysTime];
    
    NSString *sevenDaysOne = [NSString getMouthMMdd:[NSString stringWithFormat:@"%@",[sevendayageDic objectForKey:@"starTime"]]];
    NSString *sevenDaysSeven = [NSString getMouthMMdd:[NSString stringWithFormat:@"%@",[sevendayageDic objectForKey:@"endTime"]]];
    
    self.timeTitleStr = [NSString stringWithFormat:@"过去7天(%@-%@)",sevenDaysOne,sevenDaysSeven];
    self.startTimeStr = [self handleTimeStr:[NSString stringWithFormat:@"%@",[sevendayageDic objectForKey:@"starTime"]]];
    self.endTimeStr = [self handleTimeStr:[NSString stringWithFormat:@"%@",[sevendayageDic objectForKey:@"endTime"]]];
}
- (void)loadData{
    self.accountDailyArray = [self.accountDailyVM getAccountDailyModelArrayFrom:self.startTimeStr To:self.endTimeStr];
    [self.tableView reloadData];
}

#pragma mark - ******** 生命周期 ********
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"统计报表";
    //tableView config
    [self createTableView];
    //过去7天
    [self lastSevenDay];
    //加载数据
    [self loadData];
    [self addBarItems];
    
}


#pragma mark - ******** 私有方法 ********
- (void)addBarItems {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_home_home_pro"] style:UIBarButtonItemStylePlain target:self action:@selector(menu)];
    //由于左边的item离屏幕左边缘太远,所以加以调整
    //    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    spaceItem.width = 15;
    //    self.navigationItem.leftBarButtonItems = @[spaceItem, backItem];
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)menu {
    [self.sideMenuViewController presentLeftMenuViewController];
}

#pragma mark - ******** tableView delegate ********
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return [StatisticsFormChooseTimeCell getTableViewHeight:nil];
    }else if (indexPath.section == 1){
        return [TurnoverChartCell getTableViewHeight:nil];
    }else if (indexPath.section == 2){
        return [MaxAndMinTurnoverCell getTableViewHeight:nil];
    }else{
        return [AccountTotalDataCell getTableViewHeight:nil];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 0.01;
    }
    return 17;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        StatisticsFormChooseTimeCell *cell = [_tableView dequeueReusableCellWithIdentifier:kChooseTimeIdentifierID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.timeSelectLabel.text = _timeTitleStr;
        return cell;
    }else if (indexPath.section == 1){
        TurnoverChartCell *cell = [_tableView dequeueReusableCellWithIdentifier:kTurnoverChartIdentifierID];
        [cell setViewDataWithArray:self.accountDailyArray];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2){
        MaxAndMinTurnoverCell *cell = [_tableView dequeueReusableCellWithIdentifier:kMaxMinTurnoverIdentifierID];
        [cell setViewDataWithArray:self.accountDailyArray];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        AccountTotalDataCell *cell = [_tableView dequeueReusableCellWithIdentifier:kTotalDataIdentifierID];
        [cell setViewDataWithArray:self.accountDailyArray];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0)
    {
        __weak __typeof(self)weakSelf = self;
        ChooseTimeController *choose = [[ChooseTimeController alloc] init];
        [choose setChangedate:^(NSDictionary *dicDate) {
            self.timeTitleStr = [dicDate objectForKey:@"backTitle"];
            self.startTimeStr = [weakSelf handleTimeStr:[dicDate objectForKey:@"startTime"]];
            self.endTimeStr =   [weakSelf handleTimeStr:[dicDate objectForKey:@"endTime"]];
            
            [weakSelf loadData];
        }];
        [self.navigationController pushViewController:choose animated:YES];
    }
    
}
- (NSString *)handleTimeStr:(NSString *)timeStr{
    NSString *resultStr = @"";
    NSArray *array = [timeStr componentsSeparatedByString:@"-"];
    for (NSString *  str in array) {
        NSString *tempStr = str;
        if (str.length<4 && str.length == 1) {
            tempStr = [NSString stringWithFormat:@"0%@",str];
        }
        resultStr = [NSString stringWithFormat:@"%@%@",resultStr,tempStr];
    }
    return resultStr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
