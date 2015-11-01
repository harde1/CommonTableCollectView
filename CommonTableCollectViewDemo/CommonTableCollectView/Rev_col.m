//
//  Rev_col.m
//  CommonTableCollectView
//
//  Created by 悟空设计部 on 15/11/1.
//  Copyright © 2015年 cong. All rights reserved.
//

#import "Rev_col.h"

@implementation Rev_col

- (void)awakeFromNib {
    // Initialization code
}

-(void)setParams:(id)params{
    [super setParams:params];

    
    if (params) {
        self.lb_text.text = params[@"title"];
    }
}
@end
