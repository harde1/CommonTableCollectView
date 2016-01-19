//
//  CellImLeft.h
//  BiggerPai
//
//  Created by wukong on 16/1/15.
//  Copyright © 2016年 lhc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonCell.h"

@interface CellImLeft : CommonCell
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UIImageView *ivHead;


@property (weak, nonatomic) IBOutlet UILabel *lbTime;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *vLoading;
@property (weak, nonatomic) IBOutlet UIImageView *ivError;

@end
