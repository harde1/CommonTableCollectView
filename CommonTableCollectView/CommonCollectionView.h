//
//  CommonCollectionView.h
//  CollectIonViewTest
//
//  Created by cong on 15/10/5.
//  Copyright © 2015年 cong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonCollectionCell.h"

typedef void(^CollectionViewCellAtIndexPath)(UICollectionViewCell * cell, NSIndexPath * indexPath);
typedef void(^ViewForSupplementaryElementOfKindInSection)(UICollectionReusableView * view, NSString * king,NSInteger section);
typedef void(^DidSelectItemAtIndexPath)(NSIndexPath * indexPath);
typedef void(^DidTouchCollectionView)(UICollectionView * ctv);
typedef void(^MoveItemAtIndexPath)(UICollectionView * ctv,NSIndexPath * sourceIndexPath,NSIndexPath * destinationIndexPath);


@interface CommonCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>

//数据源
@property(nonatomic,strong)NSMutableArray * arr_dataSource;
@property(nonatomic,strong)NSMutableDictionary * dict_dataSourceHeader;


@property(nonatomic,strong)NSMutableDictionary * dict_heightSave;
@property(nonatomic,strong)NSMutableDictionary * dict_headerSizeSave;


@property(nonatomic,strong)NSArray * arr_sectionHeaderHeight;
@property(nonatomic,strong)NSMutableDictionary * dict_insetForSection;
//cell设置,identifier
@property(nonatomic,strong)NSMutableArray * arr_identifierConfig;

@property(nonatomic,strong)NSMutableDictionary * dict_identifierHeader;


@property(nonatomic,strong)UICollectionViewCell * cell_temp;
@property(nonatomic,strong)UICollectionReusableView * revTemp;

@property(nonatomic,assign)CGSize itemSize;
@property(nonatomic,assign)CGSize headSize;

//block，给cell附加方法
@property(nonatomic,copy)CollectionViewCellAtIndexPath collectionViewCellAtIndexPath;
@property(nonatomic,copy)ViewForSupplementaryElementOfKindInSection viewForSupplementaryElementOfKindInSection;
@property(nonatomic,copy)DidSelectItemAtIndexPath didSelectItemAtIndexPath;
//触摸到就触发了，例如可以用来回收键盘
@property(nonatomic,copy)DidTouchCollectionView didTouchCollectionView;
//移动的计算
@property(nonatomic,copy)MoveItemAtIndexPath moveItemAtIndexPath;

@property(nonatomic)BOOL closeAutoReload;

-(void)setSection:(NSInteger)section withInset:(UIEdgeInsets)inset;

//insetForSectionAtIndex
-(void)addNibWithEntity:(id)str_Object andCellName:(NSString *)cellName;
-(void)addClassWithEntity:(id)str_Object andCellName:(NSString *)cellName;

-(void)addNibWithEntity:(id)str_Object andCellName:(NSString *)cellName andSection:(int)section;
-(void)addClassWithEntity:(id)str_Object andCellName:(NSString *)cellName andSection:(int)section;

//清空所有数据
-(void)clearAllData;
//移除indexpath所在的item的size缓存
-(void)removeSizeByIndexPath:(NSIndexPath *)indexPath;
//移除所有size的缓存
-(void)removeSize;

//插入一个item和移除一个item
-(void)insertIndexPath:(NSIndexPath *)indexPath withNibWithEntity:(id)object andCellName:(NSString *)cellName;

-(void)moveItemFromIndexPath:(NSIndexPath *)fromIndexPath toNewIndexPath:(NSIndexPath *)newIndexPath andBlock:(void(^)(NSInteger state))stateBlock;

//进行判断类型是否准确再删除
-(void)removeIndexPath:(NSIndexPath *)indexPath andCellName:(NSString *)cellName;

-(void)removeIndexPath:(NSIndexPath *)indexPath;

//didSelect和itemforIndexpath的block
-(void)commonCollectionViewCellAtIndexPath:(CollectionViewCellAtIndexPath)cellAtIndexPath andDidSelectRowAtIndexPath:(DidSelectItemAtIndexPath)didSelectRowAtIndexPath;

//插入头
-(void)addHeaderNibWithEntity:(id)str_Object andViewName:(NSString *)viewName andSection:(int)section;
-(void)addHeaderClassWithEntity:(id)str_Object andViewName:(NSString *)viewName andSection:(int)section;
//头数据源头处理位置
-(void)setViewForSupplementaryElementOfKindInSection:(ViewForSupplementaryElementOfKindInSection)viewForSupplementaryElementOfKindInSection;

-(void)setMoveItemAtIndexPath:(MoveItemAtIndexPath)moveItemAtIndexPath;


@end
