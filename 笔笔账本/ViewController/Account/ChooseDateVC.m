//
//  ChooseDateVC.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/18.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "ChooseDateVC.h"
#import "CT_TimeSelectCell.h"
#import "StatisticsFormChooseTimeCell.h"
#import "TimeArray.h"
#import "NSString+QHNSStringCtg.h"

//时间选择器
#import "UWDatePickerView.h"



static NSString * const kTimeSelectIdentifierID = @"timeSelectCell";
static NSString * const kChooseTimeIdentifierID = @"chooseTimeCell";
@interface ChooseDateVC ()<UITableViewDataSource,UITableViewDelegate,UWDatePickerViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_timeArray;    //时间日期数组
    UWDatePickerView *_dataPikerView;//时间选择器
    CT_TimeSelectCell *_selectCell;
    
//    BOOL _isSelected;      //是否选中
    NSMutableDictionary *_otherTimeDic;  //自定义时间字典
    NSInteger _selectedIndex;   //被选中的下标
}

@end

@implementation ChooseDateVC
#pragma mark - ******** 懒加载 ********
- (NSMutableArray *)timeArray
{
    if(_timeArray == nil)
    {
        _timeArray = [[NSMutableArray alloc] init];
    }
    return _timeArray;
}


#pragma mark - ******** 生命周期 ********

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日期选择";
    _timeArray = [TimeArray getDateArray];
    _otherTimeDic = [@{@"startTime":@"日期选择",@"endTime":@"结束时间",@"startDate":@"",@"endDate":@"",@"title":@"其他"} mutableCopy];
    _selectedIndex = 0;
    
    //导航栏-完成
    [self navigationConfig];
    //tableView config
    [self createTableView];
    
    [_tableView reloadData];
    _selectCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    _selectCell.selectImage.hidden = NO;
}

#pragma mark -导航栏-完成-
- (void)navigationConfig
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回_默认"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    //由于左边的item离屏幕左边缘太远,所以加以调整
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    self.navigationItem.leftBarButtonItems = @[spaceItem, backItem];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishBtnClick:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)finishBtnClick:(id)sender{
    if(self.changedate)
    {
        NSMutableDictionary *dicT;
        switch (_selectedIndex) {
            case 0:
                dicT = _timeArray[0];
                [dicT setValue:[NSString stringWithFormat:@"今天(%@)",[dicT valueForKey:@"startDate"]] forKey:@"backTitle"];
                break;
            case 1:
                dicT = _timeArray[1];
                [dicT setValue:[NSString stringWithFormat:@" 昨天(%@)",[dicT valueForKey:@"startDate"]] forKey:@"backTitle"];
                break;
            case 2:
                dicT = _timeArray[2];
                [dicT setValue:[NSString stringWithFormat:@" 前天(%@)",[dicT valueForKey:@"startDate"]] forKey:@"backTitle"];
                break;
            case 3:
                dicT = _timeArray[3];
                [dicT setValue:[NSString stringWithFormat:@" (%@)",[dicT valueForKey:@"startDate"]] forKey:@"backTitle"];
                break;
                
            default:
                break;
        }
        
        
        self.changedate(dicT);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -tableView config-
- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"CT_TimeSelectCell" bundle:nil] forCellReuseIdentifier:kTimeSelectIdentifierID];
    [_tableView registerNib:[UINib nibWithNibName:@"StatisticsFormChooseTimeCell" bundle:nil] forCellReuseIdentifier:kChooseTimeIdentifierID];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != 3)
    {
        CT_TimeSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeSelectIdentifierID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setValueWithArray:_timeArray indexPath:indexPath];
        
        return cell;
    }else{
        StatisticsFormChooseTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:kChooseTimeIdentifierID forIndexPath:indexPath];
        
        [cell setValueWithArray:_timeArray index:3];
        
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectedIndex = indexPath.row;
    if (indexPath.row != 3) {
        CT_TimeSelectCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        _selectCell.selectImage.hidden = YES;
        cell.selectImage.hidden = NO;
        _selectCell = cell;
        
        StatisticsFormChooseTimeCell *chooseTimecell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        chooseTimecell.selectImage.hidden = YES;
    }else{
        StatisticsFormChooseTimeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selectImage.hidden = NO;
        _selectCell.selectImage.hidden = YES;
        _selectCell = nil;
        
        [self setupDateView:DateTypeOfStart];
        
    }
}
#pragma mark -添加时间选择器-
- (void)setupDateView:(DateType)type {
    
    _dataPikerView= [UWDatePickerView instanceDatePickerView];
    _dataPikerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64.f);
    [_dataPikerView setBackgroundColor:[UIColor clearColor]];
    _dataPikerView.delegate = self;
    _dataPikerView.type = type;
    [self.view addSubview:_dataPikerView];
}

#pragma mark -datePicker delegate-
- (void)getSelectDate:(NSString *)date type:(DateType)type {
    
    if (type == DateTypeOfStart) {
        NSString *dateStr = [NSString getMouthMMdd:date];
        [_otherTimeDic setObject:date forKey:@"startTime"];
        [_otherTimeDic setObject:dateStr forKey:@"startDate"];
        [_timeArray replaceObjectAtIndex:3 withObject:_otherTimeDic];
        [_tableView beginUpdates];
        
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        
        [_tableView endUpdates];
    }
    StatisticsFormChooseTimeCell *chooseTimecell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    chooseTimecell.selectImage.hidden = NO;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
