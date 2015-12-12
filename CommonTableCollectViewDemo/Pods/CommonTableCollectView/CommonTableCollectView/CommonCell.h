//
//  CommonCell.h
//  PudiEdu
//
//  Created by cong on 15/10/4.
//  Copyright © 2015年 cong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommonTableView;

@interface CommonCell : UITableViewCell
@property(strong,nonatomic)id params;
@property(strong,nonatomic)NSIndexPath * myIndexPath;
@property(weak,nonatomic)CommonTableView * tableView;


-(void)commonTableView:(CommonTableView *)tableView inViewController:(UIViewController *)viewController didSelectCellAtIndexPath:(NSIndexPath *)indexPath;

-(void)commonTableView:(CommonTableView *)tableView inViewController:(UIViewController *)viewController cellForIndexPath:(NSIndexPath *)indexPath;
//编辑模式B
- (void)commonTableView:(CommonTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;


@end
