//
//  CAKeyframeAnimationListViewController.m
//  CAAnimation
//
//  Created by wangzhi on 2018/2/28.
//  Copyright © 2018年 BTStudio. All rights reserved.
//

#import "CAKeyframeAnimationListViewController.h"
#import "Macro.h"
#import "CAKeyframeAnimationViewController.h"
#import "BeautifulSceneViewController.h"

@interface CAKeyframeAnimationListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation CAKeyframeAnimationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@"弹出视图动画",
                     @"椭圆路径动画",
                     @"Beautiful Scene"];
    
    [self.view addSubview:self.tableView];
}


#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2) {
        BeautifulSceneViewController *vc = [[BeautifulSceneViewController alloc] init];
        vc.title = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        CAKeyframeAnimationViewController *vc = [[CAKeyframeAnimationViewController alloc] init];
        vc.title = self.dataArr[indexPath.row];
        vc.type = indexPath.row;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - Getters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
    }
    return _tableView;
}

- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}


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
