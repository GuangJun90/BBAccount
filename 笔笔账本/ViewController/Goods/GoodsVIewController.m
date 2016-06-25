//
//  GoodsVIewController.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/13.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "GoodsVIewController.h"
#import "GoodsCategoryViewModel.h"
#import "GoodsViewModel.h"
#import "GoodsCell.h"
#import "GoodsCatrgoryCell.h"

#import <RESideMenu.h>

@interface GoodsVIewController ()<GoodsCellDelegate,GoodsCategoryCellDelegate>
/** cayegoryViewModel */
@property(nonatomic,strong) GoodsCategoryViewModel *goodsCategoryVM;
/** goodsViewModel */
@property(nonatomic,strong) GoodsViewModel *goodsVM;


/** 点开的数组 */
@property(nonatomic,strong) NSMutableArray *openArr;

@end

@implementation GoodsVIewController
#pragma mark - 初始化、懒加载
-(GoodsCategoryViewModel *)goodsCategoryVM{
    if (!_goodsCategoryVM) {
        _goodsCategoryVM = [GoodsCategoryViewModel new];
    }
    return _goodsCategoryVM;
}
-(GoodsViewModel *)goodsVM{
    if (!_goodsVM) {
        _goodsVM = [GoodsViewModel new];
    }
    return _goodsVM;
}
-(NSMutableArray *)openArr{
    if (!_openArr) {
        _openArr = [NSMutableArray array];
    }
    return _openArr;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBarItems];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.goodsCategoryVM.goodsCategoryArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *goods = [self.goodsVM goodsArrayWithCategory:self.goodsCategoryVM.goodsCategoryArray[section]];
    if (self.openArr.count == 0) {
        return 0;
    }
    for (int i = 0; i < self.openArr.count; i++) {
        if (section == [self.openArr[i] integerValue]) {
            return goods.count;
        }
    }       
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsCell"];
    GoodsModel *goods = [self.goodsVM goodsArrayWithCategory:self.goodsCategoryVM.goodsCategoryArray[indexPath.section]][indexPath.row];
    cell.goodsModel = goods;
    cell.delegate = self;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

////返回section的头部文本
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//    return self.goodsCategoryVM.goodsCategoryArray[section];
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    GoodsCatrgoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsCatrgoryCell"];
    cell.categoryNameLbl.text = self.goodsCategoryVM.goodsCategoryArray[section];
    cell.delegate = self;
//    NSLog(@"******   %p",&cell);
    cell.open = NO;
    for (int i = 0; i < self.openArr.count; i++) {
        if (section == [self.openArr[i] integerValue]) {
            cell.open = YES;
            NSLog(@"");
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionP{
    return 30;
}

#pragma mark - GoodsCellDelegate
-(void)goodsCellStepperClicked:(GoodsModel *)goodsModel{
    [GoodsViewModel changeModelToSQLWith:goodsModel];
}

-(void)openButtonClickWith:(GoodsCatrgoryCell *)cell{
//    NSLog(@"@@@@@   %p",&cell);
    NSInteger a = [self numberOfSectionsWith:cell];
    
    if (cell.open) {
        [self.openArr removeObject:@(a)];
        
    }else {
        [self.openArr addObject:@(a)];
        
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
/** 根据头视图返回所在的分区 */
-(NSInteger)numberOfSectionsWith:(GoodsCatrgoryCell *)headerView{
    NSInteger a = 0;
    for (int i = 0; i < self.goodsCategoryVM.goodsCategoryArray.count; i++) {
        if ([headerView.categoryNameLbl.text isEqualToString:self.goodsCategoryVM.goodsCategoryArray[i]]) {
            a = i;
        }
    }
    return a;
}

@end
