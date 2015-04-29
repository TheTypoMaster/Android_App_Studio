//
//  FindPasswordViewController.m
//  joybar
//
//  Created by 123 on 15/4/17.
//  Copyright (c) 2015年 卢兴. All rights reserved.
//

#import "FindPasswordViewController.h"
#import "SetPasswordViewController.h"
@interface FindPasswordViewController ()

@end

@implementation FindPasswordViewController
{
    UIButton*authBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kCustomColor(235, 238, 240);

    [self addView];
    
    [self addNavBarViewAndTitle:@"找回密码"];
}

-(void)addView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+15, kScreenWidth, 90)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 45,kScreenWidth-20, 0.5)];
    line4.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:line4];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 30, 30)];
    lab1.text = @"+86";
    lab1.font = [UIFont fontWithName:@"youyuan" size:15];
    [bgView addSubview:lab1];
    
    UILabel *line5 = [[UILabel alloc] initWithFrame:CGRectMake(40, 15, 0.5, 24)];
    line5.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:line5];
    
    UITextField *registerPhoneText = [[UITextField alloc] initWithFrame:CGRectMake(line5.right+15, 7, 200, 40)];
    registerPhoneText.delegate = self;
    registerPhoneText.placeholder = @"请输入您的手机号码";
    registerPhoneText.backgroundColor = [UIColor clearColor];
    registerPhoneText.font = [UIFont fontWithName:@"youyuan" size:14];
    registerPhoneText.keyboardType = UIKeyboardTypeNumberPad;
    [bgView addSubview:registerPhoneText];
    
//    UILabel *line6 = [[UILabel alloc] initWithFrame:CGRectMake(10, line5.bottom+50, kScreenWidth-20, 0.5)];
//    line6.backgroundColor = [UIColor lightGrayColor];
//    [bgView addSubview:line6];
    
    UITextField *registerAuthText = [[UITextField alloc] initWithFrame:CGRectMake(10, 47, 200, 40)];
    registerAuthText.placeholder = @"请输入短信验证码";
    registerAuthText.font = [UIFont fontWithName:@"youyuan" size:14];
    registerAuthText.keyboardType = UIKeyboardTypeNumberPad;
    [bgView addSubview:registerAuthText];
    
    authBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    authBtn.frame = CGRectMake(kScreenWidth-75, 10, 132/2, 56/2);
    [authBtn setTitle:@"验证" forState:(UIControlStateNormal)];
    authBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    authBtn.titleLabel.font = [UIFont fontWithName:@"youyuan" size:14];
    [authBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [authBtn setBackgroundImage:[UIImage imageNamed:@"yanzheng.png"] forState:(UIControlStateNormal)];
    [authBtn addTarget:self action:@selector(didCilckGetAuthCode) forControlEvents:(UIControlEventTouchUpInside)];
    authBtn.hidden = YES;
    [bgView addSubview:authBtn];

    UIButton *submitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    submitBtn.frame = CGRectMake(15, bgView.bottom+30, kScreenWidth-30, 40);
    [submitBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    submitBtn.titleLabel.font = [UIFont fontWithName:@"youyuan" size:17];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    submitBtn.layer.cornerRadius = 3;
    submitBtn.backgroundColor = kCustomColor(253, 137, 83);
    [submitBtn addTarget:self action:@selector(didClickSubmit) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:submitBtn];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger strLength = textField.text.length - range.length + string.length;
    
    if (strLength>0)
    {
        authBtn.hidden = NO;
    }
    else
    {
        authBtn.hidden = YES;
    }
    
    return YES;
}


//验证
-(void)didCilckGetAuthCode
{
    
}

//确定
-(void)didClickSubmit
{
    SetPasswordViewController *VC = [[SetPasswordViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
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
