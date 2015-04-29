//
//  CusMineViewController.m
//  joybar
//
//  Created by 卢兴 on 15/4/16.
//  Copyright (c) 2015年 卢兴. All rights reserved.
//

#import "CusMineViewController.h"
#import "AppDelegate.h"
#import "BuyerTabBarViewController.h"
@interface CusMineViewController ()

@end

@implementation CusMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(didClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self addNavBarViewAndTitle:@"个人中心"];
    self.retBtn.hidden = YES;
}

-(void)didClick
{
    AppDelegate *app =(AppDelegate *)[UIApplication sharedApplication].delegate;
//    app.window.rootViewController = app.buyerTab;
//    [app.window makeKeyAndVisible];
    BuyerTabBarViewController *buyTab = [[BuyerTabBarViewController alloc] init];
    [app.baseNav pushViewController:buyTab animated:NO];
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
