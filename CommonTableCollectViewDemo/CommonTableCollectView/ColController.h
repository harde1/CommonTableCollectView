//
//  ColController.h
//  CommonTableCollectView
//
//  Created by 悟空设计部 on 15/10/31.
//  Copyright © 2015年 cong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColController : UIViewController
@property(nonatomic,strong)NSIndexPath * selectedIndexPath;
@property(nonatomic,strong)NSIndexPath * tempIndexPath;
@property(nonatomic,strong)NSDictionary * loadTag;
@property(nonatomic,strong)UIView * view_select;
@end
