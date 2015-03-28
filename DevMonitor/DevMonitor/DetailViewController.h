//
//  DetailViewController.h
//  DevMonitor
//
//  Created by iXcoder on 15/3/27.
//  Copyright (c) 2015年 iXcoder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConditionViewController.h"

@interface DetailViewController : UIViewController

- (BOOL)canShowConditionSelection:(ConditionType)type;
- (void)showConditionSelection:(ConditionType)type;

- (void)popToRoot;

@end

