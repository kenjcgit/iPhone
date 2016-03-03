//
//  ChangePassword.h
//  kenJC
//
//  Created by fiplmacmini2 on 13/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalViewController.h"

@interface ChangePassword : UIViewController
{
    IBOutlet UIScrollView *ScrlChange;
    IBOutlet UITextField *TxtCurrentPswd,*TxtNewPswd,*TxtRePswd;
}
-(IBAction)BtnSubmitAction:(id)sender;
-(IBAction)BtnCancelAction:(id)sender;
@end
