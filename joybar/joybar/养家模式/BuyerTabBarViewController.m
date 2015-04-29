//
//  BuyerTabBarViewController.m
//  joybar
//
//  Created by 卢兴 on 15/4/16.
//  Copyright (c) 2015年 卢兴. All rights reserved.
//

#import "BuyerTabBarViewController.h"
#import "BuyerHomeViewController.h"
#import "BuyerTicketViewController.h"
#import "BuyerCircleViewController.h"
#import "BuyerMessageViewController.h"
#import "BuyerStoreViewController.h"
@interface BuyerTabBarViewController ()

@end

@implementation BuyerTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化子视图
    [self _initWithControllers];
    //创建自定义TabBar
    [self _initTabBarViewController];
    self.tabBar.backgroundColor = [UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:244.0f/255.0f alpha:1.0f];
}

-(void)_initWithControllers
{
    BuyerHomeViewController *home = [[BuyerHomeViewController alloc]init];
    BuyerTicketViewController *ticket = [[BuyerTicketViewController alloc]init];
    BuyerCircleViewController *circle = [[BuyerCircleViewController alloc]init];
    BuyerMessageViewController *message = [[BuyerMessageViewController alloc]init];
    BuyerStoreViewController *store = [[BuyerStoreViewController alloc] init];
    self.buyerHomeNav = [[BaseNavigationController alloc]initWithRootViewController:home];
    self.buyerTicketNav = [[BaseNavigationController alloc]initWithRootViewController:ticket];
    self.buyerCircleNav = [[BaseNavigationController alloc]initWithRootViewController:circle];
    self.buyerMesNav = [[BaseNavigationController alloc]initWithRootViewController:message];
    self.buyerStoreNav = [[BaseNavigationController alloc]initWithRootViewController:store];
    
    
    NSArray *navs = [NSArray arrayWithObjects:self.buyerHomeNav,self.buyerTicketNav,self.buyerCircleNav,self.buyerMesNav,self.buyerStoreNav, nil];
    
    self.viewControllers = navs;
}


-(void)_initTabBarViewController
{
    //TabBarItem的title
    NSArray *title = @[@"",@"",@"",@"",@""];
    //TabBar上Button在Normal状态下的图片
    NSArray *tabBarImage = @[@"tab_index_normal",@"tab_quickbuy_normal",@"tab_cart_normal",@"tab_account_normal",@"tab_more_normal"];
    //TabBar上Button在Selected状态下的图片
    NSArray *tabBarPress = @[@"tab_index_selected",@"tab_quickbuy_selected",@"tab_cart_selected",@"tab_account_selected",@"tab_more_selected"];
    self.btnArray = [NSMutableArray array];
    //创建TabBar上的Button和Label
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 48)];
    bgImgView.userInteractionEnabled = YES;
    bgImgView.backgroundColor = [UIColor clearColor];
    [self.tabBar addSubview:bgImgView];
    for (int i = 0; i<[title count]; i++)
    {
        UIButton *tabBtn;
        tabBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tabBtn.backgroundColor = [UIColor clearColor];
        //默认选中状态为NO
        tabBtn.selected = NO;
        //设置Button的frame
        CGRect rect;
        rect.origin.x = (self.tabBar.frame.size.width/[title count])*i;
        rect.origin.y = 0;
        rect.size.width = self.tabBar.frame.size.width/[title count];
        rect.size.height = self.tabBar.frame.size.height/1.2;
        tabBtn.frame = rect;
        tabBtn.center = CGPointMake(32+64*i, self.tabBar.frame.size.height/2);
        tabBtn.tag = i+100;
        tabBtn.titleLabel.font = [UIFont systemFontOfSize:10.0f];
        tabBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        //        tabBtn.userInteractionEnabled = YES;
        //设置图片
        [tabBtn setBackgroundImage:[UIImage imageNamed:tabBarImage[i]] forState:(UIControlStateNormal)];
        [tabBtn setBackgroundImage:[UIImage imageNamed:tabBarPress[i]] forState:UIControlStateSelected];
        
        //        [tabBtn setImage:[UIImage imageNamed:tabBarImage[i]]
        //                forState:UIControlStateNormal];
        //        [tabBtn setImage:[UIImage imageNamed:tabBarPress[i]] forState:UIControlStateHighlighted];
        //        [tabBtn setImage:[UIImage imageNamed:tabBarPress[i]]
        //                forState:UIControlStateSelected];
        //        [tabBtn setBackgroundImage:[UIImage imageNamed:@"TabBarSelectedImage.png"] forState:UIControlStateSelected];
        //设置标题
        //        [tabBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        //        tabBtn.backgroundColor = [UIColor clearColor];
        //        NSString *titleStr = title[i];
        //        [tabBtn setTitle:titleStr
        //                forState:UIControlStateNormal];
        //        [tabBtn setTitle:titleStr
        //                forState:UIControlStateSelected];
        [tabBtn setAdjustsImageWhenDisabled:NO];
        [tabBtn setAdjustsImageWhenHighlighted:NO];
        //设置触发事件
        [tabBtn addTarget:self
                   action:@selector(SelectedTabBarIndex:)
         forControlEvents:UIControlEventTouchUpInside];
        //将btn添加到数组
        [self.btnArray addObject:tabBtn];
        [bgImgView addSubview:tabBtn];
    }
    UIButton *homeBtn = (self.btnArray)[0];
    
    homeBtn.selected = YES;
    homeBtn.userInteractionEnabled = NO;
}

//按钮选中事件
- (void)SelectedTabBarIndex:(UIButton*)button
{
    self.selectedIndex = button.tag-100;
    
    [self.btnArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         UIButton *btn = (UIButton *)obj;
         
         if (idx == self.selectedIndex)
         {
             btn.selected = YES;
             btn.userInteractionEnabled = NO;
         }
         else
         {
             btn.selected = NO;
             btn.userInteractionEnabled = YES;
         }
     }];
}

-(void)SelectedIndex:(NSUInteger)selectedIndex
{
    if ([self isKindOfClass:[UITabBarController class]])
    {
        [super setSelectedIndex:selectedIndex];
    }
    [self SelectedTabBarIndex:[self.btnArray objectAtIndex:selectedIndex]];
}

- (void)didReceiveMemoryWarning
{
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
