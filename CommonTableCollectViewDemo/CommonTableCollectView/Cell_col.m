//
//  Cell_col.m
//  CommonTableCollectView
//
//  Created by 悟空设计部 on 15/10/31.
//  Copyright © 2015年 cong. All rights reserved.
//

#import "Cell_col.h"
#import "Masonry.h"
@implementation Cell_col

- (void)awakeFromNib {

    [self.lb_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(60).with.priority(999);
        make.width.mas_equalTo(60).with.priority(999);
    }];
    
}

-(void)commonCollectionView:(CommonCollectionView *)commonCollectionView inViewController:(UIViewController *)viewController didSelectCellAtIndexPath:(NSIndexPath *)indexPath{

//    [commonCollectionView performBatchUpdates:^{
//    [commonCollectionView moveItemAtIndexPath:self.myIndexPath toIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
//    } completion:nil];
    [commonCollectionView removeIndexPath:self.myIndexPath];
}
@end
