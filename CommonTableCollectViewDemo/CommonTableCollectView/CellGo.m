//
//  CellGo.m
//  CommonTableCollectView
//
//  Created by wukong on 15/12/15.
//  Copyright © 2015年 cong. All rights reserved.
//

#import "CellGo.h"
#import "ViewController.h"
#import "ColController.h"

@implementation CellGo

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _lbGo = [UILabel new];
        [self.contentView addSubview:_lbGo];
        UIEdgeInsets inset = {0,20,0,20};
        [_lbGo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).with.insets(inset);
            make.height.mas_equalTo(@44).with.priority(800);
        }];
        
    }
    return self;
}

-(void)commonTableView:(CommonTableView *)tableView inViewController:(UIViewController *)viewController cellForIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * dictParams = self.params;
    _lbGo.text = dictParams[@"title"];
    
}

-(void)commonTableView:(CommonTableView *)tableView inViewController:(UIViewController *)viewController didSelectCellAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController * vc = nil;
    if ([self.params[@"title"] rangeOfString:@"tableView"].location != NSNotFound) {
        vc = [viewController.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    }else if ([self.params[@"title"] rangeOfString:@"CollectionView"].location != NSNotFound) {
        vc = [viewController.storyboard instantiateViewControllerWithIdentifier:@"ColController"];
    }else{
        
        vc = [viewController.storyboard instantiateViewControllerWithIdentifier:@"PicController"];
    }
    
    [viewController.navigationController pushViewController:vc animated:YES];
}
@end
