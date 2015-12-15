//
//  Cell_ Essence_1.h
//  WuKongUserClient
//
//  Created by 悟空设计部 on 15/10/22.
//  Copyright © 2015年 cong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "CommonTableCollectView.h"
@interface Cell_Essence_1 : CommonCell
@property (weak, nonatomic) IBOutlet UIImageView *iv_left;
@property (weak, nonatomic) IBOutlet UILabel *lb_titles;
@property (weak, nonatomic) IBOutlet UIButton *btn_share;
@property (weak, nonatomic) IBOutlet UIButton *btn_share_action;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;

@property (weak, nonatomic) IBOutlet UILabel *lbContent;


@end
