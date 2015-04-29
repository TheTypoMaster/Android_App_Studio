//
//  BaseTableView.m
//  RefreshToLoadMore
//  上下拉刷新基类

//  Created by Sundy on 13-9-27.
//  Copyright (c) 2013年 Sundy. All rights reserved.
//

#import "BaseTableView.h"
#import "UIColor+Hex.h"
#import "UIViewExt.h"
@implementation BaseTableView

//代码创建时触发此方法xib创建不会触发
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        //调用初始化下拉刷新子视图
        [self _initView];
    }
    return self;
}

//xib创建触发此方法
- (void)awakeFromNib
{
    //调用初始化下拉刷新子视图
    [self _initView];
}

//初始化下拉刷新子视图
- (void)_initView
{
    _refreshTableHeaderView = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
    _refreshTableHeaderView.delegate = self;
    self.refreshHeadViewEnable = YES;
    _refreshTableHeaderView.backgroundColor = [UIColor clearColor];
    [_refreshTableHeaderView refreshLastUpdatedDate];
    
    self.dataSource = self;
    self.delegate = self;
    
    UIView *loadView = [[UIView alloc]initWithFrame:CGRectMake(8, 0, self.bounds.size.width-16, 40)];
    
    loadView.backgroundColor = [UIColor clearColor];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.backgroundColor = [UIColor clearColor];
    [_moreBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    _moreBtn.titleLabel.textColor = [UIColor colorWithHexString:@"999999"];
    _moreBtn.frame = CGRectMake(0, 0, self.bounds.size.width-16, 40);
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [_moreBtn setBackgroundImage:[UIImage imageNamed:home_channel_detail_moredetail] forState:UIControlStateNormal];
    [_moreBtn setTitleColor:[UIColor blackColor]
                   forState:UIControlStateNormal];
    [_moreBtn setTitle:@"加载更多"
              forState:UIControlStateNormal];
    [_moreBtn addTarget:self
                 action:@selector(pullUpToLoadingMore:)
       forControlEvents:UIControlEventTouchUpInside];
    [loadView addSubview:_moreBtn]; 
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicatorView setFrame:CGRectMake(90, 10, 20, 20)];
    activityIndicatorView.tag = 200000;
    [_moreBtn addSubview:activityIndicatorView];
    [activityIndicatorView stopAnimating];
    
    self.tableFooterView = loadView;
//    [loadView release];
}

- (void)setRefreshHeadViewEnable:(BOOL)refreshHeadViewEnable
{
    _refreshHeadViewEnable = refreshHeadViewEnable;
    if (_refreshHeadViewEnable) {
        [self addSubview:_refreshTableHeaderView];
    }else
    {
        if ([_refreshTableHeaderView superview]) {
            [_refreshTableHeaderView removeFromSuperview];
        }
    }
}

//上拉开始加载
- (void)_startLoadMore
{
    [_moreBtn setTitle:@"正在加载..." forState:UIControlStateNormal];
    _moreBtn.enabled = NO;
    UIActivityIndicatorView *activityIndictor = (UIActivityIndicatorView *)[_moreBtn viewWithTag:200000];
    [activityIndictor startAnimating];
}

//上拉停止加载
- (void)_stopLoadMore
{
    if (self.data.count > 0) {
        [_moreBtn setHidden:NO];
        [_moreBtn setTitle:@"加载更多" forState:UIControlStateNormal];
        _moreBtn.enabled = YES;
        UIActivityIndicatorView *activityIndictor = (UIActivityIndicatorView *)[_moreBtn viewWithTag:200000];
        [activityIndictor stopAnimating];
    }else
    {
        [_moreBtn setHidden:YES];
    }
    if (!_isMore) {
        [_moreBtn setTitle:@"已全部加载完成" forState:UIControlStateNormal];
        _moreBtn.enabled = NO;
        [_moreBtn setHidden:NO];
    }
}

- (void)reloadData
{
    [super reloadData];
    
    //停止加载更多
    [self _stopLoadMore];
}

#pragma mark - 
#pragma mark - Pull down
//上拉加载更多事件
- (void)pullUpToLoadingMore:(UIButton *)button
{
    if ([self.eventDelegate respondsToSelector:@selector(refreshHeadTableViewPullUp:)])
    {
        [self.eventDelegate refreshHeadTableViewPullUp:self];
        [self _startLoadMore];
    }
}

#pragma mark - 
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}

//选中Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.eventDelegate respondsToSelector:@selector(baseTableView:didSelectRowAtIndexPath:)])
    {
        [self.eventDelegate baseTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark -
#pragma mark - Data Source Loading / Reloading Methods
//加载数据
- (void)reloadTableViewDataSource
{
	_reloading = YES;
}

//完成数据加载
- (void)doneLoadingTableViewData
{
	_reloading = NO;
	[_refreshTableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}

#pragma mark -
#pragma mark - UIScrollViewDelegate Methods
//当滑动时，实时调用此方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_refreshHeadViewEnable)
    {
        [_refreshTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
    else
    {
        
    }
}

//手指停止拖拽的时候调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate
{
//    屏蔽上拉刷新
    if (_refreshHeadViewEnable)
    {
        [_refreshTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
        
        if (!self.isMore)
        {
            return;
        }
        
        float offset = scrollView.contentOffset.y;
        float contentHeight = scrollView.contentSize.height;
        //当offset偏移量滑到底部时，差值是scrollView的高度
        float sub = contentHeight-offset;
        float offsetend = sub - scrollView.height;
        if (offsetend < -50)
        {
            [self _startLoadMore];
            if ([self.eventDelegate respondsToSelector:@selector(refreshHeadTableViewPullUp:)])
            {
                [self.eventDelegate refreshHeadTableViewPullUp:self];
            }
        }
    }else
    {
        return;
    }
}

-(void)hidenMoreBtn
{
    _moreBtn.hidden=YES;
}

#pragma mark -
#pragma mark - EGORefreshTableHeaderDelegate Methods
//下拉到一定距离，手指放开时调用
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
	[self reloadTableViewDataSource];
    //控制下拉数据请求完成时
    if ([self.eventDelegate respondsToSelector:@selector(refreshHeadTableViewPullDown:)])
    {
        [self.eventDelegate refreshHeadTableViewPullDown:self];
    }
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	return _reloading;
}

//取得下拉刷新的时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	return [NSDate date];
}

@end
