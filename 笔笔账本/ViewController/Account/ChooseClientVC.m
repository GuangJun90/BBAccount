//
//  ChooseClientVC.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/21.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "ChooseClientVC.h"

#import "ClientsViewModel.h"
#import "ChineseContenr.h"


#import "ChooseObjectCell.h"
#import "MetaDataView.h"
@interface ChooseClientVC ()<UITableViewDataSource, UITableViewDelegate>

//metaDataView
@property (nonatomic, strong) MetaDataView *metaDataView;

/** clientVM */
@property(nonatomic,strong) ClientsViewModel *clientsVM;

/** mainTableView 数据 */
@property(nonatomic,strong) NSMutableArray *mainArray;
/** subTableView数据 */
@property(nonatomic,strong) NSMutableArray *subArray;

@end

@implementation ChooseClientVC
#pragma mark - ******** 懒加载 ********
-(ClientsViewModel *)clientsVM{
    if (!_clientsVM) {
        _clientsVM = [ClientsViewModel new];
    }
    return _clientsVM;
}

#pragma mark - ******** 生命周期 ********
- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainArray = [ChineseContenr IndexArray:[self.clientsVM getClientsNameArray]];
    self.subArray = [ChineseContenr LetterSortCustomerManageModel:self.clientsVM.clientsArr];
    
    //设置弹出控制器的大小
    self.preferredContentSize = CGSizeMake(180, 250);
    //添加TRMetaDataView
    [self addMetaDataView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - 添加MetaDataView
- (void)addMetaDataView {
    
    //添加TRMetaDataView视图
    self.metaDataView = [MetaDataView getMetaDataView];
    
    //设置添加的view的frame为视图控制器的bounds
    _metaDataView.frame = self.view.bounds;
    
    //设置两个tableView代理
    _metaDataView.mainTableView.dataSource = self;
    _metaDataView.mainTableView.delegate = self;
    _metaDataView.subTablewView.dataSource = self;
    _metaDataView.subTablewView.delegate = self;
    
    //添加
    [self.view addSubview:_metaDataView];
    
}
#pragma mark -- tableViewDataSoure/Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _metaDataView.mainTableView) {
        return self.mainArray.count;
    } else {
        NSInteger leftRow = [_metaDataView.mainTableView indexPathForSelectedRow].row;
        return [self.subArray[leftRow] count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _metaDataView.mainTableView) {
        ChooseObjectCell *cell = [ChooseObjectCell cellWithTableView:tableView withImageName:@"bg_dropdown_leftpart" withSelectedImageName:@"bg_dropdown_left_selected"];
    cell.textLabel.text = self.mainArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else {
        NSInteger selectedRow = [_metaDataView.mainTableView indexPathForSelectedRow].row;
        
        ChooseObjectCell *cell = [ChooseObjectCell cellWithTableView:tableView withImageName:@"bg_dropdown_rightpart" withSelectedImageName:@"bg_dropdown_right_selected"];
        //设置cell
        ClientsModel *model = self.subArray[selectedRow][indexPath.row];
        cell.textLabel.text = model.name;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.metaDataView.mainTableView) {
        [self.metaDataView.subTablewView reloadData];
    }else{
        //发送通知(左边分类; 右边的子分类)
        //左边选中的行
        NSInteger leftRow = [_metaDataView.mainTableView indexPathForSelectedRow].row;
        //右边选中的行
        NSInteger rightRow = [_metaDataView.subTablewView indexPathForSelectedRow].row;
        ClientsModel *model = self.subArray[leftRow][rightRow];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChooseClients object:nil userInfo:@{@"ClientsModel":model}];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
