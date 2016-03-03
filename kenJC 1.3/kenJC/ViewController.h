//
//  ViewController.h
//  kenJC
//
//  Created by fiplmacmini2 on 09/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface ViewController : UIViewController
{
    IBOutlet UIButton *BtnAutoLogion;
    IBOutlet TPKeyboardAvoidingScrollView *ScrlLogin;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@property (weak, nonatomic) IBOutlet UITextField *txtPass;


- (IBAction)SignInClickAction:(id)sender;

- (IBAction)AutoLoginClickAction:(id)sender;

- (IBAction)ForgotPassClickAction:(id)sender;

- (IBAction)SignUpClickAction:(id)sender;

- (IBAction)cancelClickAction:(id)sender;


@end

