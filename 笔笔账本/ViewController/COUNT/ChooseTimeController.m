//
//  ChooseTimeController.m
//  ELuYunApp
//
//  Created by apple on 16/3/31.
//  Copyright © 2016年 zhaoguodong. All rights reserved.
//

#import "ChooseTimeController.h"
#import "CT_TimeSelectCell.h"
#import "CT_OtherTimeCell.h"
#import "TimeArray.h"
#import "NSString+QHNSStringCtg.h"

//时间选择器
#import "UWDatePickerView.h"

//#import <AFMInfoBanner.h>
//#import "DDLoadingAnimation.h"


static NSString * const kTimeSelectIdentifierID = @"timeSelectCell";
static NSString * const kOtherTimeIdentifierID = @"otherTimeCell";
@interface ChooseTimeController ()<UITableViewDataSource,UITableViewDelegate,UWDatePickerViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_timeArray;    //时间日期数组
    UWDatePickerView *_dataPikerView;//时间选择器
    CT_TimeSelectCell *_selectCell;
    
    BOOL _isSelected;      //是否选中
    NSMutableDictionary *_otherTimeDic;  //自定义时间字典
    NSInteger _selectedIndex;   //被选中的下标
}

@end

@implementation ChooseTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [super instaceNavigationBarTitle:@"时间选择" andReturnText:@"统计报表"];
    
    self.title = @"时间选择";
    _timeArray = [TimeArray getTimeArray];
    _otherTimeDic = [@{@"startTime":@"开始时间",@"endTime":@"结束时间",@"startDate":@"",@"endDate":@"",@"title":@"其他"} mutableCopy];
    _isSelected = NO;
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
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishBtnClick:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}
- (void)finishBtnClick:(id)sender
{
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
                [dicT setValue:[NSString stringWithFormat:@"上周(%@-%@)",[dicT valueForKey:@"startDate"],[dicT valueForKey:@"endDate"]] forKey:@"backTitle"];
                break;
            case 3:
                dicT = _timeArray[3];
                [dicT setValue:[NSString stringWithFormat:@"上月(%@-%@)",[dicT valueForKey:@"startDate"],[dicT valueForKey:@"endDate"]] forKey:@"backTitle"];
                break;
            case 4:
                dicT = _timeArray[4];
                [dicT setValue:[NSString stringWithFormat:@"本周(%@-%@)",[dicT valueForKey:@"startDate"],[dicT valueForKey:@"endDate"]] forKey:@"backTitle"];
                break;
            case 5:
                dicT = _timeArray[5];
                [dicT setValue:[NSString stringWithFormat:@"本月(%@-%@)",[dicT valueForKey:@"startDate"],[dicT valueForKey:@"endDate"]] forKey:@"backTitle"];
                break;
            case 6:
                dicT = _timeArray[6];
                [dicT setValue:[NSString stringWithFormat:@"过去7天(%@-%@)",[dicT valueForKey:@"startDate"],[dicT valueForKey:@"endDate"]] forKey:@"backTitle"];
                break;
            case 7:
                dicT = _timeArray[7];
                [dicT setValue:[NSString stringWithFormat:@"过去30天(%@-%@)",[dicT valueForKey:@"startDate"],[dicT valueForKey:@"endDate"]] forKey:@"backTitle"];
                break;
            case 8:
                dicT = _timeArray[9];
                if([[dicT objectForKey:@"startDate"] isEqual:[NSNull null]]||[[dicT objectForKey:@"startDate"] isEqualToString:@""]||[[dicT objectForKey:@"endDate"] isEqual:[NSNull null]]||[[dicT objectForKey:@"endDate"]isEqualToString:@""])
                {
//                    [AFMInfoBanner showAndHideWithText:@"请选择完整时间" style:AFMInfoBannerStyleError];
                    [self.view showWarning:@"请选择完整时间"];
                    return;
                    
                }else
                {
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                    NSDate* sDate = [dateFormatter dateFromString:[dicT objectForKey:@"startTime"]];
                    NSDate* eDate = [dateFormatter dateFromString:[dicT objectForKey:@"endTime"]];
                    if ([sDate compare:eDate]==NSOrderedDescending) {
//                       [AFMInfoBanner showAndHideWithText:@"开始时间不能大于结束时间" style:AFMInfoBannerStyleError];
                        [self.view showWarning:@"开始时间不能大于结束时间"];
                        return;
                    }
                   [dicT setValue:[NSString stringWithFormat:@"其他时间(%@-%@)",[dicT valueForKey:@"startDate"],[dicT valueForKey:@"endDate"]] forKey:@"backTitle"];
                }
                
                break;
                
            default:
                break;
        }
        
        
        self.changedate(dicT);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -懒加载数-
- (NSMutableArray *)timeArray
{
    if(_timeArray == nil)
    {
        _timeArray = [[NSMutableArray alloc] init];
    }
    return _timeArray;
}

#pragma mark -tableView config-
- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"CT_TimeSelectCell" bundle:nil] forCellReuseIdentifier:kTimeSelectIdentifierID];
    [_tableView registerNib:[UINib nibWithNibName:@"CT_OtherTimeCell" bundle:nil] forCellReuseIdentifier:kOtherTimeIdentifierID];
    
    
}

#pragma mark -tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _timeArray.count;
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
    if(indexPath.row != 9)
    {
        CT_TimeSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeSelectIdentifierID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setValueWithArray:_timeArray indexPath:indexPath];
        
        return cell;
    }else
    {
        CT_OtherTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:kOtherTimeIdentifierID forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setValueWithArray:_timeArray indexPath:indexPath];
        [cell.startTimeBtn addTarget:self action:@selector(startTimeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.endTimeBtn addTarget:self action:@selector(endTimeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
      
        return cell;
    }
    
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectedIndex = indexPath.row;
    
    if(indexPath.row != 9)
    {
        CT_TimeSelectCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        _selectCell.selectImage.hidden = YES;
        cell.selectImage.hidden = NO;
        _selectCell = cell;
        _isSelected = NO;
    }
    
    
    if(indexPath.row<=7)
    {
        if (_timeArray.count == 10)
        {
            _isSelected = NO;
            [_timeArray removeObjectAtIndex:9];
            [_tableView reloadData];
            
        }
    }else if(indexPath.row == 8)
    {
        if(_timeArray.count == 9)
        {
            _isSelected = YES;
            [_timeArray addObject:_otherTimeDic];
            [_tableView reloadData];
        }
    }
}

#pragma mark -时间选择按钮-
- (void)startTimeBtnClick:(UIButton *)btt
{
    [self setupDateView:DateTypeOfStart];
}
- (void)endTimeBtnClick:(UIButton *)btt
{
    [self setupDateView:DateTypeOfEnd];
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
 
    switch (type) {
        case DateTypeOfStart:
        {
            NSString *startTime = [NSString getMouthMMdd:date];
            
            [_otherTimeDic setObject:date forKey:@"startTime"];
            [_otherTimeDic setObject:startTime forKey:@"startDate"];
            
            [_tableView beginUpdates];
            
            [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:9 inSection:0]] withRowAnimation:(UITableViewRowAnimationAutomatic)];
            
            [_tableView endUpdates];
            
            break;
        }
        case DateTypeOfEnd:
        {
            NSString *endTime = [NSString getMouthMMdd:date];
            
            [_otherTimeDic setObject:date forKey:@"endTime"];
            [_otherTimeDic setObject:endTime forKey:@"endDate"];
            
            [_tableView beginUpdates];
            
            [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:9 inSection:0]] withRowAnimation:(UITableViewRowAnimationAutomatic)];
            
            [_tableView endUpdates];
            break;
            
        }
    }
    
    
}


//#pragma mark -viewDidAppear-
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    self.hidesBottomBarWhenPushed = YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
