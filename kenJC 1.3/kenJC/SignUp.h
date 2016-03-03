//
//  SignUp.h
//  kenJC
//
//  Created by fiplmacmini2 on 09/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalViewController.h"

@interface SignUp : UIViewController
{
    IBOutlet UIScrollView *ScrlSignup;
    IBOutlet UITextField *TxtName,*TxtEmail,*TxtPhone,*TxtBDate,*TxtPswd,*TxtCfnmPswd;
    IBOutlet UIButton *BtnMale,*BtnFemale,*BtnAccept;
    
    NSDateFormatter *dateformat;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIView *dateView;
    
}
//ios 8 comaptible picker Action
- (IBAction)hideDatepicker:(id)sender;

-(IBAction)BtnBirthdayAction:(id)sender;
-(IBAction)BtnSignupAction:(id)sender;
-(IBAction)BtnSignupCancel:(id)sender;
-(IBAction)BtnAcceptAction:(id)sender;
-(IBAction)BtnTermsAction:(id)sender;
-(IBAction)BtnGenderAction:(id)sender;
@end
