//
//  ForgotPassword.h
//  kenJC
//
//  Created by fiplmacmini2 on 10/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalViewController.h"

@interface ForgotPassword : UIViewController
{
    IBOutlet UITextField *TxtEmail;
    IBOutlet UIScrollView *ScrlForgot;
}
-(IBAction)BtnRecoverAction:(id)sender;
-(IBAction)BtnBackAction:(id)sender;
@end
