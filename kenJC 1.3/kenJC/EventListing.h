//
//  EventListing.h
//  kenJC
//
//  Created by fiplmacmini2 on 11/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalViewController.h"
#import "EGORefreshTableHeaderView.h"

#import "MNMBottomPullToRefreshManager2.h"

@interface EventListing : UIViewController<EGORefreshTableHeaderDelegate,UITableViewDataSource, UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,MNMBottomPullToRefreshManagerClient,UIScrollViewDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes
	BOOL _reloading;

    NSMutableArray *Eventarray,*MainEventArray,*ActivityType,*ArrayLatest,*ArrayImages;
    
    NSInteger activityid;
    
    ///ios 8 comaptible picker outlets
    IBOutlet UIView *viewOther;
    IBOutlet UIPickerView *otherPicker;
    
    IBOutlet UIButton *BtnLatest,*BtnType;
    
    UITapGestureRecognizer *gestureRecognizer;
    NSInteger colorindex;
    
    MNMBottomPullToRefreshManager2 *WallpullToRefreshManager_;
    int intPageNumber;
}
@property (retain, nonatomic) IBOutlet UITableView *tableview;
@property (retain, nonatomic) IBOutlet UIButton *Btncount;

- (IBAction)BtnNotification:(id)sender;
- (IBAction)BtnContact:(id)sender;
- (IBAction)BtnMore:(id)sender;


-(IBAction)BtnLatestAction:(id)sender;
-(IBAction)BtnTypeAction:(id)sender;
//ios 8 comaptible picker Action
-(IBAction)hideOtherpicker:(id)sender;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end
