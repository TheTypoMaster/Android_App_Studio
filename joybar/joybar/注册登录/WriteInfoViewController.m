//
//  WriteInfoViewController.m
//  joybar
//
//  Created by 123 on 15/4/17.
//  Copyright (c) 2015年 卢兴. All rights reserved.
//

#import "WriteInfoViewController.h"

@interface WriteInfoViewController ()

@end

@implementation WriteInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kCustomColor(235, 238, 240);
    
    [self addInfoView];
    [self addSelectCityView];
    
    
    [self addNavBarViewAndTitle:@"完善个人资料"];
}

-(void)addInfoView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 15+64, kScreenWidth, 45*3)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    NSArray *arr = @[@"创建用户名",@"设置密码",@"再次输入密码"];
    for (int i=0; i<3; i++)
    {
        UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(15, 45*i, kScreenWidth, 45)];
        text.placeholder = [arr objectAtIndex:i];
        text.font = [UIFont fontWithName:@"youyuan" size:14];
        [bgView addSubview:text];
        
        if (i<2)
        {
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(15, 45+45*i, kScreenWidth-30, 0.5)];
            line.backgroundColor = [UIColor lightGrayColor];
            [bgView addSubview:line];
        }
        
        
    }
    
}

-(void)addSelectCityView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 45*3+30+64, kScreenWidth, 45)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UILabel *cityNameLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, 45)];
    cityNameLab.text = @"北京";
    cityNameLab.textAlignment = NSTextAlignmentLeft;
    cityNameLab.font = [UIFont fontWithName:@"youyuan" size:14];
    cityNameLab.textColor = kCustomColor(253, 137, 83);
    [bgView addSubview:cityNameLab];
    
    UILabel *selectCity = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-85, 0, 70, 45)];
    selectCity.text = @"更换城市 >";
    selectCity.font = [UIFont fontWithName:@"youyuan" size:14];
    selectCity.textColor = [UIColor lightGrayColor];
    [bgView addSubview:selectCity];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickSelectCity)];
    [bgView addGestureRecognizer:tap];
    
    UIButton *submitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    submitBtn.frame = CGRectMake(15, bgView.bottom+20, kScreenWidth-30, 40);
    [submitBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    submitBtn.titleLabel.font = [UIFont fontWithName:@"youyuan" size:17];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    submitBtn.layer.cornerRadius = 3;
    submitBtn.backgroundColor = kCustomColor(253, 137, 83);
    [submitBtn addTarget:self action:@selector(didClickSubmit) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:submitBtn];
    
}

//选择城市
-(void)didClickSelectCity
{
    
}

//确定
-(void)didClickSubmit
{
    
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
