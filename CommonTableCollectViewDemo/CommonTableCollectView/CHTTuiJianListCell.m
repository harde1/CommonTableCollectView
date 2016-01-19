//
//  CHTTuiJianListCell.m
//  ChaHuiTongH
//
//  Created by 锡哥 on 16/1/19.
//  Copyright © 2016年 ChaXinKeJi. All rights reserved.
//

#import "CHTTuiJianListCell.h"

@implementation CHTTuiJianListCell

- (void)awakeFromNib {
    
}
//获取当前的ViewController,这个方法在这里面常用
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


-(void)commonTableView:(CommonTableView *)tableView inViewController:(UIViewController *)viewController cellForIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"传进来的参数是什么%@",self.params);
    
    self.lbTitle.text = self.params[@"参数1"];
    self.lbContent.text = self.params[@"参数2"];
    
}
-(void)commonTableView:(CommonTableView *)tableView inViewController:(UIViewController *)viewController didSelectCellAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击了第几个%ld",indexPath.row);
    
}
@end
