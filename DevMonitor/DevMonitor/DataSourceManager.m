//
//  DataSourceManager.m
//  DevMonitor
//
//  Created by tiezhang on 15/3/28.
//  Copyright (c) 2015年 iXcoder. All rights reserved.
//

#import "DataSourceManager.h"

#define kname       @"name"
#define kcode       @"code"
#define kcaption    @"caption"
#define koptions    @"options"

@interface DataSourceManager ()

@property(nonatomic, strong)NSArray *localDatas;

@end

@implementation DataSourceManager

static DataSourceManager *g_manangerObj;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_manangerObj = [[DataSourceManager alloc]init];
    });
    
    return g_manangerObj;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"newconditions" ofType:@"plist"];
        if (!path)
        {
            self.localDatas = nil;
        }
        else
        {
            NSDictionary *condDic   = [NSDictionary dictionaryWithContentsOfFile:path];
            NSArray *menus          = condDic[@"menus"];
            NSMutableArray *tmpArr  = [NSMutableArray arrayWithCapacity:[menus count]];
            for (NSDictionary *dict in menus)
            {
                InfoItemDataModel *itemInfo = [[InfoItemDataModel alloc]init];
                [self fillData:dict desItem:&itemInfo];
                [tmpArr addObject:itemInfo];
            }
            self.localDatas = [NSArray arrayWithArray:tmpArr];
        }
    }
    return self;
}

//递归调用组织数据
- (void)fillData:(NSDictionary*)dictInfo desItem:(InfoItemDataModel**)model
{
    (*model).code = dictInfo[kcode];
    (*model).name = dictInfo[kname];
    (*model).caption = dictInfo[kcaption];
    NSArray *options = dictInfo[koptions];
    
    if([options count] <= 0)
    {
        return;
    }
    else
    {
        NSMutableArray *optionVals = [NSMutableArray arrayWithCapacity:[options count]];
        for (NSDictionary *dict in options)
        {
            InfoItemDataModel *itemInfo = [[InfoItemDataModel alloc]init];
            itemInfo.code = dict[kcode];
            itemInfo.name = dict[kname];
            itemInfo.caption    = dict[kcaption];
            NSArray *subOptions = dictInfo[koptions];
            if([subOptions count] > 0)
            {
                [self fillData:dict desItem:&itemInfo];
            }
            
            [optionVals addObject:itemInfo];
        }
        (*model).options = optionVals;
    }
}

//获取某一级菜单下所有的数据
- (InfoItemDataModel*)datasForMenuIndex:(NSInteger)menuIndex
{
    if(menuIndex >= [self.localDatas count])
    {
        return nil;
    }
    
    else
    {
        return self.localDatas[menuIndex];
    }
}

/**
 *  @desc   获取某一级菜单下 右侧对应层级数据
 *  @param  menuIndex：一级菜单索引
 *  @return 返回对应的InfoItemDataModel数据集合
 *  @note   此方法用于右侧选项有子集菜单，选中后获取下一层级的数据
 */
- (NSArray*)datasForNextLevel:(InfoItemDataModel*)desData
{
    return desData.options;
}

@end
