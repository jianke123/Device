//
//  MasterViewController.h
//  DevMonitor
//
//  Created by iXcoder on 15/3/27.
//  Copyright (c) 2015年 iXcoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end

