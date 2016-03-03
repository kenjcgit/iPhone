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

@interface NotificationSubListing : UIViewController
{
    NSMutableArray *ArrayNotificationList,*ArrayImages;
    IBOutlet UILabel *LblName;
    NSInteger colorindex;
}
@property (strong, nonatomic) IBOutlet UITableView *TableList;
@property(nonatomic,retain)NSString *strtype;
//- (IBAction)BtnContact:(id)sender;
//- (IBAction)BtnEvent:(id)sender;
//- (IBAction)BtnMore:(id)sender;
@end
