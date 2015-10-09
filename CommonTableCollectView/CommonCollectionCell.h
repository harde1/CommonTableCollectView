//
//  CommonCollectionCell.h
//  CollectIonViewTest
//
//  Created by cong on 15/10/5.
//  Copyright © 2015年 cong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommonCollectionView;
@interface CommonCollectionCell : UICollectionViewCell

@property(strong,nonatomic)id params;
@property(strong,nonatomic)NSIndexPath * myIndexPath;

-(void)commonCollectionView:(CommonCollectionView *)commonCollectionView inViewController:(id)viewController didSelectCellAtIndexPath:(NSIndexPath *)indexPath;


-(void)commonCollectionView:(CommonCollectionView *)commonCollectionView inViewController:(id)viewController cellForIndexPath:(NSIndexPath *)indexPath;
@end
