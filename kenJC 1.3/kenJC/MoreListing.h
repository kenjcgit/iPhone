//
//  MoreListing.h
//  kenJC
//
//  Created by fiplmacmini2 on 12/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalViewController.h"

@interface MoreListing : UIViewController
{
    IBOutlet UIButton *Btncount;
    
    IBOutlet UIButton *btnlogout;
    IBOutlet UIImageView *imglogoutbg;
    IBOutlet UILabel *lbllogout;
    NSInteger ilogin;
}

- (IBAction)BtnNotificationSetng:(id)sender;
- (IBAction)BtnChangeProfl:(id)sender;
- (IBAction)BtnChangePasswrd:(id)sender;
- (IBAction)BtnLogout:(id)sender;


- (IBAction)BtnEvent:(id)sender;
- (IBAction)BtnNotification:(id)sender;
- (IBAction)BtnContact:(id)sender;

-(IBAction)BtnBusReservationAction:(id)sender;
-(IBAction)BtnCalenderAction:(id)sender;

@end
