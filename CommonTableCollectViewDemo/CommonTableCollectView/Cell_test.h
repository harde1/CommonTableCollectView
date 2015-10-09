//
//  Cell_test.h
//  CommonTableCollectView
//
//  Created by cong on 15/10/9.
//  Copyright © 2015年 cong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonCell.h"
@interface Cell_test : CommonCell
@property (weak, nonatomic) IBOutlet UILabel *lb_test;
-(void)commonTableView:(CommonTableView *)tableView inViewController:(id)viewController cellForIndexPath:(NSIndexPath *)indexPath;

@end
