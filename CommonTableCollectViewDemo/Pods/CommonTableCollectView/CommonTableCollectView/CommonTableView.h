//
//  CommonTableView.h
//  wukong
//
//  Created by cong on 15/8/4.
//  Copyright (c) 2015年 cong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonCell.h"
typedef NS_ENUM(NSInteger, UITextFieldViewState) {
    UITextFieldViewShouldBeginEditing=0,
    UITextFieldViewDidBeginEditing,
    UITextFieldShouldEndEditing,
    UITextFieldDidEndEditing,
    UITextFieldViewShouldChangeCharactersInRange,
    UITextFieldViewShouldClear,
    UITextFieldViewShouldReturn,
    
    
    UITextViewDidChange,
    UITextViewDidChangeSelection
};



typedef void(^DidSelectSectionAtIndexPath)(NSIndexPath * indexPath);
typedef void(^DidTouchTableView)(UITableView * tv);
typedef void(^DidSelectRowAtIndexPath)(NSIndexPath * indexPath);
typedef void(^CellAtIndexPath)(UITableViewCell * cell, NSIndexPath * indexPath);
typedef void(^CellAtIndexPathSendData)(UITableViewCell * cell, NSIndexPath * indexPath,id object,UITextFieldViewState state,id data);

@interface CommonTableView : UITableView<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>

@property(nonatomic,copy)DidSelectRowAtIndexPath didSelectRowAtIndexPath;
@property(nonatomic,copy)CellAtIndexPath cellAtIndexPath; //给cell附加方法
@property(nonatomic,copy)DidTouchTableView didTouchTableView; //给cell附加方法

@property(nonatomic,strong)NSMutableArray * arr_dataSource;
@property(nonatomic,strong)NSMutableDictionary * dict_heightSave;
@property(nonatomic,strong)NSArray * arr_section;
@property(nonatomic,strong)NSMutableArray * arr_Config;//cell设置,identifier


@property(nonatomic)BOOL closeAutoReload;
@property(nonatomic)BOOL scrolltoBottom;

-(void)commonTableViewCellAtIndexPath:(CellAtIndexPath)cellAtIndexPath andDidSelectRowAtIndexPath:(DidSelectRowAtIndexPath)didSelectRowAtIndexPath;

- (instancetype)initWithSection:(NSArray *)arr_section;
- (instancetype)initWithFrame:(CGRect)frame Section:(NSArray *)arr_sections;

//section head
-(void)addGroupClassWithData:(NSDictionary *)data andHeadName:(NSString *)headName;
-(void)addGroupNibWithData:(NSDictionary *)data andHeadName:(NSString *)headName;


-(void)addNibWithEntity:(id)str_Object andCellName:(NSString *)cellName;
-(void)addClassWithEntity:(id)str_Object andCellName:(NSString *)cellName;
-(void)addNibWithEntity:(id)str_Object andCellName:(NSString *)cellName andSection:(int)section;
-(void)addClassWithEntity:(id)str_Object andCellName:(NSString *)cellName andSection:(int)section;

-(void)clearAllData;//清空所有数据

-(void)interceptObjectEvent:(UIView *)view;
//移除indexPath的cell的高度缓存
-(void)removeHeightByIndexPath:(NSIndexPath *)indexPath;
//移除所有高度缓存
-(void)removeHeight;

-(void)setDidSelectRowAtIndexPath:(DidSelectRowAtIndexPath)didSelectRowAtIndexPath;
-(void)setCellAtIndexPath:(CellAtIndexPath)cellAtIndexPath;
-(void)setDidTouchTableView:(DidTouchTableView)didTouchTableView;


//插入一个cell
-(void)insertIndexPath:(NSIndexPath *)indexPath withNibWithEntity:(id)object andCellName:(NSString *)cellName withRowAnimation:(UITableViewRowAnimation)animation;
//移除一个cell
-(void)removeIndexPath:(NSIndexPath *)indexPath andCellName:(NSString *)cellName withRowAnimation:(UITableViewRowAnimation)animation;
-(void)removeIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;


@end
