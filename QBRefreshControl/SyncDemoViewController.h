//
//  SyncDemoViewController.h
//  QBRefreshControlDemo
//
//  Created by Katsuma Tanaka on 2012/12/08.
//  Copyright (c) 2012年 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QBRefreshControl.h"
#import "QBSimpleSyncRefreshControl.h"

@interface SyncDemoViewController : UITableViewController <QBRefreshControlDelegate>

{
    NSMutableArray *array;
    BOOL moreLoading;
}
@end
