//
//  RadianModel.m
//  ZGTest
//
//  Created by Dehua Pan on 14-7-25.
//  Copyright (c) 2014年 Dehua Pan. All rights reserved.
//

#import "RadianModel.h"

@implementation RadianModel



+ (RadianModel *)changeToRadianWithSize:(CGSize)size
{
    RadianModel * model = [[RadianModel alloc] init];
    model.horizontal = size.width/512*180;
    model.vertical   = size.height/256*90;
    NSLog(@"model.h===%d,model.v===%d",model.horizontal,model.vertical);
    
    return model;
}

+ (NSArray *)getModelArray
{
    RadianModel * radian = [[RadianModel alloc] init];
    radian.modelArray = [[NSMutableArray alloc] init];
    [self changeWithArray:radian.modelArray];
    
    return radian.modelArray;
}

+ (void)changeWithArray:(NSMutableArray *)array;
{
    
    [array addObject:[self changeToRadianWithSize:CGSizeMake(512-232, 0)]];//44-77
    [array addObject:[self changeToRadianWithSize:CGSizeMake(512-215, 0)]];//44-88
    [array addObject:[self changeToRadianWithSize:CGSizeMake(184-512, 0)]];//44-00
    [array addObject:[self changeToRadianWithSize:CGSizeMake(35-512, 165-256)]];//77-44
    [array addObject:[self changeToRadianWithSize:CGSizeMake(180-512, 140-256)]];//88-44
    [array addObject:[self changeToRadianWithSize:CGSizeMake(512-150, 155-256)]];//00-44
//    [array addObject:[self changeToRadianWithSize:CGSizeMake(512-200, 227-256)]];//44
//    [array addObject:[self changeToRadianWithSize:CGSizeMake(-512+35, 207-256)]];//55
//    [array addObject:[self changeToRadianWithSize:CGSizeMake(512-240, 140-256)]];//66
//    [array addObject:[self changeToRadianWithSize:CGSizeMake(-512+35, 170-256)]];//77
//    [array addObject:[self changeToRadianWithSize:CGSizeMake(-512+185, 140-256)]];//88
//    [array addObject:[self changeToRadianWithSize:CGSizeMake(330-512, 140-256)]];//99
}

@end
