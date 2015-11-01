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

@end
