//
//  SyncDemoViewController.m
//  QBRefreshControlDemo
//
//  Created by Katsuma Tanaka on 2012/12/08.
//  Copyright (c) 2012年 Katsuma Tanaka. All rights reserved.
//

#import "SyncDemoViewController.h"
#import "GetMoreCell.h"

@interface SyncDemoViewController ()

@property (nonatomic, retain) QBSimpleSyncRefreshControl *myRefreshControl;

@end

@implementation SyncDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent=NO;
    // Refresh Control
    QBSimpleSyncRefreshControl *refreshControl = [[QBSimpleSyncRefreshControl alloc] init];
    refreshControl.delegate = self;
    refreshControl.backgroundColor=[UIColor clearColor];
    [self.tableView addSubview:refreshControl];
    self.myRefreshControl = refreshControl;
    [refreshControl release];
    
    array=[[NSMutableArray alloc]init];
    for (int i = 0; i<10; i++) {
        [array addObject:[NSString stringWithFormat:@"cell + %d",i]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - QBRefreshControlDelegate

- (void)refreshControlDidBeginRefreshing:(QBRefreshControl *)refreshControl
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
       
        NSMutableArray *insertIndexPaths = [NSMutableArray array];
        int count=array.count;
        for (int i=count;i<count+2;i++) {
            NSIndexPath *newPath = [NSIndexPath indexPathForRow:i-count inSection:0];
            [insertIndexPaths addObject:newPath];
            [array insertObject:[NSString stringWithFormat:@"cell + %d",i-count] atIndex:i-count];
        }
        [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
        
        [self.myRefreshControl endRefreshing];
   
    });
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"开始下载 call back, the data is");
//
//        NSMutableArray *insertIndexPaths = [NSMutableArray array];
//        int count=array.count;
//        for (int i=count;i<count+2;i++) {
//            NSIndexPath *newPath = [NSIndexPath indexPathForRow:i inSection:0];
//            [insertIndexPaths addObject:newPath];
//            [array addObject:[NSString stringWithFormat:@"cell + %d",i]];
//        }
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
//                
//                [self.myRefreshControl endRefreshing];
//            });
//       
//    });
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return array.count + 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == array.count) {
        GetMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:GetMoreCell_CellIdentifier];
        if (!cell) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:GetMoreCell_CellIdentifier owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        cell.backgroundColor=[UIColor clearColor];
        cell.moreLabel.hidden=moreLoading;
        cell.loadView.hidden=!moreLoading;
        cell.indicator.hidden=!moreLoading;
        [cell.indicator startAnimating];
        return cell;
    }
    
    static NSString *identifier=@"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
   
	if (!cell) {
		cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier]autorelease];
    }
    cell.textLabel.text=[array objectAtIndex:indexPath.row];
   
    return cell;
}

-(void)tableView:(UITableView *)tableView  willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell isKindOfClass:[GetMoreCell class]]){
        GetMoreCell *moreCell=(GetMoreCell *)cell;
        
        if (array.count >20) {
            moreCell.moreLabel.text=@"没有更多了";
            return;
        }
        [self performSelector:@selector(loadMore:) withObject:moreCell afterDelay:0.5];
    }
}

- (void)loadMore:(GetMoreCell*)moreCell{
    moreCell.moreLabel.hidden=YES;
    moreCell.loadView.hidden=NO;
    moreLoading=YES;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        NSMutableArray *insertIndexPaths = [NSMutableArray array];
        int count=array.count;
        for (int i=count;i<count+2;i++) {
            NSIndexPath *newPath = [NSIndexPath indexPathForRow:i inSection:0];
            [insertIndexPaths addObject:newPath];
            [array addObject:[NSString stringWithFormat:@"cell + %d",i]];
        }
        [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
        
        moreLoading=NO;
        moreCell.moreLabel.hidden=moreLoading;
        moreCell.loadView.hidden=!moreLoading;
        moreCell.indicator.hidden=!moreLoading;
    });
}


@end
