//
//  CellTextView.h
//  CommonTableCollectView
//
//  Created by 悟空设计部 on 15/11/25.
//  Copyright © 2015年 cong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonCell.h"
@interface CellTextView : CommonCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constH;
@property (weak, nonatomic) IBOutlet UITextView *tfvTest;
@property (weak, nonatomic) IBOutlet UILabel *lbText;

@end
