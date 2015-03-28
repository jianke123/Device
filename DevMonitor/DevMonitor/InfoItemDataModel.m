//
//  InfoDataModel.m
//  DevMonitor
//
//  Created by tiezhang on 15/3/28.
//  Copyright (c) 2015年 iXcoder. All rights reserved.
//

#import "InfoItemDataModel.h"

@implementation InfoItemDataModel


- (BOOL)hasDetail
{
    return [self.options count] > 0;
}

@end
