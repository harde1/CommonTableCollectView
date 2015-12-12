//
//  CommonTableView.h
//  wukong
//
//  Created by cong on 15/8/4.
//  Copyright (c) 2015年 cong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonCell.h"

static NSString * CELLIDENTIFIER = @"CellIdentifier";
static NSString * CELLDATASOURCE = @"CellDataSource";
static NSString * CELLHEIGHT = @"CellHeight";

static NSString * CELLCANEDIT = @"CellCanEdit";
static NSString * CELLEDITINGSTYLE = @"CellEditingStyle";

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

typedef void(^DidSelectSectionAtIndexPath)(NSIndexPath * indexPath);
typedef void(^DidTouchTableView)(UITableView * tv);
typedef void(^DidSelectRowAtIndexPath)(NSIndexPath * indexPath);
typedef void(^CellAtIndexPath)(UITableViewCell * cell, NSIndexPath * indexPath);
typedef void(^CommitEditingAtIndexPath)(UITableViewCell * cell,UITableViewCellEditingStyle editingStyle, NSIndexPath * indexPath);

@interface CommonTableView : UITableView
<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate,
UITextViewDelegate,
UIScrollViewDelegate
>

@property(nonatomic,copy)DidSelectRowAtIndexPath didSelectRowAtIndexPath;
@property(nonatomic,copy)CellAtIndexPath cellAtIndexPath;
@property(nonatomic,copy)DidTouchTableView didTouchTableView;
//数据源
@property(nonatomic,strong)NSMutableArray * arr_dataSource;
@property(nonatomic,strong)NSMutableArray * arrConfig;
//section高度
@property(nonatomic,strong)NSArray * arr_section;
//关闭自动刷新
@property(nonatomic)BOOL closeAutoReload;
//滚到最后,未实现
@property(nonatomic)BOOL scrolltoBottom;
//初始化
- (instancetype)initWithSection:(NSArray *)arr_section;
- (instancetype)initWithFrame:(CGRect)frame Section:(NSArray *)arr_sections;
//点击事件和cellfor事件block
-(void)commonTableViewCellAtIndexPath:(CellAtIndexPath)cellAtIndexPath andDidSelectRowAtIndexPath:(DidSelectRowAtIndexPath)didSelectRowAtIndexPath;
//编辑模式事件处理A
-(void)setCommitEditingAtIndexPath:(CommitEditingAtIndexPath)commitEditingAtIndexPath;
//测试阶段的方法有风险
-(void)addGroupClassWithData:(NSDictionary *)data andHeadName:(NSString *)headName;
-(void)addGroupNibWithData:(NSDictionary *)data andHeadName:(NSString *)headName;
//section=0, 插入一个cell
-(void)addNibWithEntity:(id)str_Object andCellName:(NSString *)cellName;
-(void)addClassWithEntity:(id)str_Object andCellName:(NSString *)cellName;
//指定一个section, 插入一个cell，有顺序
-(void)addNibWithEntity:(id)str_Object andCellName:(NSString *)cellName andSection:(int)section;
-(void)addClassWithEntity:(id)str_Object andCellName:(NSString *)cellName andSection:(int)section;
#pragma mark -- 编辑模式 --
-(void)addNibWithEntity:(id)obj andCellName:(NSString *)cellName editStyle:(UITableViewCellEditingStyle)editStyle;
-(void)addClassWithEntity:(id)obj andCellName:(NSString *)cellName editStyle:(UITableViewCellEditingStyle)editStyle;
-(void)addNibWithEntity:(id)obj andCellName:(NSString *)cellName editStyle:(UITableViewCellEditingStyle)editStyle andSection:(int)section;
-(void)addClassWithEntity:(id)obj andCellName:(NSString *)cellName editStyle:(UITableViewCellEditingStyle)editStyle andSection:(int)section;

//清空所有数据
-(void)clearAllData;
//移除indexPath的cell的高度缓存
-(void)removeHeightByIndexPath:(NSIndexPath *)indexPath;
//移除所有高度缓存
-(void)removeHeight;
//点击事件Block
-(void)setDidSelectRowAtIndexPath:(DidSelectRowAtIndexPath)didSelectRowAtIndexPath;
//cellfor事件
-(void)setCellAtIndexPath:(CellAtIndexPath)cellAtIndexPath;
//tableView给点击
-(void)setDidTouchTableView:(DidTouchTableView)didTouchTableView;

#pragma mark -- 插入\删除一个cell --
-(void)insertIndexPath:(NSIndexPath *)indexPath withNibWithEntity:(id)object andCellName:(NSString *)cellName withRowAnimation:(UITableViewRowAnimation)animation;
-(void)insertIndexPath:(NSIndexPath *)indexPath withClassWithEntity:(id)object andCellName:(NSString *)cellName withRowAnimation:(UITableViewRowAnimation)animation;
//编辑模式
-(void)insertInEditStyle:(UITableViewCellEditingStyle)editStyle indexPath:(NSIndexPath *)indexPath withNibWithEntity:(id)object andCellName:(NSString *)cellName withRowAnimation:(UITableViewRowAnimation)animation;
-(void)insertInEditStyle:(UITableViewCellEditingStyle)editStyle indexPath:(NSIndexPath *)indexPath withClassWithEntity:(id)object andCellName:(NSString *)cellName withRowAnimation:(UITableViewRowAnimation)animation;

//移除一个cell
-(void)removeIndexPath:(NSIndexPath *)indexPath andCellName:(NSString *)cellName withRowAnimation:(UITableViewRowAnimation)animation;
-(void)removeIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

@end
