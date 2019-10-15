//
//  CABasicAnimationListViewController.m
//  CAAnimation
//
//  Created by wangzhi on 2018/2/27.
//  Copyright © 2018年 BTStudio. All rights reserved.
//

#import "CABasicAnimationListViewController.h"
#import "Macro.h"
#import "CABasicAnimationViewController.h"

@interface CABasicAnimationListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation CABasicAnimationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@"transform.scale (比例缩放)",
                     @"transform.scale.x (宽度比例缩放)",
                     @"transform.scale.y (高度比例缩放)",
                     @"transform.rotation.x (绕x轴旋转)",
                     @"transform.rotation.y (绕y轴旋转)",
                     @"transform.rotation.z (绕z轴旋转)",
                     @"transform.translation (中心点移动)",
                     @"transform.translation.x (x轴方向上移动)",
                     @"transform.translation.y (y轴方向上移动)",
                     @"contentsRect.size.width (横向拉伸缩放) (已无效)",
                     @"contentsRect.size.height (纵向拉伸缩放) (已无效)",
                     @"bounds (大小缩放,中心位置不变)",
                     @"position (中心位置变化,大小不变)",
                     @"backgroundColor (背景颜色的变化)",
                     @"opacity (透明度变化)",
                     @"contents (内容变化,比如UIImageView的图片)",
                     @"cornerRadius (圆角变化)",
                     @"borderWidth (边框线宽度变化)",
                     @"borderColor (边框线颜色变化)"];
    
    [self.view addSubview:self.tableView];
}


#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.minimumScaleFactor = 0.5;
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AnimationKeyPath type = AnimationKeyPathTransformScale;
    if (0 == indexPath.row) {
        type = AnimationKeyPathTransformScale;
    } else if (1 == indexPath.row) {
        type = AnimationKeyPathTransformScaleX;
    } else if (2 == indexPath.row) {
        type = AnimationKeyPathTransformScaleY;
    } else if (3 == indexPath.row) {
        type = AnimationKeyPathTransformRotationX;
    } else if (4 == indexPath.row) {
        type = AnimationKeyPathTransformRotationY;
    } else if (5 == indexPath.row) {
        type = AnimationKeyPathTransformRotationZ;
    } else if (6 == indexPath.row) {
        type = AnimationKeyPathTransformTranslation;
    } else if (7 == indexPath.row) {
        type = AnimationKeyPathTransformTranslationX;
    } else if (8 == indexPath.row) {
        type = AnimationKeyPathTransformTranslationY;
    } else if (9 == indexPath.row) {
        type = AnimationKeyPathContentsRectSizeWidth;
    } else if (10 == indexPath.row) {
        type = AnimationKeyPathContentsRectSizeHeight;
    } else if (11 == indexPath.row) {
        type = AnimationKeyPathBounds;
    } else if (12 == indexPath.row) {
        type = AnimationKeyPathPosition;
    } else if (13 == indexPath.row) {
        type = AnimationKeyPathBackgroundColor;
    } else if (14 == indexPath.row) {
        type = AnimationKeyPathOpacity;
    } else if (15 == indexPath.row) {
        type = AnimationKeyPathContents;
    } else if (16 == indexPath.row) {
        type = AnimationKeyPathCornerRadius;
    } else if (17 == indexPath.row) {
        type = AnimationKeyPathBorderWidth;
    } else if (18 == indexPath.row) {
        type = AnimationKeyPathBorderColor;
    }
    
    CABasicAnimationViewController *vc = [[CABasicAnimationViewController alloc] init];
    vc.title = self.dataArr[indexPath.row];
    vc.animationType = type;
    [self.navigationController pushViewController:vc animated:YES];
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
