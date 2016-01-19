//
//  CHTTuiJianListCell.h
//  ChaHuiTongH
//
//  Created by 锡哥 on 16/1/19.
//  Copyright © 2016年 ChaXinKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonCell.h"

@interface CHTTuiJianListCell : CommonCell
@property (weak, nonatomic) IBOutlet UIImageView *ivTop;

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;

@end
