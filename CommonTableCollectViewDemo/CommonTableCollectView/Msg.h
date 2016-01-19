//
//  Msg.h
//  BiggerPai
//
//  Created by wukong on 16/1/18.
//  Copyright © 2016年 lhc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Msg : NSObject
@property(nonatomic,assign)NSInteger state;//-1失败，0 在传 ，1成功
@property(nonatomic,copy)NSString * textBody;

@property(nonatomic,copy)NSString * createTime;
@end
