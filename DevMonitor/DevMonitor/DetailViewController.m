//
//  DetailViewController.m
//  DevMonitor
//
//  Created by iXcoder on 15/3/27.
//  Copyright (c) 2015年 iXcoder. All rights reserved.
//

#import "DetailViewController.h"

@interface Device : NSObject

@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSString *deviceName;

@end

@implementation Device



@end


@interface DetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) BOOL pushed;

@property (nonatomic, strong) __block NSMutableDictionary *param;
@property (nonatomic, strong) ConditionSelection cs;

@property (nonatomic, strong) NSMutableArray *devices;
@property (nonatomic, weak) IBOutlet UITableView *ctntView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.param = [NSMutableDictionary dictionary];
    __weak DetailViewController *dvc = self;
    self.cs = ^(NSDictionary *param) {
        [dvc.param setObject:param[@"value"][@"code"] forKey:param[@"key"]];
        [dvc.navigationController popViewControllerAnimated:YES];
        dvc.pushed = NO;
    };
}

- (void)popToRoot
{
    self.pushed = NO;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Navigation method
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showCondSegue"]) {
        UIViewController *dest = segue.destinationViewController;
        [dest setValue:sender forKeyPath:@"condType"];
        [dest setValue:self.cs forKeyPath:@"callback"];
        if ([[self.param allKeys] containsObject:sender]) {
            NSString *dft = [self.param objectForKey:sender];
            [dest setValue:dft forKey:@"dftValue"];
        }
    }
}

#pragma mark -
#pragma mark self define method
- (BOOL)canShowConditionSelection:(ConditionType)type
{
    return !self.pushed;
}

- (void)showConditionSelection:(ConditionType)type
{
    [self performSegueWithIdentifier:@"showCondSegue" sender:type];
    self.pushed = YES;
}


#pragma mark -
#pragma mark UITableView dataSource method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.devices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *deviceCellId = @"device_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deviceCellId];
    Device *dev = [self.devices objectAtIndex:indexPath.row];
    NSString *text = [NSString stringWithFormat:@"%@[%@]", dev.deviceName, dev.deviceId];
    cell.textLabel.text = text;
    return cell;
}

@end
