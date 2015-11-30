//
//  CellTextView.m
//  CommonTableCollectView
//
//  Created by 悟空设计部 on 15/11/25.
//  Copyright © 2015年 cong. All rights reserved.
//

#import "CellTextView.h"
#import "CommonTableView.h"

@implementation CellTextView

- (void)awakeFromNib {
    // Initialization code
}


-(void)commonTableView:(CommonTableView *)tableView inViewController:(UIViewController *)viewController cellForIndexPath:(NSIndexPath *)indexPath{

    [tableView removeHeightByIndexPath:self.myIndexPath];

}
@end
