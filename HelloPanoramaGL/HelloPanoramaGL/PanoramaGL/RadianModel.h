//
//  RadianModel.h
//  ZGTest
//
//  Created by Dehua Pan on 14-7-25.
//  Copyright (c) 2014年 Dehua Pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadianModel : NSObject

@property (nonatomic,assign) NSInteger horizontal;//横向弧度
@property (nonatomic,assign) NSInteger vertical;  //纵向弧度
@property (nonatomic,strong) NSMutableArray * modelArray;

/**
 *  获取model数组: 数组存放的是RadianModel
 *
 */
+ (NSArray *)getModelArray;

@end
