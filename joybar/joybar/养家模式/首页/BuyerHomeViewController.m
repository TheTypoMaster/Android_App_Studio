//
//  BuyerHomeViewController.m
//  joybar
//
//  Created by 卢兴 on 15/4/16.
//  Copyright (c) 2015年 卢兴. All rights reserved.
//

#import "BuyerHomeViewController.h"
#import "AppDelegate.h"
@interface BuyerHomeViewController ()

@end

@implementation BuyerHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(didClick) forControlEvents:(UIControlEventTouchUpInside)];

    [self addNavBarViewAndTitle:@"首页"];
    self.retBtn.hidden = YES;

}
-(void)didClick
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //    app.window.rootViewController = app.cusTab;
    //    [app.window makeKeyAndVisible];
    [app.baseNav popToRootViewControllerAnimated:NO];
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
