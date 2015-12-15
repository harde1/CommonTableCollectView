//
//  Cell_ Essence_1.m
//  WuKongUserClient
//
//  Created by 悟空设计部 on 15/10/22.
//  Copyright © 2015年 cong. All rights reserved.
//

#import "Cell_Essence_1.h"


@implementation Cell_Essence_1

- (void)awakeFromNib {
    
    self.iv_left.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.];
}

-(void)commonTableView:(CommonTableView *)tableView inViewController:(id)viewController didSelectCellAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

-(void)commonTableView:(CommonTableView *)tableView scrollType:(ScrollType)scrollType{
    
    if (scrollType==scrollViewWillBeginDecelerating ||
        scrollType == scrollViewDidEndDecelerating  ||
        scrollType == scrollViewDidEndDragging
        ) {
        
        if (self.params) {
            
            [self.iv_left setImageWithURL:[NSURL URLWithString:self.params[@"pic"]] placeholderImage:nil];
            
        }
    }else{
        if (![self isShow]) {
            self.iv_left.image = nil;
        }
    }
}
@end
