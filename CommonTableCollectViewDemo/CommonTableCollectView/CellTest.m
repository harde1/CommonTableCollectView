//
//  CellTest.m
//  CommonTableCollectView
//
//  Created by 悟空设计部 on 15/11/24.
//  Copyright © 2015年 cong. All rights reserved.
//

#import "CellTest.h"

@implementation CellTest

- (void)awakeFromNib {
    // Initialization code
}

-(void)setParams:(id)params{
    [super setParams:params];

    if (params) {
        
        _LB1.text = params[@"1"];
        _lb2.text = params[@"2"];
    }
    
}


-(void)commonTableView:(CommonTableView *)tableView inViewController:(UIViewController *)viewController didSelectCellAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"点击了第%ld个",self.myIndexPath.row);


}

@end
