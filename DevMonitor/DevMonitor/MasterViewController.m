//
//  MasterViewController.m
//  DevMonitor
//
//  Created by iXcoder on 15/3/27.
//  Copyright (c) 2015年 iXcoder. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"


@interface MasterViewController ()

@property (nonatomic, strong) NSIndexPath *lastIndex;
@property (nonatomic, strong) NSMutableArray *conditions;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"设备选型";
    self.conditions = [NSMutableArray array];
    [self.conditions addObject:@{@"name":@"容量(KVA)", @"key":ConditionTypeVolumn}];
    [self.conditions addObject:@{@"name":@"电压等级(KV)", @"key":ConditionTypePressure}];
    [self.conditions addObject:@{@"name":@"相数", @"key":ConditionTypeXiangshu}];
    [self.conditions addObject:@{@"name":@"高压配置型式", @"key":ConditionTypeGaoyapeizhi}];
    [self.conditions addObject:@{@"name":@"变压器配置型式", @"key":ConditionTypeBianyaqipeizhi}];
    [self.conditions addObject:@{@"name":@"变压器", @"key":ConditionTypeBianyaqi}];
    [self.conditions addObject:@{@"name":@"高压", @"key":ConditionTypeGaoya}];
    [self.conditions addObject:@{@"name":@"低压", @"key":ConditionTypeDiya}];
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.conditions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *item = self.conditions[indexPath.row];
    cell.textLabel.text = [item objectForKey:@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath != self.lastIndex)
    {
        [self.detailViewController popToRoot];
    }

    
    NSDictionary *item = [self.conditions objectAtIndex:indexPath.row];
    ConditionType type = [item objectForKey:@"key"];
    if (![self.detailViewController canShowConditionSelection:type]) {
        return ;
    }
    if (self.lastIndex) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.lastIndex];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    self.lastIndex = indexPath;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.lastIndex];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    [self.detailViewController showConditionSelection:type];
    [self.detailViewController showConditionSelection:[NSString stringWithFormat:@"%d", indexPath.row]];
}

@end
