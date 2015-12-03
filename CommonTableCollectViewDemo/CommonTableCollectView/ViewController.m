//
//  ViewController.m
//  CommonTableCollectView
//
//  Created by cong on 15/10/9.
//  Copyright © 2015年 cong. All rights reserved.
//

#import "ViewController.h"
#import "CommonTableView.h"
#import "Cell_test.h"
#import "VHead.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet CommonTableView *tv_test;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString * str = @"123";
    for (int i=0; i<10; i++) {
         [_tv_test addNibWithEntity:@{@"内容":str} andCellName:NSStringFromClass([Cell_test class])];
        
         str = [str stringByAppendingString:str];
    }
    
    
   
    [_tv_test insertIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] withNibWithEntity:@{@"内容":@"abc   我是插入的，我是插入的，我是插入的，我是插入的，我是插入的，"} andCellName:@"Cell_test" withRowAnimation:UITableViewRowAnimationNone];
    
    
    
//    VHead *vHead = [[[NSBundle mainBundle]loadNibNamed:@"VHead" owner:self options:nil] lastObject];
//    _tv_test.tableHeaderView = vHead;
//    
//    
//     [_tv_test addNibWithEntity:@{@"1":@"dasdasda",@"2":@"sdHSADJK"} andCellName:@"CellTest"];
//     [_tv_test addNibWithEntity:@{@"1":@"fsdafdasfdasda",@"2":@"sdHSAadksakDJK"}  andCellName:@"CellTest"];
//     [_tv_test addNibWithEntity:@{@"1":@"3123123dasd213213asda",@"2":@"sdHSADJK"}  andCellName:@"CellTest"];
//     [_tv_test addNibWithEntity:@{@"1":@"dasd3213123213asda",@"2":@"sdHSdjshakfjkdhsfkjhdsjkfhljadkshfjdashjADJK"}  andCellName:@"CellTest"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"加一个" style:UIBarButtonItemStylePlain target:self action:@selector(clickAdd:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"减一个" style:UIBarButtonItemStylePlain target:self action:@selector(clickRemove:)];
    
    
}


- (void)clickAdd:(id)sender {
	 [_tv_test insertIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] withNibWithEntity:@{@"内容":@"abc   我是插入的，我是插入的，我是插入的，我是插入的，我是插入的，"} andCellName:@"Cell_test" withRowAnimation:UITableViewRowAnimationNone];
}

- (void)clickRemove:(id)sender {
    [_tv_test removeIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] withRowAnimation:UITableViewRowAnimationNone];
}


@end
