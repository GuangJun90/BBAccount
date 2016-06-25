//
//  GoodsCategoryVC.m
//  笔笔账本
//
//  Created by com.sheng on 16/6/4.
//  Copyright © 2016年 GuangJun. All rights reserved.
//

#import "GoodsCategoryVC.h"
#import "GoodsCategoryViewModel.h"

@interface GoodsCategoryVC ()
/** 货物分类的VM */
@property(nonatomic,strong) GoodsCategoryViewModel *goodsCVM;
/** 货物分类数组 */
@property(nonatomic,strong) NSMutableArray *categoryArray;

@end

@implementation GoodsCategoryVC
#pragma mark - 懒加载
-(GoodsCategoryViewModel *)goodsCVM{
    if (!_goodsCVM) {
        _goodsCVM = [GoodsCategoryViewModel new];
    }
    return _goodsCVM;
}
-(NSMutableArray *)goodsCategoryArray{
    if (!_categoryArray) {
        _categoryArray = [NSMutableArray array];
    }
    return _categoryArray;
}



#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"货物分类";
    [self addBarItems];
    self.categoryArray = [self.goodsCVM.goodsCategoryArray mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 方法
- (void)addBarItems {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回_默认"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    //由于左边的item离屏幕左边缘太远,所以加以调整
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    self.navigationItem.leftBarButtonItems = @[spaceItem, backItem];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(clickEditButton:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)back {
    [self.goodsCVM refreshGoodsCategoryWithArray:self.categoryArray];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickEditButton:(UIBarButtonItem *)item
{
    //开启表格的编辑模式
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    //修改右上角按钮的文字
    item.title = self.tableView.editing?@"完成":@"编辑";
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.categoryArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = self.goodsCategoryArray[indexPath.row];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = @{
                           @"category" : self.categoryArray[indexPath.row]
                           };
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"PostGoodsCategoryName" object:self userInfo:dict];
    [self back];
}

#pragma mark - 表格的编辑
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.goodsCategoryArray.count - 1) {
        return UITableViewCellEditingStyleInsert;
    }else{
        return UITableViewCellEditingStyleDelete;
    }
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.categoryArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        //1.弹出警告框   控制器
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新增货物分类" message:nil preferredStyle:UIAlertControllerStyleAlert];
        //2.为AlertController 添加文本框
        [alert addTextFieldWithConfigurationHandler:^(UITextField * textField) {
            //配置 文本框 的 占位符
            textField.placeholder = @"货物分类名";
        }];
        //3.添加事件
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"新增" style:UIAlertActionStyleDefault handler:^(UIAlertAction* aciton) {
            NSString *categoryName = alert.textFields[0].text;
            [self.categoryArray addObject:categoryName];
            //再刷新界面
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.categoryArray.count-1 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }];
        
        UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        
        //4.把 Action 添加到 UIAlertController 中
        [alert addAction:actionYes];
        [alert addAction:actionNo];
        [self presentViewController:alert animated:YES completion:nil];
    }
}



@end
