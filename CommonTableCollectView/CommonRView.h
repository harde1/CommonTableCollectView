//
//  CommonRView.h
//  Pods
//
//  Created by 悟空设计部 on 15/11/1.
//
//

#import <UIKit/UIKit.h>
#import "CommonCollectionView.h"
@interface CommonRView : UICollectionReusableView
@property(strong,nonatomic)id params;
@property(assign,nonatomic)NSInteger section;
-(void)commonCollectionView:(CommonCollectionView *)cv inViewController:(UIViewController *)vc viewForSupplementaryElementOfKind:(NSString *)king inSection:(NSInteger)section;
@end
