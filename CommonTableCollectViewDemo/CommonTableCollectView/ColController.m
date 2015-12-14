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
#import "Cell_col.h"

@interface ColController ()
@property (weak, nonatomic) IBOutlet CommonCollectionView *cv_text;
@property(strong,nonatomic)UILabel * lbTest;
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
    
    //    [_cv_text setViewForSupplementaryElementOfKindInSection:^(UICollectionReusableView *view, NSString *king, NSInteger section) {
    //        Rev_col * rev_col = (Rev_col *)view;
    //        rev_col.lb_text.text = @"11111";
    //    }];
    
    //    UILongPressGestureRecognizer * longG = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongGesture:)];
    //    [_cv_text addGestureRecognizer:longG];
    
}


- (void)handleLongGesture:(UILongPressGestureRecognizer *)gesture {
    UIViewController * vc = self;
    switch (gesture.state) {
        case UIGestureRecognizerStatePossible: {
            break;
        }
        case UIGestureRecognizerStateBegan: {
            //选择到谁了
            
            CGPoint p = [gesture locationInView:_cv_text];
            
            NSIndexPath * selectedIndexPath = [_cv_text indexPathForItemAtPoint:p];
            
            if (!selectedIndexPath) {
                return;
            }
            
            self.selectedIndexPath = selectedIndexPath;
            self.loadTag = _cv_text.arr_dataSource[selectedIndexPath.section][selectedIndexPath.row];
            
            Cell_col * cell = (Cell_col *)[_cv_text cellForItemAtIndexPath:selectedIndexPath];
            
            UIView * v_select = [[UIView alloc]initWithFrame:cell.frame];
            self.view_select = v_select;
            
            v_select.backgroundColor = [UIColor redColor];
            [_cv_text addSubview:self.view_select];
            
            //            [UtilUIHelper setRoundView:v_select WithCornerRadius:75/5 andBoaderColor:MAIN_COLOR andBoaderWidth:1 andBoaderNeed:YES];
            
            //            UILabel * lb = [UILabel new];
            //            [vc.view_select addSubview:lb];
            //            lb.frame = cell.lb_Tag.frame;
            //            lb.text = cell.lb_Tag.text;
            //            lb.backgroundColor = cell.lb_Tag.backgroundColor;
            //            lb.textColor = cell.lb_Tag.textColor;
            //            lb.textAlignment = NSTextAlignmentCenter;
            
            [_cv_text removeIndexPath:selectedIndexPath andCellName:@"Cell_col"];
            
            break;
        }
        case UIGestureRecognizerStateChanged: {
            
            if (!self.selectedIndexPath) {
                return;
            }
            
            CGPoint p = [gesture locationInView:gesture.view];
            
            self.view_select.center = p;
            
            NSIndexPath * moveToIndexPath = [_cv_text indexPathForItemAtPoint:p];
            
            if (moveToIndexPath&&!self.tempIndexPath&&[moveToIndexPath compare:self.selectedIndexPath]!=NSOrderedSame) {
                [_cv_text insertIndexPath:moveToIndexPath withNibWithEntity:self.loadTag andCellName:@"Cell_col"];
                self.tempIndexPath = moveToIndexPath;
                
            }else{
                if (self.tempIndexPath) {
                    [_cv_text removeIndexPath:self.tempIndexPath andCellName:@"Cell_col"];
                    self.tempIndexPath = nil;
                }
            }
            
            break;
        }
        case UIGestureRecognizerStateEnded: {
            
            [self endSelected:gesture andVc:vc];
            
            break;
        }
        default:{
            
            [self endSelected:gesture andVc:vc];
            break;
        }
    }
}

- (void)endSelected:(UILongPressGestureRecognizer *)gesture andVc:(UIViewController *)vc {
    if (!self.selectedIndexPath) {
        
        return;
    }
    
    CGPoint p = [gesture locationInView:gesture.view];
    NSIndexPath * moveToIndexPath = [_cv_text indexPathForItemAtPoint:p];
    if (self.tempIndexPath) {
        [_cv_text removeIndexPath:self.tempIndexPath andCellName:@"Cell_col"];
        self.tempIndexPath = nil;
    }
    if (moveToIndexPath) {
        [_cv_text insertIndexPath:moveToIndexPath withNibWithEntity:self.loadTag andCellName:@"Cell_col"];
    }else{
        [_cv_text insertIndexPath:self.selectedIndexPath withNibWithEntity:self.loadTag andCellName:@"Cell_col"];
        //最后一个的判断
    }
    
    [self.view_select removeFromSuperview];
    self.view_select = nil;
    
    //保存已经选择
    
    
}




@end
