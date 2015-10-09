//
//  Cell_test.m
//  CommonTableCollectView
//
//  Created by cong on 15/10/9.
//  Copyright © 2015年 cong. All rights reserved.
//

#import "Cell_test.h"

@implementation Cell_test

- (void)awakeFromNib {
    
}


-(void)setParams:(id)params{
    [super setParams:params];
    
    if (params) {
        NSDictionary * dict = params;
        
        
        self.lb_test.text = dict[@"内容"];
        
        
    }
    
}

-(void)commonTableView:(CommonTableView *)tableView inViewController:(id)viewController cellForIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"cellForIndexPath事件！！！！！！！");
}


-(void)commonTableView:(CommonTableView *)tableView inViewController:(id)viewController didSelectCellAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"didSelectCellAtIndexPath点击事件！！！！！！！");
}


@end
