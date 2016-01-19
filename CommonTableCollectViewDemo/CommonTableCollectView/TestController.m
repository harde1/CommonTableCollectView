//
//  TestController.m
//  CommonTableCollectView
//
//  Created by wukong on 16/1/19.
//  Copyright © 2016年 cong. All rights reserved.
//

#import "TestController.h"

@implementation TestController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    for (int i=0; i<10; i++) {
        [_tvTest addNibWithEntity:@{@"参数1":@"参数就是entity     参数就是entity",@"参数2":@"参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity参数就是entity",@"参数3":@"参数就是entity",@"参数4":@"参数就是entity",@"参数5":@"参数就是entity"} andCellName:@"CHTTuiJianListCell"];
    }
}

@end
