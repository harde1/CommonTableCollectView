//
//  GoController.m
//  CommonTableCollectView
//
//  Created by wukong on 15/12/15.
//  Copyright © 2015年 cong. All rights reserved.
//

#import "GoController.h"

@interface GoController ()

@end

@implementation GoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tvGo addClassWithEntity:@{@"title":@"通用型tableView怎么写"} andCellName:@"CellGo"];
    [_tvGo addClassWithEntity:@{@"title":@"通用型CollectionView怎么写"} andCellName:@"CellGo"];
    [_tvGo addClassWithEntity:@{@"title":@"图片懒加载怎么写"} andCellName:@"CellGo"];
}


@end
