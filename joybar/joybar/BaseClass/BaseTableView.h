//
//  BaseTableView.h
//  RefreshToLoadMore
//  下拉刷新基类

//  Created by Sundy on 13-9-27.
//  Copyright (c) 2013年 Sundy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
@class BaseTableView;

//TableView与控制器通讯的协议（网络请求数据处理）
@protocol UITableViewEventDelegate <NSObject>
@optional

//下拉时
- (void)refreshHeadTableViewPullDown:(BaseTableView *)baseTableView;

//上拉时
- (void)refreshHeadTableViewPullUp:(BaseTableView *)baseTableView;

//选中Cell时
- (void)baseTableView:(BaseTableView *)baseTableview
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface BaseTableView : UITableView<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate>
{
    EGORefreshTableHeaderView *_refreshTableHeaderView;
    
    BOOL _reloading;
    //点击加载更多
    UIButton *_moreBtn;
}
//是否使用下拉刷新
@property (nonatomic, assign) BOOL refreshHeadViewEnable;

//为TableView提供数据
@property (nonatomic, retain) NSMutableArray *data;

//声明协议
@property (nonatomic, assign) id<UITableViewEventDelegate>eventDelegate;

//上拉是否加载完成
@property (nonatomic, assign) BOOL isMore;

//加载数据
- (void)reloadTableViewDataSource;

//数据加载完成
- (void)doneLoadingTableViewData;

//隐藏morebtn
-(void)hidenMoreBtn;

@end
