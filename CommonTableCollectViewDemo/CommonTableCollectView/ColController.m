//
//  ColController.m
//  CommonTableCollectView
//
//  Created by 悟空设计部 on 15/10/31.
//  Copyright © 2015年 cong. All rights reserved.
//

#import "ColController.h"
#import "CommonCollectionView.h"
#import "Rev_col.h"

@interface ColController ()
@property (weak, nonatomic) IBOutlet CommonCollectionView *cv_text;

@end

@implementation ColController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGSize size = {100,200};
//    _cv_text.headSize = size;
    
    
    [_cv_text addHeaderNibWithEntity:@{@"title":@"第1个头"} andViewName:@"Rev_col" andSection:0];
    for (int i=0; i<10; i++) {
    
        [_cv_text addNibWithEntity:@{} andCellName:@"Cell_col"];
        
    }
     [_cv_text addHeaderNibWithEntity:@{@"title":@"第2个头"} andViewName:@"Rev_col" andSection:1];
    
    for (int i=0; i<10; i++) {
    
        [_cv_text addNibWithEntity:@{} andCellName:@"Cell_col" andSection:1];
        
    }
    
    [_cv_text setViewForSupplementaryElementOfKindInSection:^(UICollectionReusableView *view, NSString *king, NSInteger section) {
        
        Rev_col * rev_col = (Rev_col *)view;
        
        rev_col.lb_text.text = @"11111";
        
        
       
        
    }];
    
}



@end
