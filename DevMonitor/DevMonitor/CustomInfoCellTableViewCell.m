//
//  CustomInfoCellTableViewCell.m
//  DevMonitor
//
//  Created by tiezhang on 15/3/28.
//  Copyright (c) 2015年 iXcoder. All rights reserved.
//

#import "CustomInfoCellTableViewCell.h"

@implementation CustomInfoCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
//        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    return self;
}

- (void)updateUIWithModel:(InfoItemDataModel*)model accessoryType:(UITableViewCellAccessoryType)accessoryType
{
    self.textLabel.text = model.name;
    self.accessoryType = accessoryType;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
