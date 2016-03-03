//
//  Change Profile.h
//  kenJC
//
//  Created by fiplmacmini2 on 13/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalViewController.h"

@interface Change_Profile : UIViewController
{
    IBOutlet UITextField *TxtName,*TxtEmail,*TxtPhone,*TxtBDate;
    IBOutlet UIButton *BtnMale,*BtnFemale;
    
    NSDateFormatter *dateformat;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIView *dateView;
    
    NSMutableArray *profileArray;
    
    IBOutlet UIScrollView *ScrlChangeProfile;
}
//ios 8 comaptible picker Action
- (IBAction)hideDatepicker:(id)sender;

-(IBAction)BtnBirthdayAction:(id)sender;
-(IBAction)BtnGenderAction:(id)sender;

-(IBAction)BtnSubmitAction:(id)sender;
-(IBAction)BtnCancelAction:(id)sender;

@end
