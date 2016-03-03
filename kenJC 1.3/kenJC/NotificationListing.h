//
//  NotificationListing.h
//  kenJC
//
//  Created by fiplmacmini2 on 12/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalViewController.h"
#import "NotificationListingCell.h"

@interface NotificationListing : UIViewController
{
    NSMutableArray *ArrayNotification,*ArrayNotification2;
    IBOutlet UIButton *Btncount;
}
@property (strong, nonatomic) IBOutlet UITableView *tableview;

- (IBAction)BtnContact:(id)sender;
- (IBAction)BtnEvent:(id)sender;
- (IBAction)BtnMore:(id)sender;
@end
