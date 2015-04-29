//
//  CusCircleViewController.m
//  joybar
//
//  Created by 卢兴 on 15/4/16.
//  Copyright (c) 2015年 卢兴. All rights reserved.
//

#import "CusCircleViewController.h"
#import "CusMyCircleViewController.h"
#import "CircleTableViewCell.h"
#import "MJRefresh.h"
@interface CusCircleViewController ()

@property (nonatomic ,strong) UIScrollView *circleScroll;

//navigationbar上的横线

@property (nonatomic ,strong) UILabel *lineLab;

@property (nonatomic ,strong) NSMutableArray *circleDataArr;

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,assign) CGFloat startX;
@property (nonatomic ,assign) CGFloat endX;

@end

@implementation CusCircleViewController
{
    UIView *tempView;
    CusMyCircleViewController *myCircleVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavBarViewAndTitle:@""];
    
    UIButton *searchBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    searchBtn.frame = CGRectMake(0, 0, 64, 64);
    searchBtn.backgroundColor = [UIColor clearColor];
    [searchBtn addTarget:self action:@selector(didClickSearchBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.navView addSubview:searchBtn];
    
    UIImageView *searchImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 33, 40/2, 40/2)];
    searchImg.image = [UIImage imageNamed:@"search.png"];
    [searchBtn addSubview:searchImg];
    
    UIButton *messageBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    messageBtn.frame = CGRectMake(kScreenWidth-64, 0, 64, 64);
    messageBtn.backgroundColor = [UIColor clearColor];
    [messageBtn addTarget:self action:@selector(didClickMessageBtnBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.navView addSubview:messageBtn];
    
    UIImageView *messageImg = [[UIImageView alloc] initWithFrame:CGRectMake(33, 33, 40/2, 40/2)];
    messageImg.image = [UIImage imageNamed:@"message.png"];
    [messageBtn addSubview:messageImg];

    self.circleDataArr = [NSMutableArray array];
    
    tempView = [[UIView alloc] initWithFrame:CGRectMake(75, 0, kScreenWidth-150, 64)];
    tempView.backgroundColor = [UIColor clearColor];
    tempView.center = self.navView.center;
    [self.navView addSubview:tempView];
    
    NSArray *nameArr = @[@"推荐圈子",@"我的圈子"];
    for (int i=0; i<2; i++)
    {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(tempView.width/2*i, 18, tempView.width/2, 50)];
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
    self.retBtn.hidden = YES;
    
    self.circleScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.circleScroll.contentSize = CGSizeMake(kScreenWidth*2, 0);
    self.circleScroll.alwaysBounceVertical = NO;
    self.circleScroll.pagingEnabled = YES;
    self.circleScroll.delegate = self;
    self.circleScroll.directionalLockEnabled = YES;
    self.circleScroll.showsHorizontalScrollIndicator = NO;
    self.circleScroll.bounces = NO;
    self.circleScroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.circleScroll];
    
    //tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.circleScroll addSubview:self.tableView];
    
    self.circleDataArr = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];

    // 2.集成刷新控件
    [self setupRefresh];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];

    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @"正在帮你刷新中,不客气";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"正在帮你加载中,不客气";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.circleDataArr insertObject:@[@"",@"",@""] atIndex:0];
    }
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.circleDataArr addObject:@[@"",@"",@"",@""]];
    }
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.circleDataArr.count/2+self.circleDataArr.count%2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"cell";
    CircleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell==nil)
    {
        cell = [[CircleTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:iden];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSRange range = NSMakeRange(indexPath.row*2, 2);
    if (self.circleDataArr.count%2==1 && (indexPath.row == self.circleDataArr.count/2 + self.circleDataArr.count%2 - 1)) {
        range = NSMakeRange(indexPath.row*2, 1);
    }
    NSArray *arr  =[self.circleDataArr subarrayWithRange:range];
    [cell setData:arr];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (kScreenWidth-60)/2+81;
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
        [self scrollToRecommendCircle];
    }
    else
    {
        [self scrollToMyCircle];
    }
}

-(void)didSelect:(UITapGestureRecognizer *)tap
{
    if (tap.view.tag==1000)
    {
        self.circleScroll.contentOffset = CGPointMake(0, 0);
        [self scrollToRecommendCircle];
    }
    else
    {
        self.circleScroll.contentOffset = CGPointMake(kScreenWidth, 0);
        [self scrollToMyCircle];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.startX = scrollView.contentOffset.x;
}

//点击搜索
-(void)didClickSearchBtn
{
    
}

//点击消息
-(void)didClickMessageBtnBtn
{
    
}

//推荐圈子
-(void)scrollToRecommendCircle
{
    UILabel *lab1 = (UILabel *)[tempView viewWithTag:1000];
    UILabel *lab2 = (UILabel *)[tempView viewWithTag:1001];

    [UIView animateWithDuration:0.25 animations:^{
        self.lineLab.center = CGPointMake(lab1.center.x, 63);
    }];
    lab1.textColor = [UIColor orangeColor];
    lab1.font = [UIFont fontWithName:@"youyuan" size:17];
    lab2.textColor = [UIColor grayColor];
    lab2.font = [UIFont fontWithName:@"youyuan" size:15];
    self.circleScroll.contentOffset = CGPointMake(0, 0);
}

//我的圈子
-(void)scrollToMyCircle
{
    UILabel *lab1 = (UILabel *)[tempView viewWithTag:1000];
    UILabel *lab2 = (UILabel *)[tempView viewWithTag:1001];

    if (myCircleVC==nil)
    {
        myCircleVC= [[CusMyCircleViewController alloc] init];
        myCircleVC.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-64);
        [self.circleScroll addSubview:myCircleVC.view];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.lineLab.center = CGPointMake(lab2.center.x, 63);
    }];
    lab2.textColor = [UIColor orangeColor];
    lab2.font = [UIFont fontWithName:@"youyuan" size:17];
    lab1.textColor = [UIColor grayColor];
    lab1.font = [UIFont fontWithName:@"youyuan" size:15];
 
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
