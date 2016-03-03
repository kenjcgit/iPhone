//
//  NotificationSetting.h
//  kenJC
//
//  Created by fiplmacmini2 on 13/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalViewController.h"

@interface NotificationSetting : UIViewController
{
    IBOutlet UISwitch *BtnNewEvent,*BtnGeneral,*BtnActivity,*BtnEventReminder,*BtnMuteAll,*BtnAdultActivities,*BtnYouthActivities,*BtnMiniMaccabiActivities,*BtnBogrim,*BtnNonCommunity;
    NSMutableArray *ArrayUser;
}
- (IBAction)NewEventAction:(id)sender;
- (IBAction)GeneralAction:(id)sender;
- (IBAction)ActivityReminderAction:(id)sender;
- (IBAction)EventReminderAction:(id)sender;
- (IBAction)MuteAllAction:(id)sender;
- (IBAction)AdultActivitiesAction:(id)sender;
- (IBAction)YouthActivitiesAction:(id)sender;
- (IBAction)MiniMaccabiActivitiesAction:(id)sender;
- (IBAction)BogrimAction:(id)sender;
- (IBAction)NonCommunityAction:(id)sender;



@end
