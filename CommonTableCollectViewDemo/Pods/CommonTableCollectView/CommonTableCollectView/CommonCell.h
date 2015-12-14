//
//  CommonCell.h
//  PudiEdu
//
//  Created by cong on 15/10/4.
//  Copyright © 2015年 cong. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * COMMONTABLEVIEWSCROLL =@"CommonTableViewScroll";
static NSString * COMMONTABLEVIE =@"tableView";
static NSString * SCROLLTYPE =@"ScrollType";
#pragma mark --- tableView的滚动状态 ---
typedef NS_ENUM(NSInteger, ScrollType) {
    scrollViewDidScroll,//正在滚动
    scrollViewDidZoom,//当scrollView缩放时
    scrollViewWillBeginDragging,//当开始滚动视图时，执行该方法。一次有效滑动（开始滑动，滑动一小段距离，只要手指不松开，只算一次滑动），只执行一次。
    scrollViewWillEndDragging,//滑动scrollView，并且手指离开时执行。一次有效滑动，只执行一次。当pagingEnabled属性为YES时，不调用，该方法
    scrollViewDidEndDragging,//滑动视图，当手指离开屏幕那一霎那，调用该方法。一次有效滑动，只执行一次。decelerate,指代，当我们手指离开那一瞬后，视图是否还将继续向前滚动（一段距离），经过测试，decelerate=YES
    scrollViewWillBeginDecelerating,//滑动减速时调用该方法
    scrollViewDidEndDecelerating,//滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
    
    scrollViewDidEndScrollingAnimation,//当滚动视图动画完成后，调用该方法，如果没有动画，那么该方法将不被调用
    scrollViewWillBeginZooming,
    scrollViewDidEndZooming,//当缩放结束后，并且缩放大小回到minimumZoomScale与maximumZoomScale之间后（我们也许会超出缩放范围），调用该方法。
    scrollViewShouldScrollToTop,
    scrollViewDidScrollToTop
};
@class CommonTableView;

@interface CommonCell : UITableViewCell
@property(strong,nonatomic)id params;
@property(strong,nonatomic)NSIndexPath * myIndexPath;
@property(weak,nonatomic)CommonTableView * tableView;
//是否在显示
@property(assign,nonatomic)BOOL isShow;

-(void)commonTableView:(CommonTableView *)tableView inViewController:(UIViewController *)viewController didSelectCellAtIndexPath:(NSIndexPath *)indexPath;

-(void)commonTableView:(CommonTableView *)tableView inViewController:(UIViewController *)viewController cellForIndexPath:(NSIndexPath *)indexPath;
//编辑模式B
- (void)commonTableView:(CommonTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

//检测到tableView的滚动状态，在此可以进行一些回收内存的操作，如离开当前画面的cell内存回收
-(void)commonTableView:(CommonTableView *)tableView scrollType:(ScrollType)scrollType;

@end
