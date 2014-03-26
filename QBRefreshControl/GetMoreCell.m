//
//  GetMoreCell.m
//  Avolo
//
//  Created by wangbin on 14-1-14.
//  Copyright (c) 2014年 wans. All rights reserved.
//

#import "GetMoreCell.h"

@implementation GetMoreCell
@synthesize loadingLabel,moreLabel;
@synthesize loadView;
@synthesize indicator;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [super dealloc];
}
@end
