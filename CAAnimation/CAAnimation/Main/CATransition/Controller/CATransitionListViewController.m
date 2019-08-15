//
//  CATransitionListViewController.m
//  CAAnimation
//
//  Created by wangzhi on 2018/3/5.
//  Copyright © 2018年 BTStudio. All rights reserved.
//

#import "CATransitionListViewController.h"
#import "Macro.h"
#import "CATransitionViewController.h"

@interface CATransitionListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation CATransitionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@"kCATransitionFade",
                     @"kCATransitionMoveIn",
                     @"kCATransitionPush",
                     @"kCATransitionReveal",
                     @"01. cube",
                     @"02. suckEffect",
                     @"03. rippleEffect",
                     @"04. pageCurl",
                     @"05. pageUnCurl",
                     @"06. oglFlip",
                     @"07. cameraIrisHollowOpen",
                     @"08. cameraIrisHollowClose",
                     @"09. spewEffect (无效)",
                     @"10. genieEffect (无效)",
                     @"11. unGenieEffect (无效)",
                     @"12. twist (无效)",
                     @"13. tubey (无效)",
                     @"14. swirl (无效)",
                     @"15. charminUltra (无效)",
                     @"16. zoomyIn (无效)",
                     @"17. zoomyOut (无效)",
                     @"18. oglApplicationSuspend (无效)"];
    
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
    
    TransitionAnimationType type = TransitionAnimationCube;
    
    if (indexPath.row == 0) {
        type = TransitionAnimationkCATransitionFade;
    } else if (indexPath.row == 1) {
        type = TransitionAnimationkCATransitionMoveIn;
    } else if (indexPath.row == 2) {
        type = TransitionAnimationkCATransitionPush;
    } else if (indexPath.row == 3) {
        type = TransitionAnimationkCATransitionReveal;
    } else if (indexPath.row == 4) {
        type = TransitionAnimationCube;
    } else if (indexPath.row == 5) {
        type = TransitionAnimationSuckEffect;
    } else if (indexPath.row == 6) {
        type = TransitionAnimationRippleEffect;
    } else if (indexPath.row == 7) {
        type = TransitionAnimationPageCurl;
    } else if (indexPath.row == 8) {
        type = TransitionAnimationPageUnCurl;
    } else if (indexPath.row == 9) {
        type = TransitionAnimationOglFlip;
    } else if (indexPath.row == 10) {
        type = TransitionAnimationCameraIrisHollowOpen;
    } else if (indexPath.row == 11) {
        type = TransitionAnimationCameraIrisHollowClose;
    } else if (indexPath.row == 12) {
        type = TransitionAnimationSpewEffect;
    } else if (indexPath.row == 13) {
        type = TransitionAnimationGenieEffect;
    } else if (indexPath.row == 14) {
        type = TransitionAnimationUnGenieEffect;
    } else if (indexPath.row == 15) {
        type = TransitionAnimationTwist;
    } else if (indexPath.row == 16) {
        type = TransitionAnimationTubey;
    } else if (indexPath.row == 17) {
        type = TransitionAnimationSwirl;
    } else if (indexPath.row == 18) {
        type = TransitionAnimationCharminUltra;
    } else if (indexPath.row == 19) {
        type = TransitionAnimationZoomyIn;
    } else if (indexPath.row == 20) {
        type = TransitionAnimationZoomyOut;
    } else if (indexPath.row == 21) {
        type = TransitionAnimationOglApplicationSuspend;
    }
    
    CATransitionViewController *vc = [[CATransitionViewController alloc] init];
    vc.title = self.dataArr[indexPath.row];
    vc.type = type;
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
