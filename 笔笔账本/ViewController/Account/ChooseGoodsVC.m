//
//  ChooseGoodsVC.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/21.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "ChooseGoodsVC.h"
#import "GoodsCategoryViewModel.h"
#import "GoodsViewModel.h"
#import "ChooseObjectCell.h"
#import "MetaDataView.h"
@interface ChooseGoodsVC ()<UITableViewDataSource, UITableViewDelegate>
//metaDataView
@property (nonatomic, strong) MetaDataView *metaDataView;

/** goodsVM */
@property(nonatomic,strong) GoodsViewModel *goodsVM;
/** goodsCategoryVm */
@property(nonatomic,strong) GoodsCategoryViewModel *goodsCategoryVM;

/** mainTableView 数据 */
@property(nonatomic,strong) NSMutableArray *mainArray;
/** subTableView数据 */
@property(nonatomic,strong) NSMutableArray *subArray;


@end

@implementation ChooseGoodsVC
#pragma mark - ******** 懒加载 ********
-(GoodsViewModel *)goodsVM{
    if (!_goodsVM) {
        _goodsVM = [GoodsViewModel new];
    }
    return _goodsVM;
}
-(GoodsCategoryViewModel *)goodsCategoryVM{
    if (!_goodsCategoryVM) {
        _goodsCategoryVM = [GoodsCategoryViewModel new];
    }
    return _goodsCategoryVM;
}

#pragma mark - ******** 生命周期 ********
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置弹出控制器的大小
    self.preferredContentSize = CGSizeMake(180, 300);
    self.mainArray = [self.goodsCategoryVM.goodsCategoryArray copy];
    
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
        //左边选中的行
        NSInteger leftRow = [_metaDataView.mainTableView indexPathForSelectedRow].row;
        return [self.goodsVM goodsArrayWithCategory:self.goodsCategoryVM.goodsCategoryArray[leftRow]].count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _metaDataView.mainTableView) {
        ChooseObjectCell *cell = [ChooseObjectCell cellWithTableView:tableView withImageName:@"bg_dropdown_leftpart" withSelectedImageName:@"bg_dropdown_left_selected"];
        cell.textLabel.text = self.goodsCategoryVM.goodsCategoryArray[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else {
        NSInteger selectedRow = [_metaDataView.mainTableView indexPathForSelectedRow].row;
        
        ChooseObjectCell *cell = [ChooseObjectCell cellWithTableView:tableView withImageName:@"bg_dropdown_rightpart" withSelectedImageName:@"bg_dropdown_right_selected"];
        

        cell.textLabel.text = [self.goodsVM goodsArrayWithCategory:self.goodsCategoryVM.goodsCategoryArray[selectedRow]][indexPath.row].name;

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
        GoodsModel *model = [self.goodsVM goodsArrayWithCategory:self.goodsCategoryVM.goodsCategoryArray[leftRow]][rightRow];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChooseGoods object:nil userInfo:@{@"GoodsModel":model}];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
