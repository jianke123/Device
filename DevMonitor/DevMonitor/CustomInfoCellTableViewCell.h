//
//  CustomInfoCellTableViewCell.h
//  DevMonitor
//
//  Created by tiezhang on 15/3/28.
//  Copyright (c) 2015年 iXcoder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoItemDataModel.h"

@interface CustomInfoCellTableViewCell : UITableViewCell

- (void)updateUIWithModel:(InfoItemDataModel*)model accessoryType:(UITableViewCellAccessoryType)accessoryType;

@end
