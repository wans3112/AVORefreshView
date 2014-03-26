//
//  GetMoreCell.h
//  Avolo
//
//  Created by wangbin on 14-1-14.
//  Copyright (c) 2014年 wans. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GetMoreCell_CellHeight 44
#define GetMoreCell_CellIdentifier @"GetMoreCell"

@interface GetMoreCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *moreLabel,*loadingLabel;
@property (retain, nonatomic) IBOutlet UIView *loadView;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end
