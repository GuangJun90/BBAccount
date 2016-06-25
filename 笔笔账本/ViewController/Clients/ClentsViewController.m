//
//  ClentsViewController.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/15.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "ClentsViewController.h"
#import "ClientsViewModel.h"
#import "ChineseContenr.h"
#import "LXActivity.h"
#import <RESideMenu.h>

@interface ClentsViewController ()<UITableViewDelegate,UITableViewDataSource,LXActivityDelegate>
/** 客户姓名列表 */
@property(nonatomic,strong) NSArray *clientsNameArr;
/** 首字母索引 */
@property(nonatomic,strong) NSMutableArray *firstKeyIndexArr;
/** 分好组并排序的数组 */
@property(nonatomic,strong) NSMutableArray *sortArr;
/** vm */
@property(nonatomic,strong) ClientsViewModel *clientsVm;
/** phoneStr */
@property(nonatomic,strong) NSString *phoneStr;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ClentsViewController
#pragma mark - ******** 初始化，懒加载 ********

-(ClientsViewModel *)clientsVm{
    if (!_clientsVm) {
        _clientsVm = [ClientsViewModel new];
    }
    return _clientsVm;
}

#pragma mark - ******** 生命周期 ********
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBarItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [self.tableView reloadData];
//}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.clientsNameArr = [self.clientsVm getClientsNameArray];
    self.firstKeyIndexArr = [ChineseContenr IndexArray:self.clientsNameArr];
    self.sortArr = [ChineseContenr LetterSortCustomerManageModel:self.clientsVm.clientsArr];
    [self.tableView reloadData];
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

#pragma mark - UITableViewDataSource
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.firstKeyIndexArr;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.firstKeyIndexArr[section];
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.firstKeyIndexArr.count;
}
-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [[self.sortArr objectAtIndex:section] count];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
    }
    ClientsModel *model = self.sortArr[indexPath.section][indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    view.backgroundColor = [UIColor colorWithHexString:ViewBgColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 20, 20)];
    label.textColor = [UIColor colorWithHexString:@"A0A0A0"];
    label.font = [UIFont systemFontOfSize:13];
    label.text = [_firstKeyIndexArr objectAtIndex:section];
    [view addSubview:label];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 53;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *titleArrays = @[@"拨打电话",@"发送短信",@"查看订单"];
    NSArray *imageArrays = @[@"ic_deal",@"ic_send",@"ic_searchorder"];
    NSArray *imageHeightLightArrays = @[@"ic_deal_pro",@"ic_send_pro",@"ic_searchorder_pro"];
    ClientsModel *model = self.sortArr[indexPath.section][indexPath.row];
    
    self.phoneStr = model.phone;
    LXActivity *lxActivity = [[LXActivity alloc] initWithTitle:model.name phoneNum:model.phone delegate:self cancelButtonTitle:@"取消" ShareButtonTitles:titleArrays withShareButtonImagesName:imageArrays heightIamgeArray:imageHeightLightArrays];
    [lxActivity showInView:self.view];
}
#pragma mark - LXActivityDelegate
- (void)didClickOnImageIndex:(NSInteger)imageIndex
{
    if(![self.phoneStr isNotBlank])
    {
//        [AFMInfoBanner showAndHideWithText:@"号码不存在" style:AFMInfoBannerStyleError];
        return;
    }
    NSInteger tag = imageIndex;
    switch (tag) {
        case 0:
        {//打电话
            NSMutableString *str1 =[[NSMutableString alloc] initWithFormat:@"tel://%@",_phoneStr];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str1]]];
            [self.view addSubview:callWebview];
            break;
        }
        case 1:
        {//发信息
            NSString *strSms = [NSString stringWithFormat:@"sms://%@",_phoneStr];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:strSms]];
            break;
        }
        case 2:
        {//查看订单
            DLog(@"查看订单");
            
            break;
        }
        default:
            break;
    }
}



@end
