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
@interface ViewController ()
@property (weak, nonatomic) IBOutlet CommonTableView *tv_test;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString * str = @"sjhkjadhfkjdhsjkfhdsjkfhjkdshfjkladshlfjkhdsjkfhdjkashfjkdshfkdjshfdsjasjhkjadhfk";
    for (int i=0; i<10; i++) {
         [_tv_test addNibWithEntity:@{@"内容":str} andCellName:NSStringFromClass([Cell_test class])];
        
         str = [str stringByAppendingString:str];
    }
    
   
    
}


@end
