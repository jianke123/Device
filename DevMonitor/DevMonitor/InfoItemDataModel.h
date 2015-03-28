//
//  InfoDataModel.h
//  DevMonitor
//
//  Created by tiezhang on 15/3/28.
//  Copyright (c) 2015年 iXcoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoItemDataModel : NSObject

@property(nonatomic, strong)NSString *code;
@property(nonatomic, strong)NSString *name;     //要展示的文本
@property(nonatomic, strong)NSString *caption;  //要显示的主题
@property(nonatomic, strong)NSArray *options;   //子项数据，其中itemClass->InfoDataModel

@property(nonatomic, assign, readonly)BOOL hasDetail;

@end
