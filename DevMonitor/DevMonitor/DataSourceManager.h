//
//  DataSourceManager.h
//  DevMonitor
//
//  Created by tiezhang on 15/3/28.
//  Copyright (c) 2015年 iXcoder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfoItemDataModel.h"

@interface DataSourceManager : NSObject

+ (instancetype)shareInstance;

//获取某一级菜单下所有的数据
- (InfoItemDataModel*)datasForMenuIndex:(NSInteger)menuIndex;

/**
 *  @desc   获取某一级菜单下 右侧对应层级数据
 *  @param  desData：当前层级点击选中的对象
 *  @return 返回对应的InfoItemDataModel数据集合
 *  @note   此方法用于右侧选项有子集菜单，选中后获取下一层级的数据
 */
- (NSArray*)datasForNextLevel:(InfoItemDataModel*)desData;

@end
