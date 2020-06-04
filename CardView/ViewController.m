//
//  ViewController.m
//  CardView
//
//  Created by Admin on 2020/6/2.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "ProductCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
/** <#注释#> */
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.tableView];
    self.title = @"卡片轮播";
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = [ProductCell cellWithTableView:tableView];
    cell.ProductCellSelectedBlock = ^(NSIndexPath * _Nonnull indexPath) {
        TestViewController *testVc = [[TestViewController alloc] init];
        [self.navigationController pushViewController:testVc animated:YES];
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }
    return CGFLOAT_MIN;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 88, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 88);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.rowHeight = 140;
    }
    return _tableView;
}



@end
