//
//  ForgotPassword.m
//  kenJC
//
//  Created by fiplmacmini2 on 10/03/15.
//  Copyright (c) 2015 fiplmacmini2. All rights reserved.
//

#import "ForgotPassword.h"

@interface ForgotPassword ()

@end

@implementation ForgotPassword

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [ScrlForgot setContentSize:CGSizeMake(320, 515)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)BtnRecoverAction:(id)sender
{
    if (TxtEmail.text.length==0)
    {
        EMAIL
    }
    else if (![Global validateEmail:TxtEmail.text])
    {
        VALIDEMAIL
    }
    else
    {
        LOADINGSHOW
        [self performSelector:@selector(ForgotJsonAction) withObject:nil afterDelay:0.1f];
    }
}
-(void)ForgotJsonAction
{
    NSString *str=[NSString stringWithFormat:@"[{\"memEmail\":\"%@\"}]",TxtEmail.text];
    
    NSDictionary *dict=@{@"action":@"ForgotPassword",@"json":str};
    
    NSArray *arry=[Global GetParsingData:dict GetKey:@"" GetTimeinterval:0];
    NSLog(@"%@",arry);
    
    LOADINGHIDE
    
    if ([[[arry objectAtIndex:0] valueForKey:@"status"]boolValue])
    {
       FORGOT
    }
    else
    {
        [Global displayTost:@"Try Again."];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)BtnBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
