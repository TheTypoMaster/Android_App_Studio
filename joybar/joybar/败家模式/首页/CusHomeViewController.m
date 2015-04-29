//
//  CusHomeViewController.m
//  joybar
//
//  Created by 卢兴 on 15/4/16.
//  Copyright (c) 2015年 卢兴. All rights reserved.
//

#import "CusHomeViewController.h"
#import "CusCenterViewController.h"
#import "CusMyBuyerViewController.h"
#import "CusHomeTableViewCell.h"
@interface CusHomeViewController ()

@property (nonatomic ,strong) UIScrollView *homeScroll;

@property (nonatomic ,strong) UILabel *lineLab;

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,assign) CGFloat startX;
@property (nonatomic ,assign) CGFloat endX;

@property (nonatomic ,strong) CycleScrollView * csView;

@property (nonatomic ,strong) NSArray *imageArr;

@end

@implementation CusHomeViewController
{
    UIView *tempView;
    CusCenterViewController *centerVC;
    CusMyBuyerViewController *myBuyerVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor purpleColor];
    
    self.imageArr = @[@"1.jpg",@"2.jpg",@"3.jpg"];

    [self addNavBarViewAndTitle:@""];
    
    self.retBtn.hidden = YES;
    tempView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, kScreenWidth-100, 64)];
    tempView.backgroundColor = [UIColor clearColor];
    tempView.center = self.navView.center;
    [self.navView addSubview:tempView];
    
    NSArray *nameArr = @[@"买手街",@"TA们说",@"我的买手"];
    for (int i=0; i<3; i++)
    {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(tempView.width/3*i, 18, tempView.width/3, 50)];
        lab.userInteractionEnabled = YES;
        lab.font = [UIFont fontWithName:@"youyuan" size:15];
        lab.backgroundColor = [UIColor clearColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor grayColor];
        lab.text = [nameArr objectAtIndex:i];
        lab.tag=1000+i;
        [tempView addSubview:lab];
        if (i==0)
        {
            lab.textColor = [UIColor orangeColor];
            lab.font = [UIFont fontWithName:@"youyuan" size:17];
            
            self.lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 3)];
            self.lineLab.center = CGPointMake(lab.center.x, 63);
            self.lineLab.backgroundColor = [UIColor orangeColor];
            [tempView addSubview:self.lineLab];
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelect:)];
        [lab addGestureRecognizer:tap];
    }
    
    self.homeScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.homeScroll.contentSize = CGSizeMake(kScreenWidth*3, 0);
    self.homeScroll.alwaysBounceVertical = NO;
    self.homeScroll.pagingEnabled = YES;
    self.homeScroll.delegate = self;
    self.homeScroll.directionalLockEnabled = YES;
    self.homeScroll.showsHorizontalScrollIndicator = NO;
    self.homeScroll.bounces = NO;
    self.homeScroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.homeScroll];
    
    //tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.homeScroll addSubview:self.tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 190)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    

    self.csView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150) animationDuration:3.5];
    self.csView.datasource = self;
    self.csView.delegate = self;
    self.csView.isHomeVC = YES;
    
    [headerView addSubview:self.csView];
    [self.csView reloadData];

    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, self.csView.height+10, kScreenWidth, 20)];
    lab.text = @"最新上新";
    lab.font = [UIFont fontWithName:@"youyuan" size:16];
    lab.backgroundColor = [UIColor clearColor];
    [headerView addSubview:lab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, lab.bottom+10, kScreenWidth, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:line];

}

- (NSInteger) totalPagesCount
{
    return self.imageArr.count;
}

- (UIView *) fetchContentViewAtIndex:(NSInteger)pageIndex
{
    
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    
    imgView.image = [UIImage imageNamed:[self.imageArr objectAtIndex:pageIndex]];
    
    return imgView;
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"cell";
    CusHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell==nil)
    {
        cell = [[CusHomeTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:iden];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    [cell setData:nil];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight-150;
}

#pragma mark ScrollViewDeletegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.endX = scrollView.contentOffset.x;
    
    if (self.startX-self.endX==0)
    {
        return;
    }
    if (scrollView.contentOffset.x==0)
    {
        [self scrollToBuyerStreet];
    }
    else if(scrollView.contentOffset.x==kScreenWidth)
    {
        [self scrollToSaid];
    }
    else
    {
        [self scrollToMyBuyer];
    }
}

-(void)didSelect:(UITapGestureRecognizer *)tap
{
    if (tap.view.tag==1000)
    {
        self.homeScroll.contentOffset = CGPointMake(0, 0);
        [self scrollToBuyerStreet];
    }
    else if(tap.view.tag==1001)
    {
        self.homeScroll.contentOffset = CGPointMake(kScreenWidth, 0);
        [self scrollToSaid];
    }
    else
    {
        self.homeScroll.contentOffset = CGPointMake(kScreenWidth*2, 0);
        [self scrollToMyBuyer];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.startX = scrollView.contentOffset.x;
}

//买手街
-(void)scrollToBuyerStreet
{
    UILabel *lab1 = (UILabel *)[tempView viewWithTag:1000];
    UILabel *lab2 = (UILabel *)[tempView viewWithTag:1001];
    UILabel *lab3 = (UILabel *)[tempView viewWithTag:1002];

    [UIView animateWithDuration:0.25 animations:^{
        self.lineLab.center = CGPointMake(lab1.center.x, 63);
    }];
    lab1.textColor = [UIColor orangeColor];
    lab1.font = [UIFont fontWithName:@"youyuan" size:17];
    lab2.textColor = [UIColor grayColor];
    lab2.font = [UIFont fontWithName:@"youyuan" size:15];
    lab3.textColor = [UIColor grayColor];
    lab3.font = [UIFont fontWithName:@"youyuan" size:15];
    
}

//TA们说
-(void)scrollToSaid
{
    UILabel *lab1 = (UILabel *)[tempView viewWithTag:1000];
    UILabel *lab2 = (UILabel *)[tempView viewWithTag:1001];
    UILabel *lab3 = (UILabel *)[tempView viewWithTag:1002];
    if (centerVC==nil)
    {
        centerVC= [[CusCenterViewController alloc] init];
        centerVC.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-64);
        [self.homeScroll addSubview:centerVC.view];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.lineLab.center = CGPointMake(lab2.center.x, 63);
    }];
    lab2.textColor = [UIColor orangeColor];
    lab2.font = [UIFont fontWithName:@"youyuan" size:17];
    lab1.textColor = [UIColor grayColor];
    lab1.font = [UIFont fontWithName:@"youyuan" size:15];
    lab3.textColor = [UIColor grayColor];
    lab3.font = [UIFont fontWithName:@"youyuan" size:15];

}


-(void)scrollToMyBuyer
{
    UILabel *lab1 = (UILabel *)[tempView viewWithTag:1000];
    UILabel *lab2 = (UILabel *)[tempView viewWithTag:1001];
    UILabel *lab3 = (UILabel *)[tempView viewWithTag:1002];
        if (myBuyerVC==nil)
        {
            myBuyerVC= [[CusMyBuyerViewController alloc] init];
            myBuyerVC.view.frame = CGRectMake(kScreenWidth*2, 0, kScreenWidth, kScreenHeight-64);
            [self.homeScroll addSubview:myBuyerVC.view];
        }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.lineLab.center = CGPointMake(lab3.center.x, 63);
    }];
    lab3.textColor = [UIColor orangeColor];
    lab3.font = [UIFont fontWithName:@"youyuan" size:17];
    lab1.textColor = [UIColor grayColor];
    lab1.font = [UIFont fontWithName:@"youyuan" size:15];
    lab2.textColor = [UIColor grayColor];
    lab2.font = [UIFont fontWithName:@"youyuan" size:15];

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
