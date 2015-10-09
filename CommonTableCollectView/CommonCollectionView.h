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
typedef void(^DidSelectItemAtIndexPath)(NSIndexPath * indexPath);
typedef void(^DidTouchCollectionView)(UICollectionView * ctv);

@interface CommonCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>

//数据源
@property(nonatomic,strong)NSMutableArray * arr_dataSource;
@property(nonatomic,strong)NSMutableDictionary * dict_heightSave;
@property(nonatomic,strong)NSArray * arr_sectionHeaderHeight;
@property(nonatomic,strong)NSMutableArray * arr_insetForSection;
@property(nonatomic,strong)NSMutableArray * arr_identifierConfig;//cell设置,identifier
@property(nonatomic,strong)UICollectionViewCell * cell_temp;

@property(nonatomic,assign)CGSize itemSize;

//block
@property(nonatomic,copy)CollectionViewCellAtIndexPath collectionViewCellAtIndexPath; //给cell附加方法
@property(nonatomic,copy)DidSelectItemAtIndexPath didSelectItemAtIndexPath;
@property(nonatomic,copy)DidTouchCollectionView didTouchCollectionView; //触摸到就触发了，例如可以用来回收键盘

@property(nonatomic)BOOL closeAutoReload;

//insetForSectionAtIndex
-(void)addNibWithEntity:(id)str_Object andCellName:(NSString *)cellName;
-(void)addClassWithEntity:(id)str_Object andCellName:(NSString *)cellName;

-(void)addNibWithEntity:(id)str_Object andCellName:(NSString *)cellName andSection:(int)section;
-(void)addClassWithEntity:(id)str_Object andCellName:(NSString *)cellName andSection:(int)section;

//清空数据
-(void)clearAllData;//清空所有数据
-(void)removeSizeByIndexPath:(NSIndexPath *)indexPath;//移除indexpath所在的item的size缓存
-(void)removeSize;//移除所有size的缓存

//插入一个item和移除一个item
-(void)insertIndexPath:(NSIndexPath *)indexPath withNibWithEntity:(id)object andCellName:(NSString *)cellName;

-(void)removeIndexPath:(NSIndexPath *)indexPath andCellName:(NSString *)cellName;//进行判断类型是否准确再删除

-(void)removeIndexPath:(NSIndexPath *)indexPath;

//didSelect和itemforIndexpath的block
-(void)commonCollectionViewCellAtIndexPath:(CollectionViewCellAtIndexPath)cellAtIndexPath andDidSelectRowAtIndexPath:(DidSelectItemAtIndexPath)didSelectRowAtIndexPath;
@end
