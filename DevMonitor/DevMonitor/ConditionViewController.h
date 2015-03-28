//
//  ConditionViewController.h
//  DevMonitor
//
//  Created by iXcoder on 15/3/27.
//  Copyright (c) 2015年 iXcoder. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *ConditionTypeVolumn;
extern NSString *ConditionTypePressure;
extern NSString *ConditionTypeXiangshu;
extern NSString *ConditionTypeGaoyapeizhi;
extern NSString *ConditionTypeBianyaqipeizhi;
extern NSString *ConditionTypeBianyaqi;
extern NSString *ConditionTypeGaoya;
extern NSString *ConditionTypeDiya;

typedef NSString * ConditionType;
typedef void (^ConditionSelection) (NSDictionary *);

@interface ConditionViewController : UIViewController


@property (nonatomic, strong) NSMutableArray *conditions;
@property (nonatomic, assign) ConditionType condType;
@property (nonatomic, strong) NSString *dftValue;

@property (nonatomic, assign) NSInteger menuIndex;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, strong) ConditionSelection callback;

@end
