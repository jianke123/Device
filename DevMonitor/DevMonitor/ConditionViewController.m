
//
//  ConditionViewController.m
//  DevMonitor
//
//  Created by iXcoder on 15/3/27.
//  Copyright (c) 2015年 iXcoder. All rights reserved.
//
#import "ConditionViewController.h"
#import "CustomInfoCellTableViewCell.h"
#import "DataSourceManager.h"

const NSString *ConditionTypeVolumn             = @"volumn";
const NSString *ConditionTypePressure           = @"pressure";
const NSString *ConditionTypeXiangshu           = @"xiangshu";
const NSString *ConditionTypeGaoyapeizhi        = @"gaoyapeizhi";
const NSString *ConditionTypeBianyaqipeizhi     = @"bianyaqipeizhi";
const NSString *ConditionTypeBianyaqi           = @"bianyaqi";
const NSString *ConditionTypeGaoya              = @"gaoya";
const NSString *ConditionTypeDiya               = @"diya";

@interface ConditionViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSIndexPath *lastIndex;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, weak) IBOutlet UITableView *condTable;

@end

@implementation ConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.condTable.tableFooterView = [UIView new];
    
    self.navigationItem.backBarButtonItem = nil;
    self.navigationItem.leftItemsSupplementBackButton = YES;
    self.navigationItem.leftBarButtonItem = nil;
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(goBack:)];
    self.navigationItem.rightBarButtonItem = right;
    
    if(self.level == 0)
    {
        self.menuIndex = [self.condType integerValue];
        InfoItemDataModel *dataItem = [[DataSourceManager shareInstance] datasForMenuIndex:self.menuIndex];
        [self.conditions addObjectsFromArray:dataItem.options];
    }
    else
    {
//        NSArray *datas = [[DataSourceManager shareInstance] datasForNextLevel:<#(InfoItemDataModel *)#>];
//        [self.conditions addObjectsFromArray:dataItem.options];
    }
//    [self.conditions removeAllObjects];
//    NSArray *arr = [self loadConditionWithConditionType:self.condType];
//    if (arr.count > 0) {
//        [self.conditions addObjectsFromArray:arr];
//    }
    [self.condTable reloadData];
}

- (void)goBack:(id)sender
{
    if (self.callback) {
        NSDictionary *item = [self.conditions objectAtIndex:self.lastIndex.row];
        self.callback(@{@"key":self.condType, @"value":item});
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (NSArray *)loadConditionWithConditionType:(ConditionType)ct
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"conditions" ofType:@"plist"];
    if (!path) {
        return nil;
    }
    NSDictionary *condDic = [NSDictionary dictionaryWithContentsOfFile:path];
    self.title = [condDic objectForKey:ct][@"name"];
    self.caption = [condDic objectForKey:ct][@"caption"];
    return [condDic objectForKey:ct][@"options"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -
#pragma mark UITableViewDataSource method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.conditions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *condCellId = @"condCellId";
    CustomInfoCellTableViewCell *cell = (CustomInfoCellTableViewCell*)[tableView dequeueReusableCellWithIdentifier:condCellId];
    if (!cell) {
        cell = [[CustomInfoCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:condCellId];
    }
    
    InfoItemDataModel *item = [self.conditions objectAtIndex:indexPath.row];
    NSArray *options = item.options;
    BOOL isDft = self.dftValue && [item.code isEqualToString:self.dftValue];
    UITableViewCellAccessoryType type = UITableViewCellAccessoryNone;
    if([options count] > 0)
    {
        type = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        type = isDft ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
    [cell updateUIWithModel:item accessoryType:type];

    if (isDft)
    {
        self.lastIndex = indexPath;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary *item = [self.conditions objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    InfoItemDataModel *item = [self.conditions objectAtIndex:indexPath.row];
    if(item.hasDetail)
    {
        ConditionViewController *cvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ConditionViewController"];
//        cvc.condType = @"options";
        cvc.level = ++self.level;

        NSArray *datas = [[DataSourceManager shareInstance] datasForNextLevel:item];
        if([datas count] > 0)
        {
            [cvc.conditions addObjectsFromArray:datas];
        }
        [self.navigationController pushViewController:cvc animated:YES];
        
        return;
    }
    
    if (self.lastIndex)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.lastIndex];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    self.lastIndex = indexPath;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.lastIndex];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.caption;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.f;
}

- (NSMutableArray*)conditions
{
    if(!_conditions)
    {
        _conditions = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _conditions;
}

@end
