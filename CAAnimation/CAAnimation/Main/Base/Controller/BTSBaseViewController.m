//
//  BTSBaseViewController.m
//  CAAnimation
//
//  Created by ff on 2018/2/27.
//  Copyright © 2018年 BTStudio. All rights reserved.
//

#import "BTSBaseViewController.h"

@interface BTSBaseViewController ()

@end

@implementation BTSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    } else {
        // Fallback on earlier versions
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
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
